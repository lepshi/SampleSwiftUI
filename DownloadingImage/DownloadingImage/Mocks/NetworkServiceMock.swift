//
//  NetworkServiceMock.swift
//  DownloadingImage
//
//  Created by Dzmitry Pats on 29.10.24.
//

import Foundation
import UIKit

final class NetworkServiceMock: NetworkServiceSupporting {
    func downloadImage(from urlString: String) async throws -> UIImage? {
        return nil
    }
}
