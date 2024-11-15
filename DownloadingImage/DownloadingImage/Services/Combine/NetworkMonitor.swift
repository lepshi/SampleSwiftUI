//
//  NetworkMonitor.swift
//  DownloadingImage
//
//  Created by Dzmitry Pats on 30.10.24.
//

import Foundation
import Network
import Combine

protocol NetworkMonitorSupporter {
    var isConnected: Bool { get }
    var isConnectedPublisher: AnyPublisher<Bool, Never> { get }
}

final class NetworkMonitor {
    private let queue = DispatchQueue(label: "com.networkmonitor")
    private let monitor = NWPathMonitor()
    private let isConnectedSubject = CurrentValueSubject<Bool, Never>(true)

    init() {
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnectedSubject.send(path.status != .unsatisfied)
        }
        monitor.start(queue: queue)
    }

    deinit {
        monitor.cancel()
    }
}

// MARK: - NetworkMonitorSupporter

extension NetworkMonitor: NetworkMonitorSupporter {
    var isConnected: Bool {
        isConnectedSubject.value
    }

    var isConnectedPublisher: AnyPublisher<Bool, Never> {
        isConnectedSubject
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
