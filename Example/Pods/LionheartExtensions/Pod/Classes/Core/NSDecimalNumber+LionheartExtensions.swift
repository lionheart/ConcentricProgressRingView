//
//  NSDecimalNumber.swift
//  Pods
//
//  Created by Daniel Loewenherz on 3/16/16.
//
//

import Foundation

/**
 - source: https://gist.github.com/mattt/1ed12090d7c89f36fd28
 */

extension NSDecimalNumber: Comparable {}

public extension NSDecimalNumber {
    /// Returns `true` if two `NSDecimalNumber` values are equal, `false` otherwise.
    static func ==(lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> Bool {
        return lhs.compare(rhs) == .orderedSame
    }

    /// Returns `true` if the first `NSDecimalNumber` parameter is less than the second, `false` otherwise.
    static func <(lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> Bool {
        return lhs.compare(rhs) == .orderedAscending
    }

    /// Returns `true` if the first `NSDecimalNumber` parameter is greater than the second, `false` otherwise.
    static func >(lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> Bool {
        return lhs.compare(rhs) == .orderedDescending
    }

    /// Returns the [additive inverse](https://en.wikipedia.org/wiki/Additive_inverse) of the provided `NSDecimalNumber`.
    static prefix func -(value: NSDecimalNumber) -> NSDecimalNumber {
        return value.multiplying(by: NSDecimalNumber(mantissa: 1, exponent: 0, isNegative: true))
    }

    /// Returns the sum of two `NSDecimalNumber` values.
    static func +(lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> NSDecimalNumber {
        return lhs.adding(rhs)
    }

    /// Returns the difference of two `NSDecimalNumber` values.
    static func -(lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> NSDecimalNumber {
        return lhs.subtracting(rhs)
    }

    /// Returns the product of two `NSDecimalNumber` values.
    static func *(lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> NSDecimalNumber {
        return lhs.multiplying(by: rhs)
    }

    /// Returns the quotient of two `NSDecimalNumber` values.
    static func /(lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> NSDecimalNumber {
        return lhs.dividing(by: rhs)
    }

    /// Returns the result of raising the provided `NSDecimalNumber` to a specified power.
    static func ^(lhs: NSDecimalNumber, rhs: Int) -> NSDecimalNumber {
        return lhs.raising(toPower: rhs)
    }

    // MARK: - Assignment

    static func +=(lhs: inout NSDecimalNumber, rhs: NSDecimalNumber) {
        lhs = lhs + rhs
    }

    static func -=(lhs: inout NSDecimalNumber, rhs: NSDecimalNumber) {
        lhs = lhs - rhs
    }

    static func *=(lhs: inout NSDecimalNumber, rhs: NSDecimalNumber) {
        lhs = lhs * rhs
    }
    
    static func /=(lhs: inout NSDecimalNumber, rhs: NSDecimalNumber) {
        lhs = lhs / rhs
    }
}
