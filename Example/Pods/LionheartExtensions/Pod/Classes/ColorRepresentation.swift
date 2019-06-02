//
//  ColorRepresentation.swift
//  Pods
//
//  Created by Daniel Loewenherz on 1/13/17.
//
//

import Foundation

/// An easy way to represent colors through hex, RGB, and RGBA values.
public enum ColorRepresentation: ExpressibleByIntegerLiteral, ExpressibleByArrayLiteral, ExpressibleByStringLiteral {
    public typealias IntegerLiteralType = Int
    public typealias Element = Float
    
    public typealias UnicodeScalarLiteralType = StringLiteralType
    public typealias ExtendedGraphemeClusterLiteralType = StringLiteralType
    public typealias StringLiteralType = String
    
    /// A representation of a hexadecimal-encoded color
    case HEX(Int)
    
    /// A representation of a RGB-encoded color
    case RGB(Int, Int, Int)
    
    /// A representation of a RGB-encoded color, with an alpha value
    case RGBA(Int, Int, Int, Float)
    
    /// An invalid color
    case invalid
    
    /**
     Creates a `ColorRepresentation` with the provided hexadecimal value.
     
     ```
     let red: ColorRepresentation = 0xFF0000
     ```
     
     - SeeAlso: `UIColor.init(_:)`
     */
    public init(integerLiteral value: IntegerLiteralType) {
        self = .HEX(value)
    }
    
    /**
     Creates a `ColorRepresentation` from 3 or 4 integer parameters.
     
     ```
     let red: ColorRepresentation = [255, 0, 0]
     ```
     
     - SeeAlso: `UIColor.init(_:)`
     */
    public init(arrayLiteral elements: Element...) {
        let intElements = elements.map { Int($0) }
        switch elements.count {
        case 3: self = .RGB(intElements[0], intElements[1], intElements[2])
        case 4: self = .RGBA(intElements[0], intElements[1], intElements[2], elements[3])
        default: self = .HEX(0)
        }
    }
    
    public init(from string: String) {
        let hexColorRegularExpression = try! NSRegularExpression(pattern: "^#?([0-9A-Fa-f]{6}|[0-9A-Fa-f]{3})$", options: [])
        let rgbColorRegularExpression = try! NSRegularExpression(pattern: "^rgb\\((1?[0-9]{1,2}|2[0-5][0-5]),[ ]*(1?[0-9]{1,2}|2[0-5][0-5]),[ ]*(1?[0-9]{1,2}|2[0-5][0-5])\\)$", options: [])
        let rgbaColorRegularExpression = try! NSRegularExpression(pattern: "^rgba\\((1?[0-9]{1,2}|2[0-5][0-5]),[ ]*(1?[0-9]{1,2}|2[0-5][0-5]),[ ]*(1?[0-9]{1,2}|2[0-5][0-5]),[ ]*(0?\\.\\d+)\\)$", options: [])
        
        let stringValue = string as NSString
        if let match = hexColorRegularExpression.firstMatch(in: string, options: [], range: NSMakeRange(0, string.count)) {
            let group = stringValue.substring(with: match.range(at: 1))
            
            if let integerValue = Int(group, radix: 16) {
                self = .HEX(integerValue)
            } else {
                self = .invalid
            }
        } else {
            var _r: String?
            var _g: String?
            var _b: String?
            var _a: String?
            
            for regex in [rgbColorRegularExpression, rgbaColorRegularExpression] {
                if let match = regex.firstMatch(in: string, options: [], range: NSMakeRange(0, string.count)) {
                    _r = stringValue.substring(with: match.range(at: 1))
                    _g = stringValue.substring(with: match.range(at: 2))
                    _b = stringValue.substring(with: match.range(at: 3))
                    
                    if match.numberOfRanges == 5 {
                        _a = stringValue.substring(with: match.range(at: 4))
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
    }
    
    public init(stringLiteral value: StringLiteralType) {
        self.init(from: value)
    }
    
    public init(extendedGraphemeClusterLiteral value: ExtendedGraphemeClusterLiteralType) {
        self.init(from: value)
    }
    
    public init(unicodeScalarLiteral value: UnicodeScalarLiteralType) {
        self.init(from: value)
    }
}
