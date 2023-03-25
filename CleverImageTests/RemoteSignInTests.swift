//
//  RemoteSignInTests.swift
//  CleverImageTests
//
//  Created by Jorge Lucena on 25/3/23.
//

import XCTest
import CleverImage

public class RemoteSignIn: SignInUseCase {
    public func signIn(username: String, password: String) async -> SignInUseCase.Result {
        .success(Image())
    }
}

final class RemoteSignInTests: XCTestCase {

    func test_init_doesNotRequestSignIn() {
        let client = HTTPClientSpy()
        _ = RemoteSignIn()

        XCTAssertTrue(client.executedRequests.isEmpty)
    }

    // MARK: - Helpers

    private class HTTPClientSpy: HTTPClient {
        var executedRequests = [URLRequest]()
        
        func execute(urlRequest: URLRequest) async -> HTTPClient.Result {
            executedRequests.append(urlRequest)
            return .success((Data(), HTTPURLResponse()))
        }
    }
}
