//
//  MessageView.swift
//  DownloadingImage
//
//  Created by Dzmitry Pats on 28.10.24.
//

import SwiftUI

struct MessageView: View {
    var text: String

    var body: some View {
        Text(text)
    }
}

#Preview {
    MessageView(text: InternetState.failure.text)
}

#Preview {
    MessageView(text: InternetState.internetIsNotAvailable.text)
}
