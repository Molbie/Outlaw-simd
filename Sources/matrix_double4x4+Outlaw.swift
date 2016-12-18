//
//  matrix_double4x4+Outlaw.swift
//  OutlawSimd
//
//  Created by Brian Mullen on 12/11/16.
//  Copyright © 2016 Molbie LLC. All rights reserved.
//

import simd
import Outlaw


extension matrix_double4x4: Value {
    public static func value(from object: Any) throws -> matrix_double4x4 {
        if let data = object as? Extractable {
            let col0: vector_double4 = try data.value(for: "c0")
            let col1: vector_double4 = try data.value(for: "c1")
            let col2: vector_double4 = try data.value(for: "c2")
            let col3: vector_double4 = try data.value(for: "c3")
            
            return matrix_double4x4(columns: (col0, col1, col2, col3))
        }
        else if let data = object as? IndexExtractable {
            let col0: vector_double4 = try data.value(for: 0)
            let col1: vector_double4 = try data.value(for: 1)
            let col2: vector_double4 = try data.value(for: 2)
            let col3: vector_double4 = try data.value(for: 3)
            
            return matrix_double4x4(columns: (col0, col1, col2, col3))
        }
        else {
            let expectedType = "Extractable or IndexExtractable"
            throw OutlawError.typeMismatch(expected: expectedType, actual: type(of: object))
        }
    }
}

extension matrix_double4x4: Serializable {
    public func serialized() -> [String: [String: Double]] {
        var result = [String: [String: Double]]()
        result["c0"] = self.columns.0.serialized()
        result["c1"] = self.columns.1.serialized()
        result["c2"] = self.columns.2.serialized()
        result["c3"] = self.columns.3.serialized()
        
        return result
    }
}

extension matrix_double4x4: IndexSerializable {
    public func serialized() -> [[Double]] {
        return [self.columns.0.serialized(),
                self.columns.1.serialized(),
                self.columns.2.serialized(),
                self.columns.3.serialized()]
    }
}
