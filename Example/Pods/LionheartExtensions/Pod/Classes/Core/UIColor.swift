//
//  UIColor.swift
//
//  Created by Daniel Loewenherz on 7/12/15.
//  Copyright © 2015 Lionheart Software. All rights reserved.
//

import UIKit

public enum ColorRepresentation: IntegerLiteralConvertible, ArrayLiteralConvertible, StringLiteralConvertible {
    public typealias IntegerLiteralType = Int
    public typealias Element = Float

    public typealias UnicodeScalarLiteralType = StringLiteralType
    public typealias ExtendedGraphemeClusterLiteralType = StringLiteralType
    public typealias StringLiteralType = String

    case Hex(Int)
    case RGB(Int, Int, Int)
    case RGBA(Int, Int, Int, Float)
    case Invalid

    public init(integerLiteral value: IntegerLiteralType) {
        self = Hex(value)
    }

    public init(arrayLiteral elements: Element...) {
        let intElements = elements.map { Int($0) }
        if elements.count == 3 {
            self = RGB(intElements[0], intElements[1], intElements[2])
        }
        else if elements.count == 4 {
            self = RGBA(intElements[0], intElements[1], intElements[2], elements[3])
        }
        else {
            self = Hex(0)
        }
    }

    public init(stringLiteral value: StringLiteralType) {
        self = ColorRepresentation.valueFromString(value)
    }

    public init(extendedGraphemeClusterLiteral value: ExtendedGraphemeClusterLiteralType) {
        self = ColorRepresentation.valueFromString(value)
    }

    public init(unicodeScalarLiteral value: UnicodeScalarLiteralType) {
        self = ColorRepresentation.valueFromString(value)
    }

    private static func valueFromString(value: String) -> ColorRepresentation {
        let hexColorRegularExpression = try! NSRegularExpression(pattern: "^#?([0-9A-Fa-f]{6}|[0-9A-Fa-f]{3})$", options: NSRegularExpressionOptions())
        let rgbColorRegularExpression = try! NSRegularExpression(pattern: "^rgb\\((1?[0-9]{1,2}|2[0-5][0-5]),[ ]*(1?[0-9]{1,2}|2[0-5][0-5]),[ ]*(1?[0-9]{1,2}|2[0-5][0-5])\\)$", options: NSRegularExpressionOptions())
        let rgbaColorRegularExpression = try! NSRegularExpression(pattern: "^rgba\\((1?[0-9]{1,2}|2[0-5][0-5]),[ ]*(1?[0-9]{1,2}|2[0-5][0-5]),[ ]*(1?[0-9]{1,2}|2[0-5][0-5]),[ ]*(0?\\.\\d+)\\)$", options: NSRegularExpressionOptions())

        let stringValue = value as NSString
        if let match = hexColorRegularExpression.firstMatchInString(value, options: NSMatchingOptions(), range: NSMakeRange(0, value.characters.count)) {
            let group = stringValue.substringWithRange(match.rangeAtIndex(1))

            if let integerValue = Int(group, radix: 16) {
                return .Hex(integerValue)
            }
        }

        var r: String?
        var g: String?
        var b: String?
        var a: String?

        for regex in [rgbColorRegularExpression, rgbaColorRegularExpression] {
            if let match = regex.firstMatchInString(value, options: NSMatchingOptions(), range: NSMakeRange(0, value.characters.count)) {
                r = stringValue.substringWithRange(match.rangeAtIndex(1))
                g = stringValue.substringWithRange(match.rangeAtIndex(2))
                b = stringValue.substringWithRange(match.rangeAtIndex(3))

                if match.numberOfRanges == 5 {
                    a = stringValue.substringWithRange(match.rangeAtIndex(4))
                }
            }
        }

        if let r = r,
            g = g,
            b = b,
            redValue = Int(r),
            greenValue = Int(g),
            blueValue = Int(b) {

            if let a = a,
                alpha = Float(a) {
                return .RGBA(redValue, greenValue, blueValue, alpha)
            }
            else {
                return .RGB(redValue, greenValue, blueValue)
            }
        }
        
        return .Invalid
    }
}

