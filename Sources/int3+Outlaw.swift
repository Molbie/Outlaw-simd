//
//  int3+Outlaw.swift
//  OutlawSimd
//
//  Created by Brian Mullen on 12/11/16.
//  Copyright © 2016 Molbie LLC. All rights reserved.
//

import simd
import Outlaw


public extension int3 {
    public struct ExtractableKeys {
        public static let x = "x"
        public static let y = "y"
        public static let z = "z"
    }
    public struct ExtractableIndexes {
        public static let x: Int = 0
        public static let y: Int = 1
        public static let z: Int = 2
    }
    fileprivate typealias keys = int3.ExtractableKeys
    fileprivate typealias indexes = int3.ExtractableIndexes
}

extension int3: Value {
    public static func value(from object: Any) throws -> int3 {
        if let data = object as? Extractable {
            let x: Int32 = try data.value(for: keys.x)
            let y: Int32 = try data.value(for: keys.y)
            let z: Int32 = try data.value(for: keys.z)
            
            return int3(x: x, y: y, z: z)
        }
        else if let data = object as? IndexExtractable {
            let x: Int32 = try data.value(for: indexes.x)
            let y: Int32 = try data.value(for: indexes.y)
            let z: Int32 = try data.value(for: indexes.z)
            
            return int3(x: x, y: y, z: z)
        }
        else {
            let expectedType = "Extractable or IndexExtractable"
            throw OutlawError.typeMismatch(expected: expectedType, actual: type(of: object))
        }
    }
}

extension int3: Serializable {
    public func serialized() -> [String: Int32] {
        var result = [String: Int32]()
        result[keys.x] = self.x
        result[keys.y] = self.y
        result[keys.z] = self.z
        
        return result
    }
}

extension int3: IndexSerializable {
    public func serialized() -> [Int32] {
        var result = [Int32](repeating: 0, count: 3)
        result[indexes.x] = self.x
        result[indexes.y] = self.y
        result[indexes.z] = self.z
        
        return result
    }
}
