//
//  CleverImageViewControllerTests.swift
//  CleverImageViewControllerTests
//
//  Created by Jorge Lucena on 27/3/23.
//

import XCTest
import CleverImageiOS
import CleverImage

final class CleverImageViewControllerTests: XCTestCase {

    func test_init_doesNotSignIn() {
        let signIn = SignInSpy()
        _ = CleverImageViewController(signIn: signIn)

        XCTAssertEqual(signIn.signInCallCount, 0)
    }

    // MARK: - Helpers

    private class SignInSpy: SignInUseCase {

        var signInCallCount: Int = 0

        func signIn(username: String, password: String) async -> SignInUseCase.Result {
            signInCallCount += 1
            return .failure(anyNSError())
        }
    }
}
