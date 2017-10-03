//
//  FileManager+LionheartExtensions.swift
//  Pods
//
//  Created by Daniel Loewenherz on 2/8/17.
//
//

import Foundation

public extension FileManager {
    /// A `URL` for a temporary file.
    static func temporaryURL(forFileName fileName: String) -> URL {
        if #available(iOS 10.0, *) {
            return FileManager.default.temporaryDirectory.appendingPathComponent(fileName)
        } else {
            return URL(fileURLWithPath: temporaryPath(forFileName: fileName))
        }
    }

    /// A path `String` for a temporary file.
    static func temporaryPath(forFileName fileName: String) -> String {
        if #available(iOS 10.0, *) {
            return temporaryURL(forFileName: fileName).path
        } else {
            return NSTemporaryDirectory().appending(fileName)
        }
    }
}
