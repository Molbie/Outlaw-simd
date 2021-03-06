//
//  simd_double2x4+Outlaw.swift
//  OutlawSimd
//
//  Created by Brian Mullen on 12/11/16.
//  Copyright © 2016 Molbie LLC. All rights reserved.
//

import simd
import Outlaw


extension simd_double2x4 {
    internal typealias keys = ExtractableKeysMatrix2
    internal typealias indexes = ExtractableIndexesMatrix2
}

extension simd_double2x4: Value {
    public static func value(from object: Any) throws -> simd_double2x4 {
        if let data = object as? Extractable {
            let col0: simd_double4 = try data.value(for: keys.column0)
            let col1: simd_double4 = try data.value(for: keys.column1)
            
            return simd_double2x4([col0, col1])
        }
        else if let data = object as? IndexExtractable {
            let col0: simd_double4 = try data.value(for: indexes.column0)
            let col1: simd_double4 = try data.value(for: indexes.column1)
            
            return simd_double2x4([col0, col1])
        }
        else {
            let expectedType = "Extractable or IndexExtractable"
            throw OutlawError.typeMismatch(expected: expectedType, actual: type(of: object))
        }
    }
}

extension simd_double2x4: Serializable {
    public func serialized() -> [String: [String: simd_double4.Scalar]] {
        return [keys.column0: self[0].serialized(),
                keys.column1: self[1].serialized()]
    }
}

extension double2x4: IndexSerializable {
    public func serializedIndexes() -> [[simd_double4.Scalar]] {
        return [self[0].serializedIndexes(),
                self[1].serializedIndexes()]
    }
}
