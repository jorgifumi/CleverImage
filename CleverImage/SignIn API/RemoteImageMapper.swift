//
//  RemoteImageMapper.swift
//  CleverImage
//
//  Created by Jorge Lucena on 25/3/23.
//

import Foundation

public final class RemoteImageMapper {

    private struct Root: Decodable {
        let image: String
    }

    public enum Error: Swift.Error {
        case invalidData
    }

    public static func map(_ data: Data) throws -> Image {
        guard let root = try? JSONDecoder().decode(Root.self, from: data),
              let imageData = Data(base64Encoded: root.image) else {
            throw Error.invalidData
        }

        return Image(data: imageData)
    }
}
