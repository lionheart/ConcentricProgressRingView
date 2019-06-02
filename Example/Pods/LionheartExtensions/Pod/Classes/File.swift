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

import Foundation

public final class File {
    public var filename: String?

    public init(_ filename: String) {
        self.filename = filename
    }

    /// The file's full path contained with the documents directory, or `nil` if it does not exist.
    lazy var documentsPath: String? = {
        let paths: [NSString] = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as [NSString]
        guard let path = paths.first,
            let filename = self.filename else {
                return nil
        }

        return path.appendingPathComponent(filename)
    }()

    /// The file's full path contained within the bundle, or `nil` if `filename` is `nil`.
    var bundlePath: String? {
        let bundle = Bundle.main
        guard let filename = filename else {
            return nil
        }

        let components = filename.components(separatedBy: ".")
        return bundle.path(forResource: components[0], ofType: components[1])
    }

    /// Returns the file's contents as a `String`.
    func read() -> String? {
        guard let path = documentsPath ?? bundlePath else {
            return nil
        }

        return try? String(contentsOfFile: path, encoding: .utf8)
    }

    /// A boolean that indicates whether `self` is contained within the app bundle.
    var existsInBundle: Bool {
        guard let path = bundlePath else {
            return false
        }

        return FileManager.default.fileExists(atPath: path)
    }

    /// A boolean that indicates whether `self` is contained within the documents directory.
    var existsInDocuments: Bool {
        guard let path = documentsPath else {
            return false
        }

        return FileManager.default.fileExists(atPath: path)
    }
}

extension File: ExpressibleByStringLiteral {
    public typealias StringLiteralType = String
    public typealias ExtendedGraphemeClusterLiteralType = StringLiteralType
    public typealias UnicodeScalarLiteralType = StringLiteralType

    public convenience init(extendedGraphemeClusterLiteral value: ExtendedGraphemeClusterLiteralType) {
        self.init(value)
    }

    public convenience init(stringLiteral value: StringLiteralType) {
        self.init(value)
    }

    public convenience init(unicodeScalarLiteral value: UnicodeScalarLiteralType) {
        self.init(value)
    }
}
