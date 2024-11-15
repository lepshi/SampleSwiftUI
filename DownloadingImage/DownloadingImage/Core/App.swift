//
//  DownloadingImageApp.swift
//  DownloadingImage
//
//  Created by Dzmitry Pats on 28.10.24.
//

import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate, ObservableObject {
    lazy var dependencies = Dependencies()
    lazy var viewsBuilder = ViewsBuilder(dependencies: dependencies)

    func application(_: UIApplication,
                     didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        return true
    }
}

@main
struct DownloadingImageApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            delegate.viewsBuilder.downloadingImageView()
        }
    }
}
