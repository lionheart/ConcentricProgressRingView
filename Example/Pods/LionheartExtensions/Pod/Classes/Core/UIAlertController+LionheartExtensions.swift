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

public extension UIAlertController {
    /**
     Adds an action to the alert controller with the specified title, style, and handler.
     
     - parameter title: The text to use for the button title. The value you specify should be localized for the user’s current language. This parameter must not be nil.
     - parameter style: Additional styling information to apply to the button. Use the style information to convey the type of action that is performed by the button. For a list of possible values, see the constants in `UIAlertActionStyle`.
     - parameter handler: A block to execute when the user selects the action. This block has no return value and takes the selected action object as its only parameter.
     - author: Daniel Loewenherz
     - copyright: ©2016 Lionheart Software LLC
     - date: February 17, 2016
     */
    public func addAction(withTitle title: String, style: UIAlertActionStyle, handler: ((UIAlertAction) -> Void)?) {
        let action = UIAlertAction(title: title, style: style, handler: handler)
        addAction(action)
    }
}
