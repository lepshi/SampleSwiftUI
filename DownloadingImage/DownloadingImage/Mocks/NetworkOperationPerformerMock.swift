//
//  NetworkOperationPerformerMock.swift
//  DownloadingImage
//
//  Created by Dzmitry Pats on 30.10.24.
//

import Foundation

final class NetworkOperationPerformerMock: NetworkOperationPerformerSupporting {
    func perform(withinSeconds: TimeInterval, closure: @escaping (Bool) async throws -> Void) async {
        return
    }
}
