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

public func liftOptionalFromAny(_ value: Any) -> Any {
    /**
     If an optional is contained in any `Any` value, this function "lifts" the non-optional value out of it.
    */
    let mirror = Mirror(reflecting: value)
    if mirror.displayStyle != .optional {
        return value
    }

    if mirror.children.count == 0 {
        return NSNull()
    }

    let (_, some) = mirror.children.first!
    return some
}
