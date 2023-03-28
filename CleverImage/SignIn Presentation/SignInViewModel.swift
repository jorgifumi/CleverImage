//
//  SignInViewModel.swift
//  CleverImage
//
//  Created by Jorge Lucena on 28/3/23.
//

import Foundation

public final class SignInViewModel: ObservableObject {
    @Published public var username = ""
    @Published public var password = ""
    @Published public var imageData: Data?
    @Published public var isLoading = false
    @Published public var errorMessage = ""

    private let signInUseCase: SignInUseCase

    public init(signInUseCase: SignInUseCase) {
        self.signInUseCase = signInUseCase
    }

    @MainActor
    public func signIn() async {
        isLoading = true
        errorMessage = ""
        let result = await signInUseCase.signIn(username: username, password: password)
        switch result {
        case .success(let image):
            imageData = image.data
        case .failure:
            signOut()
            errorMessage = "An error ocurred, please try again"
        }
        isLoading = false
    }

    public func signOut() {
        imageData = nil
    }
}

