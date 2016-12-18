//
//  float4+Outlaw.swift
//  OutlawSimd
//
//  Created by Brian Mullen on 12/11/16.
//  Copyright © 2016 Molbie LLC. All rights reserved.
//

import simd
import Outlaw


extension float4: Value {
    public static func value(from object: Any) throws -> float4 {
        if let data = object as? Extractable {
            let x: Float = try data.value(for: "x")
            let y: Float = try data.value(for: "y")
            let z: Float = try data.value(for: "z")
            let w: Float = try data.value(for: "w")
            
            return float4(x: x, y: y, z: z, w: w)
        }
        else if let data = object as? IndexExtractable {
            let x: Float = try data.value(for: 0)
            let y: Float = try data.value(for: 1)
            let z: Float = try data.value(for: 2)
            let w: Float = try data.value(for: 3)
            
            return float4(x: x, y: y, z: z, w: w)
        }
        else {
            let expectedType = "Extractable or IndexExtractable"
            throw OutlawError.typeMismatch(expected: expectedType, actual: type(of: object))
        }
    }
}

extension float4: Serializable {
    public func serialized() -> [String: Float] {
        var result = [String: Float]()
        result["x"] = self.x
        result["y"] = self.y
        result["z"] = self.z
        result["w"] = self.w
        
        return result
    }
}

extension float4: IndexSerializable {
    public func serialized() -> [Float] {
        return [self.x, self.y, self.z, self.w]
    }
}
