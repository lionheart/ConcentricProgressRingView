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

@available(iOS 9.0, *)
public extension URLSession {
    /**
     Cancel all tasks associated with the `NSURLSession`.

     - parameter completion: A block to be called after all of the tasks have been cancelled.
     - author: Daniel Loewenherz
     - copyright: ©2016 Lionheart Software LLC
     - date: February 17, 2016
     */
    func cancelAllTasks(withCompletion completion: @escaping () -> Void) {
        getAllTasks { tasks in
            for task in tasks {
                task.cancel()
            }
            
            completion()
        }
    }
}
