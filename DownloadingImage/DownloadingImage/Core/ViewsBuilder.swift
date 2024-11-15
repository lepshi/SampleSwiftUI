//
//  ViewsBuilder.swift
//  DownloadingImage
//
//  Created by Dzmitry Pats on 30.10.24.
//

import Foundation

import SwiftUI

struct ViewsBuilder {
    private let dependencies: Dependencies

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    func downloadingImageView() -> SplashView {
        SplashView(networkOperationPerformer: dependencies.networkOperationPerformer,
                   networkService: dependencies.networkService,
                   networkMonitor: dependencies.networkMonitor)
    }
}
