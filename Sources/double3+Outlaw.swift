//
//  double3+Outlaw.swift
//  OutlawSimd
//
//  Created by Brian Mullen on 12/11/16.
//  Copyright © 2016 Molbie LLC. All rights reserved.
//

import simd
import Outlaw


extension double3: Value {
    public static func value(from object: Any) throws -> double3 {
        if let data = object as? Extractable {
            let x: Double = try data.value(for: "x")
            let y: Double = try data.value(for: "y")
            let z: Double = try data.value(for: "z")
            
            return double3(x: x, y: y, z: z)
        }
        else if let data = object as? IndexExtractable {
            let x: Double = try data.value(for: 0)
            let y: Double = try data.value(for: 1)
            let z: Double = try data.value(for: 2)
            
            return double3(x: x, y: y, z: z)
        }
        else {
            let expectedType = "Extractable or IndexExtractable"
            throw OutlawError.typeMismatch(expected: expectedType, actual: type(of: object))
        }
    }
}

extension double3: Serializable {
    public func serialized() -> [String: Double] {
        var result = [String: Double]()
        result["x"] = self.x
        result["y"] = self.y
        result["z"] = self.z
        
        return result
    }
}

extension double3: IndexSerializable {
    public func serialized() -> [Double] {
        return [self.x, self.y, self.z]
    }
}
