//
//  simd_double3x3+Outlaw.swift
//  OutlawSimd
//
//  Created by Brian Mullen on 12/11/16.
//  Copyright © 2016 Molbie LLC. All rights reserved.
//

import simd
import Outlaw


extension simd_double3x3 {
    internal typealias keys = ExtractableKeysMatrix3
    internal typealias indexes = ExtractableIndexesMatrix3
}

extension simd_double3x3: Value {
    public static func value(from object: Any) throws -> simd_double3x3 {
        if let data = object as? Extractable {
            let col0: simd_double3 = try data.value(for: keys.column0)
            let col1: simd_double3 = try data.value(for: keys.column1)
            let col2: simd_double3 = try data.value(for: keys.column2)
            
            return simd_double3x3(columns: (col0, col1, col2))
        }
        else if let data = object as? IndexExtractable {
            let col0: simd_double3 = try data.value(for: indexes.column0)
            let col1: simd_double3 = try data.value(for: indexes.column1)
            let col2: simd_double3 = try data.value(for: indexes.column2)
            
            return simd_double3x3(columns: (col0, col1, col2))
        }
        else {
            let expectedType = "Extractable or IndexExtractable"
            throw OutlawError.typeMismatch(expected: expectedType, actual: type(of: object))
        }
    }
}

extension simd_double3x3: Serializable {
    public func serialized() -> [String: [String: simd_double3.Scalar]] {
        return [keys.column0: self[0].serialized(),
                keys.column1: self[1].serialized(),
                keys.column2: self[2].serialized()]
    }
}

extension simd_double3x3: IndexSerializable {
    public func serializedIndexes() -> [[simd_double3.Scalar]] {
        return [self[0].serializedIndexes(),
                self[1].serializedIndexes(),
                self[2].serializedIndexes()]
    }
}
