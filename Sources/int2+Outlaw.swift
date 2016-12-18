//
//  int2+Outlaw.swift
//  OutlawSimd
//
//  Created by Brian Mullen on 12/11/16.
//  Copyright © 2016 Molbie LLC. All rights reserved.
//

import simd
import Outlaw


extension int2: Value {
    public static func value(from object: Any) throws -> int2 {
        if let data = object as? Extractable {
            let x: Int32 = try data.value(for: "x")
            let y: Int32 = try data.value(for: "y")
            
            return int2(x: x, y: y)
        }
        else if let data = object as? IndexExtractable {
            let x: Int32 = try data.value(for: 0)
            let y: Int32 = try data.value(for: 1)
            
            return int2(x: x, y: y)
        }
        else {
            let expectedType = "Extractable or IndexExtractable"
            throw OutlawError.typeMismatch(expected: expectedType, actual: type(of: object))
        }
    }
}

extension int2: Serializable {
    public func serialized() -> [String: Int32] {
        var result = [String: Int32]()
        result["x"] = self.x
        result["y"] = self.y
        
        return result
    }
}
