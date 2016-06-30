//
//  UIScreen.swift
//  Pods
//
//  Created by Daniel Loewenherz on 2/16/16.
//
//

import Foundation

public extension UIScreen {
    /**
     Return a view snapshot containing the status bar.

     - returns: The `UIView` snapshot.
     - author: Daniel Loewenherz
     - copyright: ©2016 Lionheart Software LLC
     - date: February 17, 2016
     */
    func statusBarView() -> UIView {
        let view = snapshotViewAfterScreenUpdates(true)
        return view.resizableSnapshotViewFromRect(CGRect(x: 0, y: 0, width: CGRectGetWidth(bounds), height: CGRectGetHeight(bounds)), afterScreenUpdates: true, withCapInsets: UIEdgeInsetsZero)
    }
}