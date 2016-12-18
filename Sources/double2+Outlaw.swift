//
//  double2+Outlaw.swift
//  OutlawSimd
//
//  Created by Brian Mullen on 12/11/16.
//  Copyright © 2016 Molbie LLC. All rights reserved.
//

import simd
import Outlaw


extension double2: Value {
    public static func value(from object: Any) throws -> double2 {
        if let data = object as? Extractable {
            let x: Double = try data.value(for: "x")
            let y: Double = try data.value(for: "y")
            
            return double2(x: x, y: y)
        }
        else if let data = object as? IndexExtractable {
            let x: Double = try data.value(for: 0)
            let y: Double = try data.value(for: 1)
            
            return double2(x: x, y: y)
        }
        else {
            let expectedType = "Extractable or IndexExtractable"
            throw OutlawError.typeMismatch(expected: expectedType, actual: type(of: object))
        }
    }
}

extension double2: Serializable {
    public func serialized() -> [String: Double] {
        var result = [String: Double]()
        result["x"] = self.x
        result["y"] = self.y
        
        return result
    }
}
