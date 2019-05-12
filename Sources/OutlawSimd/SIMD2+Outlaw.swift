//
//  SIMD2+Outlaw.swift
//  OutlawSimd
//
//  Created by Brian Mullen on 12/11/16.
//  Copyright © 2016 Molbie LLC. All rights reserved.
//

import simd
import Outlaw


extension SIMD2 {
    internal typealias keys = ExtractableKeys2
    internal typealias indexes = ExtractableIndexes2
}

extension SIMD2: Value where Scalar: Value {
    public static func value(from object: Any) throws -> SIMD2<Scalar> {
        if let data = object as? Extractable {
            let x: Scalar = try data.value(for: keys.x)
            let y: Scalar = try data.value(for: keys.y)

            return SIMD2<Scalar>(x: x, y: y)
        }
        else if let data = object as? IndexExtractable {
            let x: Scalar = try data.value(for: indexes.x)
            let y: Scalar = try data.value(for: indexes.y)

            return SIMD2<Scalar>(x: x, y: y)
        }
        else {
            let expectedType = "Extractable or IndexExtractable"
            throw OutlawError.typeMismatch(expected: expectedType, actual: type(of: object))
        }
    }
}

extension SIMD2: Serializable {
    public func serialized() -> [String: Scalar] {
        return [keys.x: x, keys.y: y]
    }
}

extension SIMD2: IndexSerializable {
    public func serializedIndexes() -> [Scalar] {
        return [x, y]
    }
}
