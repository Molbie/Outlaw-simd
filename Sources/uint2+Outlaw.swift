//
//  uint2+Outlaw.swift
//  OutlawSimd
//
//  Created by Brian Mullen on 12/13/16.
//  Copyright © 2016 Molbie LLC. All rights reserved.
//

import simd
import Outlaw


extension uint2: Value {
    public static func value(from object: Any) throws -> uint2 {
        if let data = object as? Extractable {
            let x: UInt32 = try data.value(for: "x")
            let y: UInt32 = try data.value(for: "y")
            
            return uint2(x: x, y: y)
        }
        else if let data = object as? IndexExtractable {
            let x: UInt32 = try data.value(for: 0)
            let y: UInt32 = try data.value(for: 1)
            
            return uint2(x: x, y: y)
        }
        else {
            let expectedType = "Extractable or IndexExtractable"
            throw OutlawError.typeMismatch(expected: expectedType, actual: type(of: object))
        }
    }
}

extension uint2: Serializable {
    public func serialized() -> [String: UInt32] {
        var result = [String: UInt32]()
        result["x"] = self.x
        result["y"] = self.y
        
        return result
    }
}

extension uint2: IndexSerializable {
    public func serialized() -> [UInt32] {
        return [self.x, self.y]
    }
}
