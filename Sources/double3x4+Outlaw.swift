//
//  double3x4+Outlaw.swift
//  OutlawSimd
//
//  Created by Brian Mullen on 12/11/16.
//  Copyright © 2016 Molbie LLC. All rights reserved.
//

import simd
import Outlaw


extension double3x4: Value {
    public static func value(from object: Any) throws -> double3x4 {
        if let data = object as? Extractable {
            let col0: double4 = try data.value(for: "c0")
            let col1: double4 = try data.value(for: "c1")
            let col2: double4 = try data.value(for: "c2")
            
            return double3x4([col0, col1, col2])
        }
        else if let data = object as? IndexExtractable {
            let col0: double4 = try data.value(for: 0)
            let col1: double4 = try data.value(for: 1)
            let col2: double4 = try data.value(for: 2)
            
            return double3x4([col0, col1, col2])
        }
        else {
            let expectedType = "Extractable or IndexExtractable"
            throw OutlawError.typeMismatch(expected: expectedType, actual: type(of: object))
        }
    }
}

extension double3x4: Serializable {
    public func serialized() -> [String: [String: Double]] {
        var result = [String: [String: Double]]()
        result["c0"] = self[0].serialized()
        result["c1"] = self[1].serialized()
        result["c2"] = self[2].serialized()
        
        return result
    }
}

extension double3x4: IndexSerializable {
    public func serialized() -> [[Double]] {
        return [self[0].serialized(),
                self[1].serialized(),
                self[2].serialized()]
    }
}
