//
//  matrix_float3x4+Outlaw.swift
//  OutlawSimd
//
//  Created by Brian Mullen on 12/11/16.
//  Copyright © 2016 Molbie LLC. All rights reserved.
//

import simd
import Outlaw


extension matrix_float3x4: Value {
    public static func value(from object: Any) throws -> matrix_float3x4 {
        if let data = object as? Extractable {
            let col0: vector_float4 = try data.value(for: "c0")
            let col1: vector_float4 = try data.value(for: "c1")
            let col2: vector_float4 = try data.value(for: "c2")
            
            return matrix_float3x4(columns: (col0, col1, col2))
        }
        else if let data = object as? IndexExtractable {
            let col0: vector_float4 = try data.value(for: 0)
            let col1: vector_float4 = try data.value(for: 1)
            let col2: vector_float4 = try data.value(for: 2)
            
            return matrix_float3x4(columns: (col0, col1, col2))
        }
        else {
            let expectedType = "Extractable or IndexExtractable"
            throw OutlawError.typeMismatch(expected: expectedType, actual: type(of: object))
        }
    }
}

extension matrix_float3x4: Serializable {
    public func serialized() -> [String: [String: Float]] {
        var result = [String: [String: Float]]()
        result["c0"] = self.columns.0.serialized()
        result["c1"] = self.columns.1.serialized()
        result["c2"] = self.columns.2.serialized()
        
        return result
    }
}
