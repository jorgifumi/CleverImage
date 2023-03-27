//
//  URLSessionHTTPClient.swift
//  CleverImage
//
//  Created by Jorge Lucena on 27/3/23.
//

import Foundation

public final class URLSessionHTTPClient: HTTPClient {

    private let session: URLSession

    public init(session: URLSession) {
        self.session = session
    }

    private struct UnexpectedValuesRepresentation: Error {}

    public func execute(urlRequest: URLRequest) async -> HTTPClient.Result {
        do {
            let result = try await session.data(for: urlRequest)
            guard let httpURLResponse = result.1 as? HTTPURLResponse else {
                return .failure(UnexpectedValuesRepresentation())
            }

            return .success((data: result.0, response: httpURLResponse))
        } catch {
            return .failure(error)
        }
    }
}
