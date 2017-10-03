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

public typealias LayoutDictionary = [String: Any]

/// Auto Layout and general utility methods for `UIView`.
public extension UIView {
    /**
     Remove all subviews of the calling `UIView`.

     - author: Daniel Loewenherz
     - copyright: ©2016 Lionheart Software LLC
     - Date: February 17, 2016
     */
    func removeSubviews() {
        for subview in subviews {
            subview.removeFromSuperview()
        }
    }

    /**
     Center the calling `UIView` on the X-axis, with optional margins to the right and left.

     - author: Daniel Loewenherz
     - copyright: ©2016 Lionheart Software LLC
     - Date: March 9, 2016
     */
    @available(iOS 9, *)
    func centerOnXAxis(width: CGFloat? = nil) {
        centerXAnchor.constraint(equalTo: (superview?.centerXAnchor)!).isActive = true

        guard let width = width else {
            return
        }

        setWidth(width)
    }

    /**
     Center the calling `UIView` on the Y-axis, with optional margins to the top and bottom.

     - author: Daniel Loewenherz
     - copyright: ©2016 Lionheart Software LLC
     - Date: March 9, 2016
     */
    @available(iOS 9, *)
    func centerOnYAxis(height: CGFloat? = nil) {
        centerYAnchor.constraint(equalTo: (superview?.centerYAnchor)!).isActive = true

        guard let height = height else {
            return
        }

        setHeight(height)
    }

    /**
     Set the height of this view to a specified value using Auto Layout.
    
     - parameter height: A `Float` specifying the view's height.
     - author: Daniel Loewenherz
     - copyright: ©2016 Lionheart Software LLC
     - Date: February 17, 2016
     */
    @available(iOS 9, *)
    func setHeight(_ height: CGFloat) {
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    /**
     Set the width of this view to a specified value using Auto Layout.
     
     - parameter width: A `Float` specifying the view's width.
     - author: Daniel Loewenherz
     - copyright: ©2016 Lionheart Software LLC
     - Date: February 17, 2016
     */
    @available(iOS 9, *)
    func setWidth(_ width: CGFloat) {
        widthAnchor.constraint(equalToConstant: width).isActive = true
    }

    /**
     Set the size of the view using Auto Layout.
     
     - parameter size: A `CGSize` specifying the view's size.
     - author: Daniel Loewenherz
     - copyright: ©2016 Lionheart Software LLC
     - Date: February 17, 2016
     */
    @available(iOS 9.0, *)
    func setContentSize(_ size: CGSize) {
        widthAnchor.constraint(equalToConstant: size.width).isActive = true
        heightAnchor.constraint(equalToConstant: size.height).isActive = true
    }

    @available(iOS 9, *)
    func fillHorizontalMarginsOfSuperview(margin: CGFloat = 0) {
        guard let superview = superview else {
            return
        }

        let margins = superview.layoutMarginsGuide
        leftAnchor.constraint(equalTo: margins.leftAnchor, constant: margin).isActive = true
        rightAnchor.constraint(equalTo: margins.rightAnchor, constant: -margin).isActive = true
    }

    /**
     Pin the view's horizontal edges to the left and right of its superview.

     - author: Daniel Loewenherz
     - copyright: ©2016 Lionheart Software LLC
     - Date: February 17, 2016
     */
    @available(iOS 9, *)
    func fillWidthOfSuperview() {
        fillWidthOfSuperview(margin: 0)
    }

    /**
     Pin the view's vertical edges to the top and bottom of its superview.
     
     - author: Daniel Loewenherz
     - copyright: ©2016 Lionheart Software LLC
     - Date: February 17, 2016
     */
    @available(iOS 9, *)
    func fillHeightOfSuperview() {
        fillHeightOfSuperview(margin: 0)
    }

    /**
     Pin the view's horizontal edges to the left and right of its superview with a margin.
     
     - parameter margin: A `CGFloat` representing the horizontal margin.
     - author: Daniel Loewenherz
     - copyright: ©2016 Lionheart Software LLC
     - Date: February 17, 2016
     */
    @available(iOS 9, *)
    func fillWidthOfSuperview(margin: CGFloat) {
        guard let superview = superview else {
            return
        }

        leftAnchor.constraint(equalTo: superview.leftAnchor, constant: margin).isActive = true
        rightAnchor.constraint(equalTo: superview.rightAnchor, constant: -margin).isActive = true
    }

    /**
     Pin the view's vertical edges to the top and bottom of its superview with a margin.
     
     - parameter margin: A `CGFloat` representing the vertical margin.
     - author: Daniel Loewenherz
     - copyright: ©2016 Lionheart Software LLC
     - Date: February 17, 2016
     */
    @available(iOS 9, *)
    func fillHeightOfSuperview(margin: CGFloat) {
        guard let superview = superview else {
            return
        }

        topAnchor.constraint(equalTo: superview.topAnchor, constant: margin).isActive = true
        bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -margin).isActive = true
    }

    /**
     Pin the view's edges to the top, bottom, left, and right of its superview with a margin.
     
     - parameter axis: Optional. Specify only when you want to pin the view to a particular axis.
     - parameter margin: A `CGFloat` representing the vertical margin.
     - author: Daniel Loewenherz
     - copyright: ©2016 Lionheart Software LLC
     - Date: February 17, 2016
     */
    @available(iOS 9, *)
    func fillSuperview(_ axis: UILayoutConstraintAxis? = nil, margin: CGFloat = 0) {
        if let axis = axis {
            switch (axis) {
            case .horizontal:
                fillWidthOfSuperview(margin: margin)

            case .vertical:
                fillHeightOfSuperview(margin: margin)
            }
        }
        else {
            fillWidthOfSuperview(margin: margin)
            fillHeightOfSuperview(margin: margin)
        }
    }

