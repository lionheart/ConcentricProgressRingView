//
//  GCD.swift
//  Pods
//
//  Created by Daniel Loewenherz on 3/7/16.
//
//

import Foundation

public func async(queue: dispatch_queue_t, delay: Double = 0, callback: Void -> Void) {
    if delay > 0 {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (Int64)(delay * Double(NSEC_PER_MSEC))), queue) {
            callback()
        }
    }
    else {
        dispatch_async(queue) {
            callback()
        }
    }
}

public func async_main(delay delay: Double = 0, callback: Void -> Void) {
    async(dispatch_get_main_queue(), delay: delay) {
        callback()
    }
}

public func async_default(delay delay: Double = 0, callback: Void -> Void) {
    async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), delay: delay) {
        callback()
    }
}

public func async_background(delay delay: Double = 0, callback: Void -> Void) {
    async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), delay: delay) {
        callback()
    }
}
