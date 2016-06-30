//
//  NSDate.swift
//  LionheartExtensions
//
//  Created by Daniel Loewenherz on 3/3/16.
//  Copyright © 2016 Lionheart Software LLC. All rights reserved.
//

import UIKit

extension NSDate: Comparable { }

public func <=(lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.compare(rhs) != .OrderedDescending
}

public func >=(lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.compare(rhs) != .OrderedAscending
}

public func >(lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.compare(rhs) == .OrderedDescending
}

public func <(lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.compare(rhs) == .OrderedAscending
}