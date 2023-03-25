//
//  RemoteSignInTests.swift
//  CleverImageTests
//
//  Created by Jorge Lucena on 25/3/23.
//

import XCTest
import CleverImage

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

    func test_signIn_deliversErrorOnClientError() async {
        let (sut, client) = makeSUT()
        client.result = .failure(anyNSError())

        let result = await sut.signIn(username: "any username", password: "any password")

        switch result {
        case .failure:
            break
        case .success:
            XCTFail("Expected failure, got \(result) instead")
        }
    }

    func test_signIn_deliversErrorOnInvalidData() async {
        let (sut, client) = makeSUT()
        let invalidData = "invalid_data".data(using: .utf8)!
        client.result = .success((invalidData, HTTPURLResponse()))

        let result = await sut.signIn(username: "any username", password: "any password")

        switch result {
        case let .failure(error) where error as? RemoteSignIn.Error == RemoteSignIn.Error.invalidData:
            break
        default:
            XCTFail("Expected invalid data error, got \(result) instead")
        }
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
        var result: HTTPClient.Result = .failure(anyNSError())

        func execute(urlRequest: URLRequest) async -> HTTPClient.Result {
            executedRequests.append(urlRequest)
            return result
        }
    }
}
