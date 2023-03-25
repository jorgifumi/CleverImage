//
//  HTTPClient.swift
//  CleverImage
//
//  Created by Jorge Lucena on 25/3/23.
//

import Foundation

public protocol HTTPClient {
    typealias Result = Swift.Result<(Data, HTTPURLResponse), Error>

    /// The completion handler can be invoked in any thread.
    /// Clients are responsible to dispatch to appropriate threads, if needed.
    func execute(urlRequest: URLRequest) async -> Result
}
