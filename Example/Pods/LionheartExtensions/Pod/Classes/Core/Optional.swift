//
//  Optional.swift
//  Pods
//
//  Created by Daniel Loewenherz on 3/9/16.
//
//

import Foundation

public extension Optional where Wrapped: StringLiteralConvertible {
    func nilIfEmpty() -> String? {
        if let value = self as? String {
            if value == "" {
                return nil
            }

            return value
        }
        else {
            return nil
        }
    }
}