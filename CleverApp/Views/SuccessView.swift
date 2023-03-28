//
//  SuccessView.swift
//  CleverApp
//
//  Created by Jorge Lucena on 28/3/23.
//

import SwiftUI

struct SucessView: View {
    let uiImage: UIImage
    let action: () -> Void

    init(uiImage: UIImage, action: @escaping () -> Void) {
        self.uiImage = uiImage
        self.action = action
    }

    var body: some View {
        VStack {
            Image(uiImage: uiImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(10)
                .padding()
            Button(action: action) {
                Text("Sign out")
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.accentColor)
                    .cornerRadius(10)
            }
        }
    }
}
