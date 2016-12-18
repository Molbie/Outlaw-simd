//
//  matrix_float2x2+Outlaw.swift
//  OutlawSimd
//
//  Created by Brian Mullen on 12/11/16.
//  Copyright © 2016 Molbie LLC. All rights reserved.
//

import simd
import Outlaw


extension matrix_float2x2: Value {
    public static func value(from object: Any) throws -> matrix_float2x2 {
        if let data = object as? Extractable {
            let col0: vector_float2 = try data.value(for: "c0")
            let col1: vector_float2 = try data.value(for: "c1")
            
            return matrix_float2x2(columns: (col0, col1))
        }
        else if let data = object as? IndexExtractable {
            let col0: vector_float2 = try data.value(for: 0)
            let col1: vector_float2 = try data.value(for: 1)
            
            return matrix_float2x2(columns: (col0, col1))
        }
        else {
            let expectedType = "Extractable or IndexExtractable"
            throw OutlawError.typeMismatch(expected: expectedType, actual: type(of: object))
        }
    }
}

extension matrix_float2x2: Serializable {
    public func serialized() -> [String: [String: Float]] {
        var result = [String: [String: Float]]()
        result["c0"] = self.columns.0.serialized()
        result["c1"] = self.columns.1.serialized()
        
        return result
    }
}

extension matrix_float2x2: IndexSerializable {
    public func serialized() -> [[Float]] {
        return [self.columns.0.serialized(),
                self.columns.1.serialized()]
    }
}
