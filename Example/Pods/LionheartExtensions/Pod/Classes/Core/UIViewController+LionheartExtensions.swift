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

import Foundation

public extension UIViewController {
    /**
     Returns an optional with the top-level `UIViewController`.
     
     - returns: The active `UIViewController`, if it can be found.
     - author: Daniel Loewenherz
     - copyright: ©2016 Lionheart Software LLC
     - date: February 17, 2016
     */
    class var topViewController: UIViewController? {
        return topViewControllerWithRootViewController(UIApplication.shared.keyWindow?.rootViewController)
    }

    /**
     Return an optional with the top-level `UIViewController` for the provided `UIViewController`.
     
     - returns: The active `UIViewController`, if it can be found.
     - author: Daniel Loewenherz
     - copyright: ©2016 Lionheart Software LLC
     - date: February 17, 2016
     */
    class func topViewControllerWithRootViewController(_ rootViewController: UIViewController?) -> UIViewController? {
        switch rootViewController {
        case let tabBarController as UITabBarController:
            return topViewControllerWithRootViewController(tabBarController.selectedViewController)

        case let navigationController as UINavigationController:
            return topViewControllerWithRootViewController(navigationController.visibleViewController)

        case let splitViewController as UISplitViewController:
            return topViewControllerWithRootViewController(splitViewController.viewControllers[1])

        case let controller where controller == rootViewController?.presentedViewController:
            if controller is UIAlertController {
                return controller
            } else {
                return topViewControllerWithRootViewController(controller)
            }

        default:
            return rootViewController
        }
    }
}
