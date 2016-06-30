//
//  UIViewController.swift
//  Pods
//
//  Created by Daniel Loewenherz on 2/16/16.
//
//

import Foundation

public extension UIViewController {
    /**
     Returns an optional with the top-level `UIViewController`.
     
     - returns: The active `UIViewController`, if it can be found.
     - author: Daniel Loewenherz
     - copyright: ©2016 Lionheart Software LLC
     - date: February 17, 2016
     */
    func topViewController() -> UIViewController? {
        return UIViewController.topViewControllerWithRootViewController(UIApplication.sharedApplication().keyWindow?.rootViewController)
    }

    /**
     Return an optional with the top-level `UIViewController` for the provided `UIViewController`.
     
     - returns: The active `UIViewController`, if it can be found.
     - author: Daniel Loewenherz
     - copyright: ©2016 Lionheart Software LLC
     - date: February 17, 2016
     */
    class func topViewControllerWithRootViewController(rootViewController: UIViewController?) -> UIViewController? {
        if let tabBarController = rootViewController as? UITabBarController {
            return UIViewController.topViewControllerWithRootViewController(tabBarController.selectedViewController)
        }
        else if let navigationController = rootViewController as? UINavigationController {
            return UIViewController.topViewControllerWithRootViewController(navigationController.visibleViewController)
        }
        else if let splitViewController = rootViewController as? UISplitViewController {
            return UIViewController.topViewControllerWithRootViewController(splitViewController.viewControllers[1])
        }
        else if let presentedViewController = rootViewController?.presentedViewController {
            if presentedViewController is UIAlertController {
                return presentedViewController
            }
            else {
                return UIViewController.topViewControllerWithRootViewController(presentedViewController)
            }
        }
        else {
            return rootViewController
        }
    }
}