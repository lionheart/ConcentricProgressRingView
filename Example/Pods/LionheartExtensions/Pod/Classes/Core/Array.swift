//
//  Array.swift
//  Pods
//
//  Created by Daniel Loewenherz on 5/2/16.
//
//

import Foundation

public extension Array {
    func chunks(size: Int) -> AnyGenerator<[Element]> {
        let indices = startIndex.stride(to: count, by: size)
        var generator = indices.generate()

        return AnyGenerator {
            if let i = generator.next() {
                let j = i.advancedBy(size, limit: self.endIndex)
                return self[i..<j].map { $0 }
            }

            return nil
        }
    }
}