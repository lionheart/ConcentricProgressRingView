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

/// Helper methods for `UIViewController`.
public extension UIViewController {
    /**
     Returns an optional with the top-level `UIViewController`.
     
     - Returns: The active `UIViewController`, if it can be found.
     - Date: February 17, 2016
     */
    class var topViewController: UIViewController? {
        return UIApplication.shared.keyWindow?.rootViewController?.topViewController
    }

    /**
     The top-level `UIViewController` within the hierarchy of `self`'s stack.

     - Date: February 17, 2016
     */
    var topViewController: UIViewController? {
        switch self {
        case let tabBarController as UITabBarController:
            return tabBarController.selectedViewController?.topViewController

        case let navigationController as UINavigationController:
            return navigationController.visibleViewController?.topViewController

        case let splitViewController as UISplitViewController:
            return splitViewController.viewControllers[0].topViewController

        case let controller where controller == presentedViewController:
            if controller is UIAlertController {
                return controller
            } else {
                return controller.topViewController
            }

        default:
            return self
        }
    }
}
