//
//  SignInView.swift
//  CleverApp
//
//  Created by Jorge Lucena on 27/3/23.
//

import SwiftUI
import CleverImage

struct SignInView: View {

    @StateObject private var viewModel: SignInViewModel

    init(viewModel: SignInViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        VStack {
            if let imageData = viewModel.imageData,
               let uiImage = UIImage(data: imageData) {
                SucessView(uiImage: uiImage, action: viewModel.signOut)
            } else {
                TextField("Username", text: $viewModel.username)
                    .autocorrectionDisabled(true)
                    .autocapitalization(.none)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .textContentType(.username)
                    .disabled(viewModel.isLoading)
                    .padding()

                SecureField("Password", text: $viewModel.password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .textContentType(.password)
                    .disabled(viewModel.isLoading)
                    .padding()

                Button(action: {
                    Task { await viewModel.signIn() }
                }) {
                    if viewModel.isLoading {
                        ProgressView()
                    } else {
                        Text("Sign In")
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.accentColor)
                            .cornerRadius(10)
                    }
                }
                .disabled(viewModel.isLoading)
                .padding()
                ErrorView(errorMessage: viewModel.errorMessage)
            }
        }
        .animation(.easeIn)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(viewModel: SignInViewModel(signInUseCase: MockSignInUseCase()))
    }
}
