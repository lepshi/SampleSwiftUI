//
//  NetworkService.swift
//  DownloadingImage
//
//  Created by Dzmitry Pats on 29.10.24.
//

import Foundation
import UIKit

protocol NetworkServiceSupporting {
    func downloadImage(from urlString: String) async throws -> UIImage?
}

class NetworkService: NetworkServiceSupporting {
    func downloadImage(from urlString: String) async throws -> UIImage? {
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }

        return UIImage(data: data)
    }
}
