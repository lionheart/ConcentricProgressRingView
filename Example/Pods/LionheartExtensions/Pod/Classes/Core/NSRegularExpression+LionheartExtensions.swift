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

public extension NSRegularExpression {
    func replaceMatchesInString(_ string: inout String, options: NSRegularExpression.MatchingOptions, range: NSRange, withTemplate templ: String) -> Int {
        let mutableString = NSMutableString(string: string)
        let result = replaceMatches(in: mutableString, options: options, range: range, withTemplate: templ)
        string = String(mutableString)
        return result
    }
}
