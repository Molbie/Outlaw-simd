//
//  uint4+Outlaw.swift
//  OutlawSimd
//
//  Created by Brian Mullen on 12/13/16.
//  Copyright © 2016 Molbie LLC. All rights reserved.
//

import simd
import Outlaw


extension uint4: Value {
    public static func value(from object: Any) throws -> uint4 {
        if let data = object as? Extractable {
            let x: UInt32 = try data.value(for: "x")
            let y: UInt32 = try data.value(for: "y")
            let z: UInt32 = try data.value(for: "z")
            let w: UInt32 = try data.value(for: "w")
            
            return uint4(x: x, y: y, z: z, w: w)
        }
        else if let data = object as? IndexExtractable {
            let x: UInt32 = try data.value(for: 0)
            let y: UInt32 = try data.value(for: 1)
            let z: UInt32 = try data.value(for: 2)
            let w: UInt32 = try data.value(for: 3)
            
            return uint4(x: x, y: y, z: z, w: w)
        }
        else {
            let expectedType = "Extractable or IndexExtractable"
            throw OutlawError.typeMismatch(expected: expectedType, actual: type(of: object))
        }
    }
}

extension uint4: Serializable {
    public func serialized() -> [String: UInt32] {
        var result = [String: UInt32]()
        result["x"] = self.x
        result["y"] = self.y
        result["z"] = self.z
        result["w"] = self.w
        
        return result
    }
}

extension uint4: IndexSerializable {
    public func serialized() -> [UInt32] {
        return [self.x, self.y, self.z, self.w]
    }
}
