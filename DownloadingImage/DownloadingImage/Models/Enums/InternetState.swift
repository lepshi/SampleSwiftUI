//
//  InternetState.swift
//  DownloadingImage
//
//  Created by Dzmitry Pats on 28.10.24.
//

import Foundation

enum InternetState: CaseIterable {
    case internetIsNotAvailable
    case failure
    case available

    var text: String {
        switch self {
        case .internetIsNotAvailable: String(localized: "downloadingImageView.internetIsNotAvailable")
        case .failure: String(localized: "downloadingImageView.failure")
        case .available: ""
        }
    }
}
