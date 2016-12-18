//
//  int4+Outlaw.swift
//  OutlawSimd
//
//  Created by Brian Mullen on 12/11/16.
//  Copyright © 2016 Molbie LLC. All rights reserved.
//

import simd
import Outlaw


extension int4: Value {
    public static func value(from object: Any) throws -> int4 {
        if let data = object as? Extractable {
            let x: Int32 = try data.value(for: "x")
            let y: Int32 = try data.value(for: "y")
            let z: Int32 = try data.value(for: "z")
            let w: Int32 = try data.value(for: "w")
            
            return int4(x: x, y: y, z: z, w: w)
        }
        else if let data = object as? IndexExtractable {
            let x: Int32 = try data.value(for: 0)
            let y: Int32 = try data.value(for: 1)
            let z: Int32 = try data.value(for: 2)
            let w: Int32 = try data.value(for: 3)
            
            return int4(x: x, y: y, z: z, w: w)
        }
        else {
            let expectedType = "Extractable or IndexExtractable"
            throw OutlawError.typeMismatch(expected: expectedType, actual: type(of: object))
        }
    }
}

extension int4: Serializable {
    public func serialized() -> [String: Int32] {
        var result = [String: Int32]()
        result["x"] = self.x
        result["y"] = self.y
        result["z"] = self.z
        result["w"] = self.w
        
        return result
    }
}

extension int4: IndexSerializable {
    public func serialized() -> [Int32] {
        return [self.x, self.y, self.z, self.w]
    }
}
