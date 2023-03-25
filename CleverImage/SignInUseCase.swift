//
//  SignInUseCase.swift
//  CleverImage
//
//  Created by Jorge Lucena on 25/3/23.
//

import Foundation

public protocol SignInUseCase {
    typealias Result = Swift.Result<Image, Error>

    func signIn(username: String, password: String) async -> Result
}
