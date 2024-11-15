//
//  DelayedFalse.swift
//  DownloadingImage
//
//  Created by Dzmitry Pats on 04.11.24.
//

import Foundation

protocol DelayedFalseSupporter {
    func falseAfter(delay: TimeInterval) async -> Bool?
}

class DelayedFalse: DelayedFalseSupporter {
    func falseAfter(delay: TimeInterval) async -> Bool? {
        if Task.isCancelled {
            return nil
        }
        try? await Task.sleep(nanoseconds: UInt64(delay * 1_000_000_000))
        if Task.isCancelled {
            return nil
        }
        else {
            return false
        }
    }
}
