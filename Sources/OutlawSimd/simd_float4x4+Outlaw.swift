//
//  simd_float4x4+Outlaw.swift
//  OutlawSimd
//
//  Created by Brian Mullen on 12/11/16.
//  Copyright © 2016 Molbie LLC. All rights reserved.
//

import simd
import Outlaw


extension simd_float4x4 {
    internal typealias keys = ExtractableKeysMatrix4
    internal typealias indexes = ExtractableIndexesMatrix4
}

extension simd_float4x4: Value {
    public static func value(from object: Any) throws -> simd_float4x4 {
        if let data = object as? Extractable {
            let col0: simd_float4 = try data.value(for: keys.column0)
            let col1: simd_float4 = try data.value(for: keys.column1)
            let col2: simd_float4 = try data.value(for: keys.column2)
            let col3: simd_float4 = try data.value(for: keys.column3)
            
            return simd_float4x4(columns: (col0, col1, col2, col3))
        }
        else if let data = object as? IndexExtractable {
            let col0: simd_float4 = try data.value(for: indexes.column0)
            let col1: simd_float4 = try data.value(for: indexes.column1)
            let col2: simd_float4 = try data.value(for: indexes.column2)
            let col3: simd_float4 = try data.value(for: indexes.column3)
            
            return simd_float4x4(columns: (col0, col1, col2, col3))
        }
        else {
            let expectedType = "Extractable or IndexExtractable"
            throw OutlawError.typeMismatch(expected: expectedType, actual: type(of: object))
        }
    }
}

extension simd_float4x4: Serializable {
    public func serialized() -> [String: [String: simd_float4.Scalar]] {
        return [keys.column0: self[0].serialized(),
                keys.column1: self[1].serialized(),
                keys.column2: self[2].serialized(),
                keys.column3: self[3].serialized()]
    }
}

extension simd_float4x4: IndexSerializable {
    public func serializedIndexes() -> [[simd_float4.Scalar]] {
        return [self[0].serializedIndexes(),
                self[1].serializedIndexes(),
                self[2].serializedIndexes(),
                self[3].serializedIndexes()]
    }
}
