//
//  SplashViewModel.swift
//  DownloadingImage
//
//  Created by Dzmitry Pats on 29.10.24.
//

import Foundation
import SwiftUI

enum DownloadingState {
    case internetIsNotAvailable
    case loading
    case success(UIImage)
    case failure
}

class SplashViewModel: ObservableObject {
    init(networkOperationPerformer: NetworkOperationPerformerSupporting,
         networkService: NetworkServiceSupporting,
         networkMonitor: NetworkMonitorSupporter,
         downloadingState: DownloadingState = .loading) {
        self.performer = networkOperationPerformer
        self.networkService = networkService
        self.networkMonitor = networkMonitor
        self.downloadingState = downloadingState

        bind()
    }

    private var performer: NetworkOperationPerformerSupporting
    private var networkService: NetworkServiceSupporting
    private var networkMonitor: NetworkMonitorSupporter

    @Published var downloadingState: DownloadingState
    @Published var isOffline = false

    func downloadImage(from urlString: String) async {
        await performer.perform(withinSeconds: 20) { isEnabled in
            guard isEnabled else {
                await MainActor.run {
                    self.downloadingState = .internetIsNotAvailable
                }
                return
            }
            guard let image = try? await self.networkService.downloadImage(from: urlString) else {
                await MainActor.run {
                    self.downloadingState = .failure
                }
                return
            }
            await MainActor.run {
                self.downloadingState = .success(image)
            }
        }
    }
}

private extension SplashViewModel {
    func bind() {
        networkMonitor.isConnectedPublisher
            .map { !$0 }
            .assign(to: &$isOffline)
    }
}

