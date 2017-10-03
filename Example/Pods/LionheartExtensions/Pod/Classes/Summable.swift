//
//  Summable.swift
//  Pods
//
//  Created by Daniel Loewenherz on 1/16/17.
//
//

import Foundation

public protocol ExpressibleByDecimal {
    var decimalNumber: NSDecimalNumber { get }
    static func makeFromNumber(_ number: NSNumber) -> Self
}

protocol NSNumberBridgeable: ExpressibleByIntegerLiteral, ExpressibleByDecimal {
    var number: NSNumber { get }
    init(_ number: NSNumber)
}

extension NSNumberBridgeable {
    public var decimalNumber: NSDecimalNumber { return NSDecimalNumber(decimal: number.decimalValue) }

    public static func makeFromNumber(_ number: NSNumber) -> Self {
        return Self(number)
    }
}

//

extension Double: NSNumberBridgeable {
    var number: NSNumber { return self as NSNumber }
}

extension Float: NSNumberBridgeable {
    var number: NSNumber { return self as NSNumber }
}

//

extension Int: NSNumberBridgeable {
    var number: NSNumber { return self as NSNumber }
}

extension Int8: NSNumberBridgeable {
    var number: NSNumber { return self as NSNumber }
}

extension Int16: NSNumberBridgeable {
    var number: NSNumber { return self as NSNumber }
}

extension Int32: NSNumberBridgeable {
    var number: NSNumber { return self as NSNumber }
}

extension Int64: NSNumberBridgeable {
    var number: NSNumber { return self as NSNumber }
}

extension UInt: NSNumberBridgeable {
    var number: NSNumber { return self as NSNumber }
}

extension UInt8: NSNumberBridgeable {
    var number: NSNumber { return self as NSNumber }
}

extension UInt16: NSNumberBridgeable {
    var number: NSNumber { return self as NSNumber }
}

extension UInt32: NSNumberBridgeable {
    var number: NSNumber { return self as NSNumber }
}

extension UInt64: NSNumberBridgeable {
    var number: NSNumber { return self as NSNumber }
}

extension NSDecimalNumber: ExpressibleByDecimal {
    public var decimalNumber: NSDecimalNumber { return self }

    public static func makeFromNumber(_ number: NSNumber) -> Self {
        return self.init(decimal: number.decimalValue)
    }
}

extension Array where Element: ExpressibleByDecimal {
    public var sum: Element {
        let value = reduce(0, { $1.decimalNumber.adding($0) })
        return Element.makeFromNumber(value)
    }
}
