//
//  String.swift
//  Upriise
//
//  Created by Daniel Loewenherz on 11/13/15.
//  Copyright © 2015 Upriise LLC. All rights reserved.
//

import UIKit

public enum VariableNamingFormat {
    case CamelCase
    case Underscores
    case PascalCase
}

public protocol LHSStringType {
    /**
     Conforming types must provide a getter for the length of the string.
     
     - returns: An `Int` representing the "length" of the string (understood that this can differ based on encoding).
     - author: Daniel Loewenherz
     - copyright: ©2016 Lionheart Software LLC
     - date: February 17, 2016
     */
    var length: Int { get }

    /**
     Conforming types must provide a method to get the full range of the string.
     
     - returns: An `NSRange` representing the entire string.
     - author: Daniel Loewenherz
     - copyright: ©2016 Lionheart Software LLC
     - date: February 17, 2016
     */
    func range() -> NSRange

    func stringByLowercasingFirstLetter() -> String
    func stringByUppercasingFirstLetter() -> String
    func stringByTrimmingString(string: String) -> String
    func stringByReplacingSpacesWithDashes() -> String
    func stringByConvertingToNamingFormat(naming: VariableNamingFormat) -> String
}

public protocol LHSURLStringType {
    func URLEncodedString() -> String?
}

extension String: LHSStringType, LHSURLStringType {}
extension NSString: LHSStringType {}
extension NSAttributedString: LHSStringType {}

public extension String {
    /**
     Returns an `NSRange` indicating the length of the `String`.
     
     - returns: An `NSRange`
     - author: Daniel Loewenherz
     - copyright: ©2016 Lionheart Software LLC
     - date: February 17, 2016
     */
    func range() -> NSRange {
        return NSMakeRange(0, characters.count)
    }

    func toRange(range: NSRange) -> Range<String.Index> {
        let start = startIndex.advancedBy(range.location)
        let end = start.advancedBy(range.length)

        return start..<end
    }

    var length: Int {
        return NSString(string: self).length
    }

    mutating func trim(string: String) {
        self = self.stringByTrimmingString(string)
    }

    mutating func URLEncode() {
        if let string = URLEncodedString() {
            self = string
        }
    }

    mutating func replaceSpacesWithDashes() {
        self = stringByReplacingSpacesWithDashes()
    }

    mutating func replaceCapitalsWithUnderscores() {
        self = stringByConvertingToNamingFormat(.Underscores)
    }

    func stringByLowercasingFirstLetter() -> String {
        let start = startIndex.successor()
        return substringToIndex(start).lowercaseString + substringWithRange(start..<endIndex)
    }

    func stringByUppercasingFirstLetter() -> String {
        let start = startIndex.successor()
        return substringToIndex(start).uppercaseString + substringWithRange(start..<endIndex)
    }

    func stringByTrimmingString(string: String) -> String {
        return self.stringByTrimmingCharactersInSet(NSCharacterSet(charactersInString: string))
    }

    func URLEncodedString() -> String? {
        if let string = stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet()) {
            return string
        }
        else {
            return nil
        }
    }

    func stringByReplacingSpacesWithDashes() -> String {
        let regexOptions = NSRegularExpressionOptions()
        let regex = try! NSRegularExpression(pattern: "[ ]", options: regexOptions)
        return regex.stringByReplacingMatchesInString(self, options: NSMatchingOptions(), range: range(), withTemplate: "-").lowercaseString as String
    }

    @warn_unused_result(mutable_variant="convertToNamingFormat")
    func stringByConvertingToNamingFormat(naming: VariableNamingFormat) -> String {
        switch naming {
        case .Underscores:
            let regex = try! NSRegularExpression(pattern: "([A-Z]+)", options: NSRegularExpressionOptions())
            let string = NSMutableString(string: self)
            regex.replaceMatchesInString(string, options: NSMatchingOptions(), range: range(), withTemplate: "_$0")
            let newString = string.stringByTrimmingString("_").lowercaseString
            if hasPrefix("_") {
                return "_" + newString
            }
            else {
                return newString
            }

        case .CamelCase:
            fatalError()

        case .PascalCase:
            var uppercaseNextCharacter = false
            var result = ""
            for character in characters {
                if character == "_" {
                    uppercaseNextCharacter = true
                }
                else {
                    if uppercaseNextCharacter {
                        result += String(character).uppercaseString
                        uppercaseNextCharacter = false
                    }
                    else {
                        character.writeTo(&result)
                    }
                }
            }
            return result
        }
    }

    mutating func convertToNamingFormat(naming: VariableNamingFormat) {
        self = stringByConvertingToNamingFormat(naming)
    }

    func isComposedOfCharactersInSet(characterSet: NSCharacterSet) -> Bool {
        for scalar in unicodeScalars {
            if !characterSet.longCharacterIsMember(scalar.value) {
                return false
            }
        }

        return true
    }
}

public extension NSString {
    /**
     Returns an `NSRange` indicating the length of the `NSString`.
     
     - returns: An `NSRange`
     - author: Daniel Loewenherz
     - copyright: ©2016 Lionheart Software LLC
     - date: February 17, 2016
     */
    func range() -> NSRange {
        return String(self).range()
    }
    
    func slugify() {
        return String(self).slugify()
    }

    func stringByLowercasingFirstLetter() -> String {
        return String(self).stringByLowercasingFirstLetter()
    }

    func stringByUppercasingFirstLetter() -> String {
        return String(self).stringByLowercasingFirstLetter()
    }

    func stringByReplacingSpacesWithDashes() -> String {
        return String(self).stringByReplacingSpacesWithDashes()
    }

    func stringByConvertingToNamingFormat(naming: VariableNamingFormat) -> String {
        return String(self).stringByConvertingToNamingFormat(naming)
    }

    func stringByTrimmingString(string: String) -> String {
        return String(self).stringByTrimmingString(string)
    }
}

public extension NSAttributedString {
    /**
     Returns an `NSRange` indicating the length of the `NSAttributedString`.
     
     - returns: An `NSRange`
     - author: Daniel Loewenherz
     - copyright: ©2016 Lionheart Software LLC
     - date: February 17, 2016
     */
    func range() -> NSRange {
        return String(self).range()
    }

    func stringByLowercasingFirstLetter() -> String {
        return String(self).stringByLowercasingFirstLetter()
    }

    func stringByUppercasingFirstLetter() -> String {
        return String(self).stringByLowercasingFirstLetter()
    }

    func stringByReplacingSpacesWithDashes() -> String {
        return String(self).stringByReplacingSpacesWithDashes()
    }

    func stringByConvertingToNamingFormat(naming: VariableNamingFormat) -> String {
        return String(self).stringByConvertingToNamingFormat(.Underscores)
    }

    func stringByTrimmingString(string: String) -> String {
        return String(self).stringByTrimmingString(string)
    }
}

public extension NSMutableAttributedString {
    func addStringWithAttributes(string: String, attributes: [String: AnyObject]) {
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        appendAttributedString(attributedString)
    }
    
    func addAttribute(name: String, value: AnyObject) {
        addAttribute(name, value: value, range: range())
    }
    
    func addAttributes(attributes: [String: AnyObject]) {
        addAttributes(attributes, range: range())
    }
    
    func removeAttribute(name: String) {
        removeAttribute(name, range: range())
    }
}
