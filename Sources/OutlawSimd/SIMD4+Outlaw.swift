//
//  SIMD4+Outlaw.swift
//  OutlawSimd
//
//  Created by Brian Mullen on 12/11/16.
//  Copyright © 2016 Molbie LLC. All rights reserved.
//

import simd
import Outlaw


extension SIMD4 {
    internal typealias keys = ExtractableKeys4
    internal typealias indexes = ExtractableIndexes4
}

extension SIMD4: Value where Scalar: Value {
    public static func value(from object: Any) throws -> SIMD4<Scalar> {
        if let data = object as? Extractable {
            let x: Scalar = try data.value(for: keys.x)
            let y: Scalar = try data.value(for: keys.y)
            let z: Scalar = try data.value(for: keys.z)
            let w: Scalar = try data.value(for: keys.w)
            
            return SIMD4<Scalar>(x: x, y: y, z: z, w: w)
        }
        else if let data = object as? IndexExtractable {
            let x: Scalar = try data.value(for: indexes.x)
            let y: Scalar = try data.value(for: indexes.y)
            let z: Scalar = try data.value(for: indexes.z)
            let w: Scalar = try data.value(for: indexes.w)
            
            return SIMD4<Scalar>(x: x, y: y, z: z, w: w)
        }
        else {
            let expectedType = "Extractable or IndexExtractable"
            throw OutlawError.typeMismatch(expected: expectedType, actual: type(of: object))
        }
    }
}

extension SIMD4: Serializable {
    public func serialized() -> [String: Scalar] {
        return [keys.x: x, keys.y: y, keys.z: z, keys.w: w]
    }
}

extension SIMD4: IndexSerializable {
    public func serializedIndexes() -> [Scalar] {
        return [x, y, z, w]
    }
}
