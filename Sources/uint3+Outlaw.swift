//
//  uint3+Outlaw.swift
//  OutlawSimd
//
//  Created by Brian Mullen on 12/13/16.
//  Copyright © 2016 Molbie LLC. All rights reserved.
//

import simd
import Outlaw


public extension uint3 {
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
}

extension uint3: Value {
    public static func value(from object: Any) throws -> uint3 {
        if let data = object as? Extractable {
            typealias keys = uint3.ExtractableKeys
            
            let x: UInt32 = try data.value(for: keys.x)
            let y: UInt32 = try data.value(for: keys.y)
            let z: UInt32 = try data.value(for: keys.z)
            
            return uint3(x: x, y: y, z: z)
        }
        else if let data = object as? IndexExtractable {
            typealias indexes = uint3.ExtractableIndexes
            
            let x: UInt32 = try data.value(for: indexes.x)
            let y: UInt32 = try data.value(for: indexes.y)
            let z: UInt32 = try data.value(for: indexes.z)
            
            return uint3(x: x, y: y, z: z)
        }
        else {
            let expectedType = "Extractable or IndexExtractable"
            throw OutlawError.typeMismatch(expected: expectedType, actual: type(of: object))
        }
    }
}

extension uint3: Serializable {
    public func serialized() -> [String: UInt32] {
        typealias keys = uint3.ExtractableKeys
        
        var result = [String: UInt32]()
        result[keys.x] = self.x
        result[keys.y] = self.y
        result[keys.z] = self.z
        
        return result
    }
}

extension uint3: IndexSerializable {
    public func serialized() -> [UInt32] {
        typealias indexes = uint3.ExtractableIndexes
        
        var result = [UInt32](repeating: 0, count: 3)
        result[indexes.x] = self.x
        result[indexes.y] = self.y
        result[indexes.z] = self.z
        
        return result
    }
}
