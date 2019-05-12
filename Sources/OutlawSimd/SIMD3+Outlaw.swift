//
//  SIMD3+Outlaw.swift
//  OutlawSimd
//
//  Created by Brian Mullen on 12/11/16.
//  Copyright © 2016 Molbie LLC. All rights reserved.
//

import simd
import Outlaw


extension SIMD3 {
    internal typealias keys = ExtractableKeys3
    internal typealias indexes = ExtractableIndexes3
}

extension SIMD3: Value where Scalar: Value {
    public static func value(from object: Any) throws -> SIMD3<Scalar> {
        if let data = object as? Extractable {
            let x: Scalar = try data.value(for: keys.x)
            let y: Scalar = try data.value(for: keys.y)
            let z: Scalar = try data.value(for: keys.z)
            
            return SIMD3<Scalar>(x: x, y: y, z: z)
        }
        else if let data = object as? IndexExtractable {
            let x: Scalar = try data.value(for: indexes.x)
            let y: Scalar = try data.value(for: indexes.y)
            let z: Scalar = try data.value(for: indexes.z)
            
            return SIMD3<Scalar>(x: x, y: y, z: z)
        }
        else {
            let expectedType = "Extractable or IndexExtractable"
            throw OutlawError.typeMismatch(expected: expectedType, actual: type(of: object))
        }
    }
}

extension SIMD3: Serializable {
    public func serialized() -> [String: Scalar] {
        return [keys.x: x, keys.y: y, keys.z: z]
    }
}

extension SIMD3: IndexSerializable {
    public func serializedIndexes() -> [Scalar] {
        return [x, y, z]
    }
}
