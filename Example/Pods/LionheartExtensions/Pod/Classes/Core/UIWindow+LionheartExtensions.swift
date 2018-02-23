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

/// Helper methods for `UIWindow`.
public extension UIWindow {
    /**
     Take a screenshot and save to the specified file path. Helpful for creating screenshots via automated tests.
     
     - parameter path: The path on the local filesystem to save the screenshot to.
     - Returns: A bool indicating whether the save was successful.
     - author: Daniel Loewenherz
     - copyright: ©2016 Lionheart Software LLC
     - Date: February 17, 2016
     */
    class func takeScreenshotAndSaveToPath(_ path: String) -> Bool {
        guard let window = LionheartExtensions.sharedUIApplication?.keyWindow else {
            return false
        }

        let bounds = window.bounds
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0)
        window.drawHierarchy(in: bounds, afterScreenUpdates: true)
        let _image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        guard let image = _image,
            let data = UIImagePNGRepresentation(image) else {
                return false
        }

        let url = URL(fileURLWithPath: path)

        guard let _ = try? data.write(to: url, options: []) else {
            return false
        }

        return true
    }
}
