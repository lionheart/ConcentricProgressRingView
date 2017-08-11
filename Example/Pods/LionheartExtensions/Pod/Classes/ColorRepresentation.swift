//
//  ColorRepresentation.swift
//  Pods
//
//  Created by Daniel Loewenherz on 1/13/17.
//
//

import Foundation

/**
 An easy way to represent colors through hex, RGB, and RGBA values.

 - author: Daniel Loewenherz
 - copyright: ©2016 Lionheart Software LLC
 - date: December 13, 2016
 */
public enum ColorRepresentation: ExpressibleByIntegerLiteral, ExpressibleByArrayLiteral, ExpressibleByStringLiteral {
    public typealias IntegerLiteralType = Int
    public typealias Element = Float

    public typealias UnicodeScalarLiteralType = StringLiteralType
    public typealias ExtendedGraphemeClusterLiteralType = StringLiteralType
    public typealias StringLiteralType = String

    case HEX(Int)
    case RGB(Int, Int, Int)
    case RGBA(Int, Int, Int, Float)
    case invalid

    public init(integerLiteral value: IntegerLiteralType) {
        self = .HEX(value)
    }

    public init(arrayLiteral elements: Element...) {
        let intElements = elements.map { Int($0) }
        switch elements.count {
        case 3: self = .RGB(intElements[0], intElements[1], intElements[2])
        case 4: self = .RGBA(intElements[0], intElements[1], intElements[2], elements[3])
        default: self = .HEX(0)
        }
    }

    init(fromString string: String) {
        let hexColorRegularExpression = try! NSRegularExpression(pattern: "^#?([0-9A-Fa-f]{6}|[0-9A-Fa-f]{3})$", options: NSRegularExpression.Options())
        let rgbColorRegularExpression = try! NSRegularExpression(pattern: "^rgb\\((1?[0-9]{1,2}|2[0-5][0-5]),[ ]*(1?[0-9]{1,2}|2[0-5][0-5]),[ ]*(1?[0-9]{1,2}|2[0-5][0-5])\\)$", options: NSRegularExpression.Options())
        let rgbaColorRegularExpression = try! NSRegularExpression(pattern: "^rgba\\((1?[0-9]{1,2}|2[0-5][0-5]),[ ]*(1?[0-9]{1,2}|2[0-5][0-5]),[ ]*(1?[0-9]{1,2}|2[0-5][0-5]),[ ]*(0?\\.\\d+)\\)$", options: NSRegularExpression.Options())

        let stringValue = string as NSString
        if let match = hexColorRegularExpression.firstMatch(in: string, options: [], range: NSMakeRange(0, string.characters.count)) {
            let group = stringValue.substring(with: match.rangeAt(1))

            if let integerValue = Int(group, radix: 16) {
                self = .HEX(integerValue)
            }
        }

        var _r: String?
        var _g: String?
        var _b: String?
        var _a: String?

        for regex in [rgbColorRegularExpression, rgbaColorRegularExpression] {
            if let match = regex.firstMatch(in: string, options: [], range: NSMakeRange(0, string.characters.count)) {
                _r = stringValue.substring(with: match.rangeAt(1))
                _g = stringValue.substring(with: match.rangeAt(2))
                _b = stringValue.substring(with: match.rangeAt(3))

                if match.numberOfRanges == 5 {
                    _a = stringValue.substring(with: match.rangeAt(4))
                }
            }
        }

        guard let r = _r,
            let g = _g,
            let b = _b,
            let redValue = Int(r),
            let greenValue = Int(g),
            let blueValue = Int(b) else {
                self = .invalid
                return
        }

        if let a = _a, let alpha = Float(a) {
            self = .RGBA(redValue, greenValue, blueValue, alpha)
        }
        else {
            self = .RGB(redValue, greenValue, blueValue)
        }
    }

    public init(stringLiteral value: StringLiteralType) {
        self.init(fromString: value)
    }

    public init(extendedGraphemeClusterLiteral value: ExtendedGraphemeClusterLiteralType) {
        self.init(fromString: value)
    }

    public init(unicodeScalarLiteral value: UnicodeScalarLiteralType) {
        self.init(fromString: value)
    }
}
