//
//  Image.swift
//  CleverImage
//
//  Created by Jorge Lucena on 25/3/23.
//

import Foundation

public struct Image: Equatable {
    let data: Data

    public init(data: Data = Data()) {
        self.data = data
    }
}
