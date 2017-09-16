//
//  Copyright 2016 Lionheart Software LLC
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
//

import UIKit

public enum VariableNamingFormat {
    case camelCase
    case underscores
    case pascalCase
}

extension CharacterSet: ExpressibleByStringLiteral {
    public typealias StringLiteralType = String
    public typealias UnicodeScalarLiteralType = StringLiteralType
    public typealias ExtendedGraphemeClusterLiteralType = StringLiteralType

    public init(stringLiteral value: StringLiteralType) {
        self.init(charactersIn: value)
    }

    public init(unicodeScalarLiteral value: UnicodeScalarLiteralType) {
        self.init(stringLiteral: value)
    }

    public init(extendedGraphemeClusterLiteral value: ExtendedGraphemeClusterLiteralType) {
        self.init(stringLiteral: value)
    }
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
    var range: NSRange { get }

    var stringByLowercasingFirstLetter: String { get }
    var stringByUppercasingFirstLetter: String { get }
    var stringByReplacingSpacesWithDashes: String { get }

    func stringByConverting(toNamingFormat naming: VariableNamingFormat) -> String
}

public protocol LHSURLStringType {
    var URLEncodedString: String? { get }
}

extension String: LHSStringType, LHSURLStringType {}
extension NSString: LHSStringType {}
extension NSAttributedString: LHSStringType {}

public extension String {
    /// Coerce empty strings to nil.
    var nilIfEmpty: String? {
        guard self != "" else {
            return nil
        }

        return self
    }

    /**
     Returns an `NSRange` indicating the length of the `String`.
     
     - returns: An `NSRange`
     */
    var range: NSRange {
        return NSMakeRange(0, characters.count)
    }

    /**
     Converts an `NSRange` for the current `String` to a a type of `Range<String.Index>`.

     - returns: A range of type `Range<String.Index>`
     */
    func toRange(_ range: NSRange) -> Range<String.Index> {
        let start = characters.index(startIndex, offsetBy: range.location)
        let end = characters.index(start, offsetBy: range.length)
        return start..<end
    }

    /**
     - returns: Returns the length of the current string.
     */
    var length: Int {
        return NSString(string: self).length
    }

    /**
     Trim all characters from the string in the specified character set.
     
     - parameter characterSet: a `CharacterSet` specifying which characters to trim from the string
     */
    mutating func trim(_ characterSet: CharacterSet) {
        self = self.trimmingCharacters(in: characterSet)
    }

    /**
     URL encode the current string.
     */
    mutating func URLEncode() {
        guard let string = URLEncodedString else {
            return
        }

        self = string
    }

    mutating func replaceSpacesWithDashes() {
        self = stringByReplacingSpacesWithDashes
    }

    mutating func replaceCapitalsWithUnderscores() {
        self = stringByConverting(toNamingFormat: .underscores)
    }

    /**
     A copy of the current `String` with the first letter lowercased.
     */
    var stringByLowercasingFirstLetter: String {
        let start = characters.index(after: startIndex)
        return substring(to: start).lowercased() + substring(with: start..<endIndex)
    }

    /**
     A copy of the current `String` with the first letter uppercased.
     */
    var stringByUppercasingFirstLetter: String {
        let start = characters.index(after: startIndex)
        return substring(to: start).uppercased() + substring(with: start..<endIndex)
    }

    /**
     A URL encoded copy of the current `String`.
     */
    var URLEncodedString: String? {
        guard let string = addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return nil
        }

        return string
    }

    /**
     A copy of the current `String` with all spaces replaced with dashes.
     */
    var stringByReplacingSpacesWithDashes: String {
        let options: NSRegularExpression.Options = []
        let regex = try! NSRegularExpression(pattern: "[ ]", options: options)
        return regex.stringByReplacingMatches(in: self, options: [], range: range, withTemplate: "-").lowercased()
    }
    
    func stringByConverting(toNamingFormat naming: VariableNamingFormat) -> String {
        switch naming {
        case .underscores:
            let regex = try! NSRegularExpression(pattern: "([A-Z]+)", options: NSRegularExpression.Options())
            let string = NSMutableString(string: self)
            regex.replaceMatches(in: string, options: [], range: range, withTemplate: "_$0")
            let newString = string.trimmingCharacters(in: "_").lowercased()
            if hasPrefix("_") {
                return "_" + newString
            } else {
                return newString
            }

        case .camelCase:
            // MARK: TODO
            fatalError()

        case .pascalCase:
            var uppercaseNextCharacter = false
            var result = ""
            for character in characters {
                if character == "_" {
                    uppercaseNextCharacter = true
                } else {
                    if uppercaseNextCharacter {
                        result += String(character).uppercased()
                        uppercaseNextCharacter = false
                    } else {
                        character.write(to: &result)
                    }
                }
            }
            return result
        }
    }

    mutating func convert(toNamingFormat naming: VariableNamingFormat) {
        self = stringByConverting(toNamingFormat: naming)
    }

    func isComposedOf(charactersInSet characterSet: CharacterSet) -> Bool {
        for scalar in unicodeScalars where !characterSet.contains(UnicodeScalar(scalar.value)!) {
            return false
        }

        return true
    }
}

public extension NSString {
    /**
     An `NSRange` indicating the length of the `NSString`.
     
     - returns: An `NSRange`
     */
    var range: NSRange {
        return String(self).range
    }

    var stringByLowercasingFirstLetter: String {
        return String(self).stringByLowercasingFirstLetter
    }

    var stringByUppercasingFirstLetter: String {
        return String(self).stringByLowercasingFirstLetter
    }

    var stringByReplacingSpacesWithDashes: String {
        return String(self).stringByReplacingSpacesWithDashes
    }

    public func stringByConverting(toNamingFormat naming: VariableNamingFormat) -> String {
        return String(self).stringByConverting(toNamingFormat: naming)
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
    var range: NSRange {
        return string.range
    }

    var stringByLowercasingFirstLetter: String {
        return string.stringByLowercasingFirstLetter
    }

    var stringByUppercasingFirstLetter: String {
        return string.stringByLowercasingFirstLetter
    }

    var stringByReplacingSpacesWithDashes: String {
        return string.stringByReplacingSpacesWithDashes
    }

    func stringByConverting(toNamingFormat naming: VariableNamingFormat) -> String {
        return string.stringByConverting(toNamingFormat: .underscores)
    }
}

public extension NSMutableAttributedString {
    func addString(withAttributes string: String, attributes: [String: Any]) {
        let attributedString = NSAttributedString(string: string, attributes: attributes)
        append(attributedString)
    }
    
    func addAttribute(_ name: String, value: Any) {
        addAttribute(name, value: value, range: range)
    }
    
    func addAttributes(_ attributes: [String: Any]) {
        addAttributes(attributes, range: range)
    }
    
    func removeAttribute(_ name: String) {
        removeAttribute(name, range: range)
    }
}