/**
`UIColor` extension.
*/
public extension UIColor {
    /**
     Initialize a `UIColor` object with any number of methods. E.g.
     
     Integer literals:

     ```
     UIColor(0xF00)
     UIColor(0xFF0000)
     UIColor(0xFF0000FF)
     ```
     
     String literals:

     ```
     UIColor("f00")
     UIColor("FF0000")
     UIColor("rgb(255, 0, 0)")
     UIColor("rgba(255, 0, 0, 0.15)")
     ```
     
     Or (preferably), if you want to be a bit more explicit:
     
     ```
     UIColor(.Hex(0xF00))
     UIColor(.RGB(255, 0, 0))
     UIColor(.RGBA(255, 0, 0, 0.5))
     ```
     
     If a provided value is invalid, the color will be white with an alpha value of 0.
     
     - parameter color: a `ColorRepresentation`
     - author: Daniel Loewenherz
     - copyright: ©2016 Lionheart Software LLC
     - date: February 17, 2016
     */
    convenience init(_ color: ColorRepresentation) {
        switch color {
        case .Hex(let value):
            var r: CGFloat!
            var g: CGFloat!
            var b: CGFloat!
            var a: CGFloat!

            value.toRGBA(&r, &g, &b, &a)
            self.init(red: r, green: g, blue: b, alpha: a)

        case .RGB(let r, let g, let b):
            self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: 1)

        case .RGBA(let r, let g, let b, let a):
            self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a))

        case .Invalid:
            self.init(white: 0, alpha: 0)
        }
    }
    
    /**
     Lighten a color by a specified ratio.
     
     - parameter ratio: the ratio by which to lighten the color by.
     - returns: A new `UIColor`.
     - author: Daniel Loewenherz
     - copyright: ©2016 Lionheart Software LLC
     - date: February 17, 2016
     */
    func lighten(ratio: CGFloat) -> UIColor {
        var rgba = [CGFloat](count: 4, repeatedValue: 0)
        getRed(&rgba[0], green: &rgba[1], blue: &rgba[2], alpha: &rgba[3])

        let r = Float(min(rgba[0] + ratio, 1))
        let g = Float(min(rgba[1] + ratio, 1))
        let b = Float(min(rgba[2] + ratio, 1))
        let a = Float(min(rgba[3] + ratio, 1))
        return UIColor(colorLiteralRed: r, green: g, blue: b, alpha: a)
    }

    /**
     Darken a color by a specified ratio.
     
     - parameter ratio: the ratio by which to darken the color by.
     
     - returns: A new `UIColor`.
     - author: Daniel Loewenherz
     - copyright: ©2016 Lionheart Software LLC
     - date: February 17, 2016
     */
    func darken(ratio: CGFloat) -> UIColor {
        var rgba = [CGFloat](count: 4, repeatedValue: 0)
        getRed(&rgba[0], green: &rgba[1], blue: &rgba[2], alpha: &rgba[3])

        let r = Float(max(rgba[0] - ratio, 0))
        let g = Float(max(rgba[1] - ratio, 0))
        let b = Float(max(rgba[2] - ratio, 0))
        let a = Float(max(rgba[3] - ratio, 0))
        return UIColor(colorLiteralRed: r, green: g, blue: b, alpha: a)
    }

    /**
     Indicate whether a given color is dark.

     - returns: A `Bool` indicating if the given `UIColor` is dark.
     - author: Daniel Loewenherz
     - copyright: ©2016 Lionheart Software LLC
     - date: February 17, 2016
     */
    func isDark() -> Bool {
        var rgba = [CGFloat](count: 4, repeatedValue: 0)
        
        let converted = getRed(&rgba[0], green: &rgba[1], blue: &rgba[2], alpha: &rgba[3])
        if !converted {
            return false
        }

        let R = Float(rgba[0])
        let G = Float(rgba[1])
        let B = Float(rgba[2])
        let A = Float(rgba[3])

        // Formula derived from here:
        // http://www.w3.org/WAI/ER/WD-AERT/#color-contrast

        // Alpha blending:
        // http://stackoverflow.com/a/746937/39155
        let newR: Float = (255 * (1 - A) + 255 * R * A) / 255
        let newG: Float = (255 * (1 - A) + 255 * G * A) / 255
        let newB: Float = (255 * (1 - A) + 255 * B * A) / 255
        return ((newR * 255 * 299) + (newG * 255 * 587) + (newB * 255 * 114)) / 1000 < 200
    }
}