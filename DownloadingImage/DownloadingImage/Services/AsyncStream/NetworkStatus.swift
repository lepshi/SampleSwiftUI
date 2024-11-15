//
//  NetworkStatus.swift
//  DownloadingImage
//
//  Created by Dzmitry Pats on 04.11.24.
//

import Foundation
import Network

extension NWPath.Status {
    var isConnected: Bool {
        self != .unsatisfied
    }
}

struct NetworkStatus: AsyncSequence {
    typealias Element = Bool

    func makeAsyncStream() -> AsyncStream<Element> {
        let monitor = NWPathMonitor()
        let monitorQueue = DispatchQueue(label: "com.networkstatus")

        return AsyncStream { continuation in
            monitor.pathUpdateHandler = { path in
                continuation.yield(path.status.isConnected)
            }

            monitor.start(queue: monitorQueue)

            continuation.onTermination = { @Sendable _ in
                monitor.cancel()
            }
        }
    }

    func makeAsyncIterator() -> AsyncStream<Element>.Iterator {
        makeAsyncStream().makeAsyncIterator()
    }
}
