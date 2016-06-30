//
//  NSIndexPath.swift
//  Pods
//
//  Created by Daniel Loewenherz on 4/1/16.
//
//

import Foundation

public func ==(tuple: (Int, Int), indexPath: NSIndexPath) -> Bool {
    return indexPath.section == tuple.0 && indexPath.row == tuple.1
}

public func ==(indexPath: NSIndexPath, tuple: (Int, Int)) -> Bool {
    return indexPath.section == tuple.0 && indexPath.row == tuple.1
}