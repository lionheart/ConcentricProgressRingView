//
//  NSRegularExpression.swift
//  LionheartExtensions
//
//  Created by Daniel Loewenherz on 3/3/16.
//  Copyright © 2016 Lionheart Software LLC. All rights reserved.
//

import Foundation

public extension NSRegularExpression {
    func replaceMatchesInString(inout string: String, options: NSMatchingOptions, range: NSRange, withTemplate templ: String) -> Int {
        let mutableString = NSMutableString(string: string)
        let result = self.replaceMatchesInString(mutableString, options: options, range: range, withTemplate: templ)
        string = String(mutableString)
        return result
    }
}