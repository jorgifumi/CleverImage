//
//  SharedTestHelpers.swift
//  CleverImageTests
//
//  Created by Jorge Lucena on 25/3/23.
//

import Foundation

func anyURL() -> URL {
    URL(string: "http://any-url.com")!
}

func anyNSError() -> NSError {
    NSError(domain: "any error", code: 0)
}
