//
//  RemoteSignInTests.swift
//  CleverImageTests
//
//  Created by Jorge Lucena on 25/3/23.
//

import XCTest
import CleverImage
import CommonCrypto

public class RemoteSignIn: SignInUseCase {
    private let url: URL
    private let client: HTTPClient

    enum Error: Swift.Error {
        case encoding
    }

    init(url: URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }

    public func signIn(username: String, password: String) async -> SignInUseCase.Result {
        guard var request = encodedRequest(url: url.appending(path: "/download/bootcamp/image.php"), username: username) else {
            return .failure(Error.encoding)
        }

        request.addValue(sha1(password), forHTTPHeaderField: "Authorization")
        _ = await client.execute(urlRequest: request)
        return .success(Image())
    }

    private func sha1(_ input: String) -> String {
        let inputData = Data(input.utf8)

        var digest = [UInt8](repeating: 0, count: Int(CC_SHA1_DIGEST_LENGTH))

        _ = inputData.withUnsafeBytes {
            CC_SHA1($0.baseAddress, UInt32(inputData.count), &digest)
        }

        return digest.map { String(format: "%02x", $0) }.joined()
    }

    private func encodedRequest(url: URL, username: String) -> URLRequest? {
        let parameters = [
            "username": username
        ]

        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        urlComponents?.queryItems = parameters.map { URLQueryItem(name: $0, value: $1) }

        guard let url = urlComponents?.url else {
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        let bodyString = urlComponents?.percentEncodedQuery ?? ""
        request.httpBody = bodyString.data(using: .utf8)
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

        return request
    }
}

final class RemoteSignInTests: XCTestCase {

    func test_init_doesNotRequestSignIn() {
        let (_, client) = makeSUT()

        XCTAssertTrue(client.executedRequests.isEmpty)
    }

    func test_signIn_executesRequest() async throws {
        let url = anyURL()
        let (sut, client) = makeSUT(url: url)

        _ = await sut.signIn(username: "any username", password: "any password")

        XCTAssertEqual(client.executedRequests.count, 1, "Expected only 1 request executed")

        let executedRequest = try XCTUnwrap(client.executedRequests.first)

        XCTAssertEqual(executedRequest.url?.host, url.host)
        XCTAssertEqual(executedRequest.url?.relativePath, "/download/bootcamp/image.php")
        XCTAssertEqual(executedRequest.httpMethod, "POST")
        XCTAssertEqual(executedRequest.value(forHTTPHeaderField: "Authorization"), "46dc67a55e82ed90920aef03eaba3c7b44b4b452")
        XCTAssertEqual(executedRequest.value(forHTTPHeaderField: "Content-Type"), "application/x-www-form-urlencoded")
        XCTAssertEqual(executedRequest.httpBody, "username=any%20username".data(using: .utf8))
    }

    // MARK: - Helpers

    private func makeSUT(url: URL = anyURL(), file: StaticString = #filePath, line: UInt = #line) -> (sut: RemoteSignIn, client: HTTPClientSpy) {
        let client = HTTPClientSpy()
        let sut = RemoteSignIn(url: url, client: client)
        trackForMemoryLeaks(sut, file: file, line: line)
        trackForMemoryLeaks(client, file: file, line: line)
        return (sut, client)
    }

    private class HTTPClientSpy: HTTPClient {
        var executedRequests = [URLRequest]()

        func execute(urlRequest: URLRequest) async -> HTTPClient.Result {
            executedRequests.append(urlRequest)
            return .success((Data(), HTTPURLResponse()))
        }
    }
}
