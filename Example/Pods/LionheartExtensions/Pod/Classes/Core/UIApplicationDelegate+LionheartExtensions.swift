//
//  UIApplicationDelegate+Extensions.swift
//  LionheartExtensions
//
//  Created by Dan Loewenherz on 2/10/18.
//

import UIKit

public protocol UIApplicationDelegateWithWindow: UIApplicationDelegate {
    var window: UIWindow? { get set }
}

/// Usage: `rootViewController = controller`
public extension UIApplicationDelegateWithWindow {
    var rootViewController: UIViewController? {
        set {
            window = UIWindow(frame: UIScreen.main.bounds)
            window?.rootViewController = newValue
            window?.makeKeyAndVisible()
        }
        
        get {
            return window?.rootViewController
        }
    }
}
