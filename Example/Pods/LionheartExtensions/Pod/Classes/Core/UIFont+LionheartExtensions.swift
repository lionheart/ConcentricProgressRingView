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

let fontDisplayNameRegularExpression = try! NSRegularExpression(pattern: "([a-z])([A-Z])", options: [])

public extension UIFont {
    /**
     Returns a display name for a given `UIFont`.

     - returns: A `String` representing the font name.
     - date: February 17, 2016
     */
    var displayName: String {
        let _fontName = NSMutableString(string: fontName)
        fontDisplayNameRegularExpression.replaceMatches(in: _fontName, options: [], range: _fontName.range, withTemplate: "$1 $2")
        let components = _fontName.components(separatedBy: "-")
        return components.joined(separator: " ")
    }
}
