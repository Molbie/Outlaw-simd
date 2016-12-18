//
//  int3+Outlaw.swift
//  OutlawSimd
//
//  Created by Brian Mullen on 12/11/16.
//  Copyright © 2016 Molbie LLC. All rights reserved.
//

import simd
import Outlaw


extension int3: Value {
    public static func value(from object: Any) throws -> int3 {
        if let data = object as? Extractable {
            let x: Int32 = try data.value(for: "x")
            let y: Int32 = try data.value(for: "y")
            let z: Int32 = try data.value(for: "z")
            
            return int3(x: x, y: y, z: z)
        }
        else if let data = object as? IndexExtractable {
            let x: Int32 = try data.value(for: 0)
            let y: Int32 = try data.value(for: 1)
            let z: Int32 = try data.value(for: 2)
            
            return int3(x: x, y: y, z: z)
        }
        else {
            let expectedType = "Extractable or IndexExtractable"
            throw OutlawError.typeMismatch(expected: expectedType, actual: type(of: object))
        }
    }
}

extension int3: Serializable {
    public func serialized() -> [String: Int32] {
        var result = [String: Int32]()
        result["x"] = self.x
        result["y"] = self.y
        result["z"] = self.z
        
        return result
    }
}
