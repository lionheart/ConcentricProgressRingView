//
//  Bundle+LionheartExtensions.swift
//  Pods
//
//  Created by Daniel Loewenherz on 8/31/17.
//
//

import Foundation

public extension Bundle {
    static var appVersion: String? {
        return main.infoDictionary?["CFBundleShortVersionString"] as? String
    }

    static var appBuildNumber: String? {
        return main.infoDictionary?[kCFBundleVersionKey as String] as? String
    }
}
