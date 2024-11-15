//
//  Dependencies.swift
//  DownloadingImage
//
//  Created by Dzmitry Pats on 30.10.24.
//

import Foundation

final class Dependencies {
    lazy var networkOperationPerformer: NetworkOperationPerformerSupporting = {
        let dic = ProcessInfo.processInfo.environment
        let isStream = dic["AsyncStream"] != nil
        if isStream {
            return NetworkOperationPerformer(networkMonitor: networkMonitor)
        } else {
            return NetworkOperationPerformerAsyncStream(networkStatus: NetworkStatus().makeAsyncStream(), delayedFalse: delayedFalse)
        }
    }()

    lazy var networkService: NetworkServiceSupporting = NetworkService()
    lazy var networkMonitor: NetworkMonitorSupporter = NetworkMonitor()
    lazy var delayedFalse = DelayedFalse()
}
