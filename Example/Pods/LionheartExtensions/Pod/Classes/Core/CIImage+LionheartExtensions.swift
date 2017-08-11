//
//  CIImage+LionheartExtensions.swift
//  Pods
//
//  Created by Daniel Loewenherz on 5/23/17.
//
//

import Foundation

public extension CIImage {
    var toCGImage: CGImage? {
        return CIContext(options: nil).createCGImage(self, from: extent)
    }

    func rgbValues(atPoint point: CGPoint) -> (red: UInt8, green: UInt8, blue: UInt8, alpha: UInt8)? {
        guard let data = toCGImage?.dataProvider?.data,
            let ptr = CFDataGetBytePtr(data) else {
                return nil
        }

        let bytesPerPixel = 4
        let offset: Int = Int(point.x + point.y * extent.size.width) * bytesPerPixel
        return (ptr[offset], ptr[offset+1], ptr[offset+2], ptr[offset+3])
    }
}
