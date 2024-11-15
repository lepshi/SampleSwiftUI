//
//  Actor+.swift
//  DownloadingImage
//
//  Created by Dzmitry Pats on 30.10.24.
//

import Foundation

extension Actor {
    func isolated<T: Sendable>(_ closure: (isolated Self) -> T) -> T {
        return closure(self)
    }
}
