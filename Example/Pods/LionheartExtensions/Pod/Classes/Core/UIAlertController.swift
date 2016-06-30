//
//  UIAlertController.swift
//  Pods
//
//  Created by Daniel Loewenherz on 2/17/16.
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
    func addActionWithTitle(title: String, style: UIAlertActionStyle, handler: ((UIAlertAction) -> Void)?) {
        addAction(UIAlertAction(title: title, style: style, handler: handler))
    }
}