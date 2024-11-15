//
//  NetworkOperationPerformer.swift
//  DownloadingImage
//
//  Created by Dzmitry Pats on 29.10.24.
//

import Foundation
import Combine

protocol NetworkOperationPerformerSupporting {
    func perform(withinSeconds: TimeInterval, closure: @escaping (_ isEnabled: Bool) async throws -> Void) async
}

public class NetworkOperationPerformer: NetworkOperationPerformerSupporting {

    init(networkMonitor: NetworkMonitorSupporter) {
        self.networkMonitor = networkMonitor
    }
    
    private let networkMonitor: NetworkMonitorSupporter
    private var cancellable = Set<AnyCancellable>()

    public func perform(withinSeconds: TimeInterval, closure: @escaping (_ isEnabled: Bool) async throws -> Void) async {
        let delayedPublisher = Just(false)
            .delay(for: .seconds(withinSeconds), scheduler: DispatchQueue.main)
            .eraseToAnyPublisher()

        let availablePublisher = networkMonitor.isConnectedPublisher.filter{ $0 == true }

        let fastestPublisher = Publishers.Merge(delayedPublisher, availablePublisher)
            .first()

        fastestPublisher.sink { val in
            Task {
                try await closure(val)
            }
        }
        .store(in: &cancellable)
    }
}
