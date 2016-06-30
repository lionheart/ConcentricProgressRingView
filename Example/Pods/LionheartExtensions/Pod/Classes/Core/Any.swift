//
//  Any.swift
//  LionheartExtensions
//
//  Created by Daniel Loewenherz on 2/29/16.
//  Copyright © 2016 Lionheart Software LLC. All rights reserved.
//

import Foundation

public func liftOptionalFromAny(value: Any) -> Any {
    /**
     If an optional is contained in any `Any` value, this function "lifts" the non-optional value out of it.
    */
    let mirror = Mirror(reflecting: value)
    if mirror.displayStyle != .Optional {
        return value
    }

    if mirror.children.count == 0 {
        return NSNull()
    }

    let (_, some) = mirror.children.first!
    return some
}
