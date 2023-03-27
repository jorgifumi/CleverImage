//
//  MockSignInUseCase.swift
//  CleverApp
//
//  Created by Jorge Lucena on 27/3/23.
//

import CleverImage

final class MockSignInUseCase: SignInUseCase {
    func signIn(username: String, password: String) async -> SignInUseCase.Result {
        .success(Image())
    }
}
