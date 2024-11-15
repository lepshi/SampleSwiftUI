//
//  NetworkMonitorMock.swift
//  DownloadingImage
//
//  Created by Dzmitry Pats on 30.10.24.
//

import Foundation
import Combine

final class NetworkMonitorMock: NetworkMonitorSupporter {
    var isConnected: Bool

    init(isConnected: Bool = true) {
        self.isConnected = isConnected
    }

    var isConnectedPublisher: AnyPublisher<Bool, Never> { [isConnected].publisher.eraseToAnyPublisher() }
}
