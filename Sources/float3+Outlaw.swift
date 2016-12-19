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
}

extension float3: Value {
    public static func value(from object: Any) throws -> float3 {
        if let data = object as? Extractable {
            typealias keys = float3.ExtractableKeys
            
            let x: Float = try data.value(for: keys.x)
            let y: Float = try data.value(for: keys.y)
            let z: Float = try data.value(for: keys.z)
            
            return float3(x: x, y: y, z: z)
        }
        else if let data = object as? IndexExtractable {
            let x: Float = try data.value(for: 0)
            let y: Float = try data.value(for: 1)
            let z: Float = try data.value(for: 2)
            
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
        typealias keys = float3.ExtractableKeys
        
        var result = [String: Float]()
        result[keys.x] = self.x
        result[keys.y] = self.y
        result[keys.z] = self.z
        
        return result
    }
}

extension float3: IndexSerializable {
    public func serialized() -> [Float] {
        return [self.x, self.y, self.z]
    }
}
