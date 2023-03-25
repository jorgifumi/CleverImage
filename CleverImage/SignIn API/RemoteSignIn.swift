//
//  RemoteSignIn.swift
//  CleverImage
//
//  Created by Jorge Lucena on 25/3/23.
//

import Foundation
import CommonCrypto

public class RemoteSignIn: SignInUseCase {
    private let url: URL
    private let client: HTTPClient

    enum Error: Swift.Error {
        case encoding
    }

    public init(url: URL, client: HTTPClient) {
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
