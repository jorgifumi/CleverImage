//
//  UIImage+TestHelpers.swift
//  CleverImageTests
//
//  Created by Jorge Lucena on 25/3/23.
//

import Foundation
import ImageIO
import UniformTypeIdentifiers

extension Data {
    static func makeImage() -> Data {
        let width = 1
        let height = 1
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.noneSkipLast.rawValue)
        let context = CGContext(data: nil, width: width, height: height, bitsPerComponent: 8, bytesPerRow: width * 4, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)!

        guard let cgImage = context.makeImage() else {
            fatalError("Failed creating CGImage")
        }

        let destinationData = NSMutableData()
        guard let destination = CGImageDestinationCreateWithData(destinationData, UTType.jpeg.identifier as CFString, 1, nil) else {
            fatalError("Failed creating destination")
        }

        CGImageDestinationAddImage(destination, cgImage, nil)

        guard CGImageDestinationFinalize(destination) else {
            fatalError("Failed finalizing destination")
        }

        return destinationData as Data
    }
}
