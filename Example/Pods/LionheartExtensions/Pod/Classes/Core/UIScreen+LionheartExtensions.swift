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

public extension UIScreen {
    /**
     Return a view snapshot containing the status bar.

     - returns: The `UIView` snapshot.
     - author: Daniel Loewenherz
     - copyright: ©2016 Lionheart Software LLC
     - date: February 17, 2016
     */
    var statusBarView: UIView? {
        let view = snapshotView(afterScreenUpdates: true)
        let rect = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height)
        return view.resizableSnapshotView(from: rect, afterScreenUpdates: true, withCapInsets: UIEdgeInsets.zero)
    }
}
