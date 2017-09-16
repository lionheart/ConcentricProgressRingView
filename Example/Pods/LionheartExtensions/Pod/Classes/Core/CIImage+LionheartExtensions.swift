//
//  CIImage+LionheartExtensions.swift
//  Pods
//
//  Created by Daniel Loewenherz on 5/23/17.
//
//

import Foundation

public extension CIImage {
    /**
     - returns: A CGImage that represents the current CIImage.
     - date: May 24, 2017
     */
    var toCGImage: CGImage? {
        return CIContext(options: nil).createCGImage(self, from: extent)
    }

    /**
     Calculate the RGBA values for the specified point in a CIImage.

     - parameter point: A `CGPoint` in the `CIImage` to extract RGBA information.
     - returns: A tuple containing red, green, blue, and alpha values at the specified point if they could be extracted, or a `nil` value otherwise.
     - date: May 24, 2017
     */
    func rgbValues(atPoint point: CGPoint) -> (red: UInt8, green: UInt8, blue: UInt8, alpha: UInt8)? {
        guard let data = toCGImage?.dataProvider?.data,
            let ptr = CFDataGetBytePtr(data) else {
                return nil
        }

        let bytesPerPixel = 4
        let offset = Int(point.x + point.y * extent.size.width) * bytesPerPixel
        return (ptr[offset], ptr[offset+1], ptr[offset+2], ptr[offset+3])
    }
}
