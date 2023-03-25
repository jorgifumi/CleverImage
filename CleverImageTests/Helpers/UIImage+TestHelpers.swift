//
//  UIImage+TestHelpers.swift
//  CleverImageTests
//
//  Created by Jorge Lucena on 25/3/23.
//

import Foundation
import ImageIO

extension Data {
    static func makeImage() -> Data {
        // Crea un contexto de gráficos de tamaño 100x100 píxeles
        let width = 100
        let height = 100
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.noneSkipLast.rawValue)
        let context = CGContext(data: nil, width: width, height: height, bitsPerComponent: 8, bytesPerRow: width * 4, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)!

        guard let cgImage = context.makeImage() else {
            fatalError("No se puede crear el CGImage")
        }

        let destinationData = NSMutableData()
        guard let destination = CGImageDestinationCreateWithData(destinationData, kUTTypeJPEG, 1, nil) else {
            fatalError("No se puede crear el destino de la imagen")
        }

        CGImageDestinationAddImage(destination, cgImage, nil)

        guard CGImageDestinationFinalize(destination) else {
            fatalError("No se puede finalizar el destino de la imagen")
        }

        // El resultado está en la variable "destinationData"
        return destinationData as Data
    }
}
