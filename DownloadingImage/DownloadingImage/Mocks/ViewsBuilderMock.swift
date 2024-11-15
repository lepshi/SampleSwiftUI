//
//  ViewsBuilderMock.swift
//  DownloadingImage
//
//  Created by Dzmitry Pats on 30.10.24.
//

import SwiftUI

final class ViewsBuilderMock {
    static func downloadingImageViewMock(downloadingState: DownloadingState = .loading) -> SplashView {
        SplashView(networkOperationPerformer: NetworkOperationPerformerMock(),
                   networkService: NetworkServiceMock(),
                   networkMonitor: NetworkMonitorMock(),
                   downloadingState: downloadingState)
    }
}