    /**
     Apply the specified visual format constraints to the current view. The "view" placeholder is used in the provided VFL string. Usage can best be illustrated through examples:
     
     Pin a `UIView` to the left and right of its superview with a 20px margin:

     ```
     let view = UIView()
     view.addVisualFormatConstraints("|-20-[view]-20-|")
     ```
     
     Set a view to be at least 36px high, and at least 16px from the top of its superview.
     
     ```
     view.addVisualFormatConstraints("V:|-(>=16)-[view(>36)]")
     ```
     
     - parameter format: The format specification for the constraints. For more information, see Visual Format Language in Auto Layout Guide.
     - author: Daniel Loewenherz
     - copyright: ©2016 Lionheart Software LLC
     - Date: February 17, 2016
     */
    @discardableResult
    func addVisualFormatConstraints(_ format: String, metrics: LayoutDictionary? = nil) -> [NSLayoutConstraint] {
        let views = ["view": self]
        return UIView.addVisualFormatConstraints(format, metrics: metrics, views: views)
    }

    /**
     Apply the VFL format constraints to the specified views, with the provided metrics.
     
     - parameter format: The format specification for the constraints. For more information, see Visual Format Language in Auto Layout Guide.
     - parameter metrics: A dictionary of constants that appear in the visual format string. The dictionary’s keys must be the string values used in the visual format string. Their values must be NSNumber objects.
     - parameter views: A dictionary of views that appear in the visual format string. The keys must be the string values used in the visual format string, and the values must be the view objects.
     - author: Daniel Loewenherz
     - copyright: ©2016 Lionheart Software LLC
     - Date: February 17, 2016
     */
    @discardableResult
    class func addVisualFormatConstraints(_ format: String, metrics: LayoutDictionary? = nil, views: LayoutDictionary) -> [NSLayoutConstraint] {
        let options = NSLayoutFormatOptions(rawValue: 0)
        let constraints = NSLayoutConstraint.constraints(withVisualFormat: format, options: options, metrics: metrics, views: views)

        NSLayoutConstraint.activate(constraints)
        return constraints
    }

    /**
    Return the given distance from a view to a specified `CGPoint`.
    
    - parameter point: The `CGPoint` to measure the distance to.
    - Returns: A `Float` representing the distance to the specified `CGPoint`.
    - author: Daniel Loewenherz
    - copyright: ©2016 Lionheart Software LLC
    - Date: February 17, 2016
    */
    func distance(toPoint point: CGPoint) -> Float {
        if frame.contains(point) {
            return 0
        }

        var closest: CGPoint = frame.origin
        let size = frame.size
        if frame.origin.x + size.width < point.x {
            closest.x += size.width
        }
        else if point.x > frame.origin.x {
            closest.x = point.x
        }
        
        if frame.origin.y + size.height < point.y {
            closest.y += size.height
        }
        else if point.y > frame.origin.y {
            closest.y = point.y
        }

        let a = powf(Float(closest.y-point.y), 2)
        let b = powf(Float(closest.x-point.x), 2)
        return sqrtf(a + b)
    }
    
    // MARK - Misc

    /**
    Returns a 1x1 `CGRect` in the center of the calling `UIView`.

    - Returns: A 1x1 `CGRect`.
    - author: Daniel Loewenherz
    - copyright: ©2016 Lionheart Software LLC
    - Date: March 9, 2016
    */
    var centerRect: CGRect {
        return CGRect(x: center.x, y: center.y, width: 1, height: 1)
    }

    /**
     Return an `Array` of recursive subviews matching the provided test. This method is incredibly helpful in returning all descendants of a given view of a certain type. For instance:

     ```
     let view = UIView()
     let subview = UILabel()
     let label1 = UILabel()
     let label2 = UILabel()
     
     view.addSubview(subview)
     view.addSubview(label1)
     subview.addSubview(label2)
     
     let labels: [UILabel] = view.descendantViewsOfType()
     ```
     
     `labels` will contain both `label1` and `label2`.

     - Returns: An `Array` of `UIView`s of type `T`.
     - author: Daniel Loewenherz
     - copyright: ©2016 Lionheart Software LLC
     - Date: March 9, 2016
     */
    func descendantViewsOfType<T>(passingTest test: (T) -> Bool = { _ in true }) -> [T] {
        var views: [T] = []
        for view in subviews {
            if let view = view as? T, test(view) {
                views.append(view)
            }

            views.append(contentsOf: view.descendantViewsOfType(passingTest: test))
        }
        return views
    }

    /**
     This method simply returns the last object in `descendantViewsOfType(passingTest:)`.

     - Returns: A view of type `T`.
     - author: Daniel Loewenherz
     - copyright: ©2016 Lionheart Software LLC
     - Date: March 9, 2016
     */
    func lastDescendantViewOfType<T>(passingTest test: (T) -> Bool = { i in true }) -> T? {
        return descendantViewsOfType(passingTest: test).last
    }
}

public extension Array where Element: UIView {
    func removeFromSuperviews() {
        forEach { $0.removeFromSuperview() }
    }
}
