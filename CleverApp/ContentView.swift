//
//  ContentView.swift
//  CleverApp
//
//  Created by Jorge Lucena on 27/3/23.
//

import SwiftUI
import CleverImage

struct ContentView: View {
    let signInUseCase: SignInUseCase

    init(signInUseCase: SignInUseCase) {
        self.signInUseCase = signInUseCase
    }

    var body: some View {
        VStack {
            SignInView(signInUseCase: signInUseCase)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(signInUseCase: MockSignInUseCase())
    }
}
