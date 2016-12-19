//
//  matrix_float2x3+Outlaw.swift
//  OutlawSimd
//
//  Created by Brian Mullen on 12/11/16.
//  Copyright © 2016 Molbie LLC. All rights reserved.
//

import simd
import Outlaw


public extension matrix_float2x3 {
    public struct ExtractableKeys {
        public static let column0 = "0"
        public static let column1 = "1"
    }
}

extension matrix_float2x3: Value {
    public static func value(from object: Any) throws -> matrix_float2x3 {
        if let data = object as? Extractable {
            typealias keys = matrix_float2x3.ExtractableKeys
            
            let col0: vector_float3 = try data.value(for: keys.column0)
            let col1: vector_float3 = try data.value(for: keys.column1)
            
            return matrix_float2x3(columns: (col0, col1))
        }
        else if let data = object as? IndexExtractable {
            let col0: vector_float3 = try data.value(for: 0)
            let col1: vector_float3 = try data.value(for: 1)
            
            return matrix_float2x3(columns: (col0, col1))
        }
        else {
            let expectedType = "Extractable or IndexExtractable"
            throw OutlawError.typeMismatch(expected: expectedType, actual: type(of: object))
        }
    }
}

extension matrix_float2x3: Serializable {
    public func serialized() -> [String: [String: Float]] {
        typealias keys = matrix_float2x3.ExtractableKeys
        
        var result = [String: [String: Float]]()
        result[keys.column0] = self.columns.0.serialized()
        result[keys.column1] = self.columns.1.serialized()
        
        return result
    }
}

extension matrix_float2x3: IndexSerializable {
    public func serialized() -> [[Float]] {
        return [self.columns.0.serialized(),
                self.columns.1.serialized()]
    }
}
