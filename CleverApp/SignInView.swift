//
//  SignInView.swift
//  CleverApp
//
//  Created by Jorge Lucena on 27/3/23.
//

import SwiftUI
import CleverImage

struct SignInView: View {
    @State private var username = ""
    @State private var password = ""

    private var signInUseCase: SignInUseCase

    init(signInUseCase: SignInUseCase) {
        self.signInUseCase = signInUseCase
    }

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            TextField("Username", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button(action: {
                Task {
                    let result = await signInUseCase.signIn(username: username, password: password)
                    switch result {
                    case .success(let image):
                        break
                    case .failure(let error):
                        break
                    }
                }
            }) {
                Text("Sign In")
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(signInUseCase: MockSignInUseCase())
    }
}
