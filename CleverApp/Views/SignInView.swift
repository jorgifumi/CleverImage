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
    @State private var image: CleverImage.Image?
    @State private var isLoading = false
    @State private var errorMessage = ""

    private var signInUseCase: SignInUseCase

    init(signInUseCase: SignInUseCase) {
        self.signInUseCase = signInUseCase
    }

    var body: some View {
        VStack {
            if let image,
               let uiImage = UIImage(data: image.data) {
                SucessView(uiImage: uiImage, action: signOut)
            } else {
                TextField("Username", text: $username)
                    .autocorrectionDisabled(true)
                    .autocapitalization(.none)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .textContentType(.username)
                    .disabled(isLoading)
                    .padding()

                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .textContentType(.password)
                    .disabled(isLoading)
                    .padding()

                Button(action: {
                    signIn()
                }) {
                    if isLoading {
                        ProgressView()
                    } else {
                        Text("Sign In")
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.accentColor)
                            .cornerRadius(10)
                    }
                }
                .disabled(isLoading)
                .padding()
                ErrorView(errorMessage: errorMessage)
            }
        }
        .animation(.easeIn)
    }

    private func signIn() {
        isLoading = true
        Task {
            let result = await signInUseCase.signIn(username: username, password: password)
            switch result {
            case .success(let image):
                self.image = image
                errorMessage = ""
            case .failure(let error):
                signOut()
                errorMessage = error.localizedDescription
            }
            isLoading = false
        }
    }

    private func signOut() {
        self.image = nil
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(signInUseCase: MockSignInUseCase())
    }
}
