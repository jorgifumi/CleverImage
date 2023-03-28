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
    @State private var imageData: Data = Data() {
        didSet {
            presentSheet = !imageData.isEmpty
        }
    }
    @State private var isLoading = false
    @State private var errorMessage = ""
    @State private var presentSheet: Bool = false

    private var signInUseCase: SignInUseCase

    init(signInUseCase: SignInUseCase) {
        self.signInUseCase = signInUseCase
    }

    var body: some View {
        VStack {
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
            Text(errorMessage)
                .font(.caption)
                .foregroundColor(.red)
        }
        .animation(.easeIn)
        .sheet(isPresented: $presentSheet) {
            Image(data: imageData)?
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding()
        }
    }

    private func signIn() {
        isLoading = true
        Task {
            let result = await signInUseCase.signIn(username: username, password: password)
            switch result {
            case .success(let image):
                self.imageData = image.data
                errorMessage = ""
            case .failure(let error):
                self.imageData = Data()
                errorMessage = error.localizedDescription
            }
            isLoading = false
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(signInUseCase: MockSignInUseCase())
    }
}
