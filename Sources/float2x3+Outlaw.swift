//
//  float2x3+Outlaw.swift
//  OutlawSimd
//
//  Created by Brian Mullen on 12/11/16.
//  Copyright © 2016 Molbie LLC. All rights reserved.
//

import simd
import Outlaw


extension float2x3: Value {
    public static func value(from object: Any) throws -> float2x3 {
        if let data = object as? Extractable {
            let col0: float3 = try data.value(for: "c0")
            let col1: float3 = try data.value(for: "c1")
            
            return float2x3([col0, col1])
        }
        else if let data = object as? IndexExtractable {
            let col0: float3 = try data.value(for: 0)
            let col1: float3 = try data.value(for: 1)
            
            return float2x3([col0, col1])
        }
        else {
            let expectedType = "Extractable or IndexExtractable"
            throw OutlawError.typeMismatch(expected: expectedType, actual: type(of: object))
        }
    }
}

extension float2x3: Serializable {
    public func serialized() -> [String: [String: Float]] {
        var result = [String: [String: Float]]()
        result["c0"] = self[0].serialized()
        result["c1"] = self[1].serialized()
        
        return result
    }
}
