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

import UIKit

/**
 `UIColor` extension.
*/
public extension UIColor {
    /**
     Helper method to instantiate a `UIColor` object any number of ways. E.g.
     
     With integer literals:

     ```
     UIColor(0xF00)
     UIColor(0xFF0000)
     UIColor(0xFF0000FF)
     ```
     
     Or string literals:

     ```
     UIColor("f00")
     UIColor("FF0000")
     UIColor("rgb(255, 0, 0)")
     UIColor("rgba(255, 0, 0, 0.15)")
     ```
     
     Or (preferably), if you want to be a bit more explicit:
     
     ```
     UIColor(.HEX(0xFF0000))
     UIColor(.RGB(255, 0, 0))
     UIColor(.RGBA(255, 0, 0, 0.5))
     ```
     
     If a provided value is invalid, the color will be white with an alpha value of 0.
     
     - parameter color: a `ColorRepresentation`
     */
    convenience init(_ color: ColorRepresentation) {
        switch color {
        case .HEX(let value):
            var r: CGFloat!
            var g: CGFloat!
            var b: CGFloat!
            var a: CGFloat!

            value.toRGBA(&r, &g, &b, &a)
            self.init(red: r, green: g, blue: b, alpha: a)

        case .RGB(let r, let g, let b):
            self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: 1)

        case .RGBA(let r, let g, let b, let a):
            self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a))

        case .invalid:
            self.init(white: 0, alpha: 0)
        }
    }
    
    /// Returns a `UIColor` with each color component of `self` lightened by `ratio`.
    func lighten(byRatio ratio: CGFloat) -> UIColor {
        var R: CGFloat = 0
        var B: CGFloat = 0
        var G: CGFloat = 0
        var A: CGFloat = 0
        getRed(&R, green: &G, blue: &B, alpha: &A)

        let r = min(R * (1 + ratio), 1)
        let g = min(G * (1 + ratio), 1)
        let b = min(B * (1 + ratio), 1)
        let a = min(A * (1 + ratio), 1)
        return UIColor(red: r, green: g, blue: b, alpha: a)
    }

    /// Returns a `UIColor` with each color component of `self` darkened by `ratio`.
    func darken(byRatio ratio: CGFloat) -> UIColor {
        var R: CGFloat = 0
        var B: CGFloat = 0
        var G: CGFloat = 0
        var A: CGFloat = 0
        getRed(&R, green: &G, blue: &B, alpha: &A)

        let r = max(R * (1 - ratio), 0)
        let g = max(G * (1 - ratio), 0)
        let b = max(B * (1 - ratio), 0)
        let a = max(A * (1 - ratio), 0)
        return UIColor(red: r, green: g, blue: b, alpha: a)
    }

    /**
     A bool that indicates whether the color is dark.

     - Note: Formula for brightness derived from [W3C Techniques For Accessibility Evaluation And Repair Tools](http://www.w3.org/WAI/ER/WD-AERT/#color-contrast), and formula for alpha-blending attributed to [StackOverflow](http://stackoverflow.com/a/746937/39155).
     */
    var isDark: Bool {
        var R1: CGFloat = 0
        var B1: CGFloat = 0
        var G1: CGFloat = 0
        var A1: CGFloat = 0

        let converted = getRed(&R1, green: &G1, blue: &B1, alpha: &A1)
        guard converted else {
            return false
        }

        let R = Float(R1)
        let G = Float(G1)
        let B = Float(B1)
        let A = Float(A1)

        // Formula derived from here:
        // http://www.w3.org/WAI/ER/WD-AERT/#color-contrast

        // Alpha blending:
        // http://stackoverflow.com/a/746937/39155
        let newR: Float = (255 * (1 - A) + 255 * R * A) / 255
        let newG: Float = (255 * (1 - A) + 255 * G * A) / 255
        let newB: Float = (255 * (1 - A) + 255 * B * A) / 255
        let newR1: Float = (newR * 255 * 299)
        let newG1: Float = (newG * 255 * 587)
        let newB1: Float = (newB * 255 * 114)
        return ((newR1 + newG1 + newB1) / 1000) < 200
    }
}
