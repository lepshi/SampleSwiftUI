//
//  SpinnerView.swift
//  DownloadingImage
//
//  Created by Dzmitry Pats on 28.10.24.
//

import SwiftUI

struct SpinnerView: View {
    @Binding var isOffline: Bool

    var body: some View {
        VStack {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                .scaleEffect(2.0, anchor: .center)
                .padding(.bottom)
            if isOffline {
                Text(InternetState.internetIsNotAvailable.text)
            }
        }
    }
}

#Preview {
    SpinnerView(isOffline: .constant(true))
}

#Preview {
    SpinnerView(isOffline: .constant(false))
}
