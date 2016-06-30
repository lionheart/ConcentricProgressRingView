//
//  Functional.swift
//  Pods
//
//  Created by Daniel Loewenherz on 3/9/16.
//
//

import Foundation

public protocol Truthy {
    var truthy: Bool { get }
}

extension Int: Truthy {
    public var truthy: Bool { return self > 0 }
}

extension String: Truthy {
    public var truthy: Bool { return length.truthy }
}

extension Bool: Truthy {
    public var truthy: Bool { return self }
}

extension Optional: Truthy {
    public var truthy: Bool {
        return self != nil
    }
}

public func truthy<T>(item: T) -> Bool {
    if let item = item as? Truthy {
        return item.truthy
    }
    else {
        return false
    }
}

public func all(elements: [AnyObject?], test: (AnyObject? -> Bool) = truthy) -> Bool {
    for element in elements {
        if !test(element) {
            return false
        }
    }
    return true
}

public func any(elements: [AnyObject?], test: (AnyObject? -> Bool) = truthy) -> Bool {
    for element in elements {
        if test(element) {
            return true
        }
    }

    return false
}

public func all<T: Truthy>(elements: [T?], test: (AnyObject? -> Bool)? = nil) -> Bool {
    for element in elements {
        if let element = element {
            if let element = element as? AnyObject, test = test where !test(element) {
                return false
            }
            else if !element.truthy {
                return false
            }
        }
        else if !element.truthy {
            return false
        }
    }

    return true
}

public func any<T: Truthy>(elements: [T?], test: (AnyObject? -> Bool) = truthy) -> Bool {
    for element in elements {
        if let element = element as? AnyObject {
            if test(element) {
                return true
            }
        }
    }

    return false
}

public extension Array {
    func all(@noescape where predicate: Generator.Element throws -> Bool = truthy) rethrows -> Bool {
        for element in self {
            guard try predicate(element) else { return false }
        }
        return true
    }

    func any(@noescape where predicate: Generator.Element throws -> Bool = truthy) rethrows -> Bool {
        for element in self {
            if let result = try? predicate(element) where result {
                return true
            }
        }
        return false
    }
}