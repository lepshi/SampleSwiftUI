//
//  SingleImageView.swift
//  DownloadingImage
//
//  Created by Dzmitry Pats on 28.10.24.
//

import SwiftUI

struct SingleImageView: View {
    var uiImage: UIImage
    var body: some View {
        Image(uiImage: uiImage)
            .resizable()
            .scaledToFit()
    }
}

#Preview {
    SingleImageView(uiImage: UIImage(named: "albaTeam")!)
}
