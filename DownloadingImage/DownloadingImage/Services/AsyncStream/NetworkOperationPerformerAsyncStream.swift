//
//  NetworkOperationPerformerAsyncStream.swift
//  DownloadingImage
//
//  Created by Dzmitry Pats on 04.11.24.
//

import Foundation

public class NetworkOperationPerformerAsyncStream: NetworkOperationPerformerSupporting {

    internal init(networkStatus: AsyncStream<Bool>,
                  delayedFalse: DelayedFalseSupporter) {
        self.networkStatus = networkStatus
        self.delayedFalse = delayedFalse
    }
    
    private let networkStatus: AsyncStream<Bool>
    private let delayedFalse: DelayedFalseSupporter

    func perform(withinSeconds: TimeInterval, closure: @escaping (Bool) async throws -> Void) async {
        let val = try? await getFirstValue(networkStatus: networkStatus, delayedFalse: delayedFalse, withinSeconds: withinSeconds)
        guard let valU = val else { return }
        try? await closure(valU)
    }

    func getFirstValue(networkStatus: AsyncStream<Bool>, delayedFalse: DelayedFalseSupporter, withinSeconds: TimeInterval) async throws -> Bool? {
        await withTaskGroup(of: Bool?.self) { group in
            group.addTask {
                for await value in networkStatus {
                    guard value else { continue }
                    return value
                }
                return nil
            }
            group.addTask {
                let result = await self.delayedFalse.falseAfter(delay: withinSeconds)
                return result
            }
            if let result = await group.next() {
                group.cancelAll()
                return result
            }
            return nil
        }
    }
}
