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
    static func ==(lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> Bool {
        return lhs.compare(rhs) == .orderedSame
    }

    static func <(lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> Bool {
        return lhs.compare(rhs) == .orderedAscending
    }

    static func >(lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> Bool {
        return lhs.compare(rhs) == .orderedDescending
    }

    static prefix func -(value: NSDecimalNumber) -> NSDecimalNumber {
        return value.multiplying(by: NSDecimalNumber(mantissa: 1, exponent: 0, isNegative: true))
    }

    static func +(lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> NSDecimalNumber {
        return lhs.adding(rhs)
    }

    static func -(lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> NSDecimalNumber {
        return lhs.subtracting(rhs)
    }

    static func *(lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> NSDecimalNumber {
        return lhs.multiplying(by: rhs)
    }

    static func /(lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> NSDecimalNumber {
        return lhs.dividing(by: rhs)
    }

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
