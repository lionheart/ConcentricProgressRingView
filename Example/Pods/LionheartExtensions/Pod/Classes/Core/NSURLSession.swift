//
//  NSURLSession.swift
//  Pods
//
//  Created by Daniel Loewenherz on 2/17/16.
//
//

import Foundation

@available(iOS 9.0, *)
public extension NSURLSession {
    /**
     Cancel all tasks associated with the `NSURLSession`.
     
     - parameter completion: A block to be called after all of the tasks have been cancelled.
     - author: Daniel Loewenherz
     - copyright: ©2016 Lionheart Software LLC
     - date: February 17, 2016
     */
    func cancelAllTasks(completion: () -> Void) {
        getAllTasksWithCompletionHandler { tasks in
            for task in tasks {
                task.cancel()
            }
            
            completion()
        }
    }
}