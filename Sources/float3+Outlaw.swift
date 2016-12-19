//
//  float3+Outlaw.swift
//  OutlawSimd
//
//  Created by Brian Mullen on 12/11/16.
//  Copyright © 2016 Molbie LLC. All rights reserved.
//

import simd
import Outlaw


public extension float3 {
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
    fileprivate typealias keys = float3.ExtractableKeys
    fileprivate typealias indexes = float3.ExtractableIndexes
}

extension float3: Value {
    public static func value(from object: Any) throws -> float3 {
        if let data = object as? Extractable {
            let x: Float = try data.value(for: keys.x)
            let y: Float = try data.value(for: keys.y)
            let z: Float = try data.value(for: keys.z)
            
            return float3(x: x, y: y, z: z)
        }
        else if let data = object as? IndexExtractable {
            let x: Float = try data.value(for: indexes.x)
            let y: Float = try data.value(for: indexes.y)
            let z: Float = try data.value(for: indexes.z)
            
            return float3(x: x, y: y, z: z)
        }
        else {
            let expectedType = "Extractable or IndexExtractable"
            throw OutlawError.typeMismatch(expected: expectedType, actual: type(of: object))
        }
    }
}

extension float3: Serializable {
    public func serialized() -> [String: Float] {
        var result = [String: Float]()
        result[keys.x] = self.x
        result[keys.y] = self.y
        result[keys.z] = self.z
        
        return result
    }
}

extension float3: IndexSerializable {
    public func serializedIndexes() -> [Float] {
        var result = [Float](repeating: 0, count: 3)
        result[indexes.x] = self.x
        result[indexes.y] = self.y
        result[indexes.z] = self.z
        
        return result
    }
}
