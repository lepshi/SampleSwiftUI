//
//  SplashView.swift
//  DownloadingImage
//
//  Created by Dzmitry Pats on 28.10.24.
//

import SwiftUI

struct SplashView: View {
    @StateObject private var viewModel: SplashViewModel

    init(networkOperationPerformer: NetworkOperationPerformerSupporting,
         networkService: NetworkServiceSupporting,
         networkMonitor: NetworkMonitorSupporter,
         downloadingState: DownloadingState = .loading) {

        self._viewModel = StateObject(
            wrappedValue: SplashViewModel(
                networkOperationPerformer: networkOperationPerformer,
                networkService: networkService,
                networkMonitor: networkMonitor,
                downloadingState: downloadingState))
    }

    var body: some View {
        Color.Background.loading
            .ignoresSafeArea()
            .overlay {
                mainView()
            }
            .task {
                await viewModel.downloadImage(from: imageUrlString)
            }
    }
}

private extension SplashView {
    @ViewBuilder
    func mainView() -> some View {
        switch viewModel.downloadingState {
        case .internetIsNotAvailable:
            MessageView(text: InternetState.internetIsNotAvailable.text)
        case .loading:
            SpinnerView(isOffline: $viewModel.isOffline)
        case let .success(uiImage):
            SingleImageView(uiImage: uiImage)
        case .failure:
            MessageView(text: InternetState.failure.text)
        }
    }
}

#Preview {
    ViewsBuilderMock.downloadingImageViewMock(downloadingState: .success(UIImage(named: "albaTeam")!))
}

#Preview {
    ViewsBuilderMock.downloadingImageViewMock()
}

#Preview {
    ViewsBuilderMock.downloadingImageViewMock(downloadingState: .internetIsNotAvailable)
}

#Preview {
    ViewsBuilderMock.downloadingImageViewMock(downloadingState: .failure)
}
