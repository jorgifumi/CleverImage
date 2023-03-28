//
//  ErrorView.swift
//  CleverApp
//
//  Created by Jorge Lucena on 28/3/23.
//

import SwiftUI

struct ErrorView: View {

    let errorMessage: String

    init(errorMessage: String) {
        self.errorMessage = errorMessage
    }

    var body: some View {
        Text(errorMessage)
            .font(.caption)
            .foregroundColor(.red)
    }
}
