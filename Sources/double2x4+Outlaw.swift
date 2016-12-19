//
//  double2x4+Outlaw.swift
//  OutlawSimd
//
//  Created by Brian Mullen on 12/11/16.
//  Copyright © 2016 Molbie LLC. All rights reserved.
//

import simd
import Outlaw


public extension double2x4 {
    public struct ExtractableKeys {
        public static let column0 = "0"
        public static let column1 = "1"
    }
}

extension double2x4: Value {
    public static func value(from object: Any) throws -> double2x4 {
        if let data = object as? Extractable {
            typealias keys = double2x4.ExtractableKeys
            
            let col0: double4 = try data.value(for: keys.column0)
            let col1: double4 = try data.value(for: keys.column1)
            
            return double2x4([col0, col1])
        }
        else if let data = object as? IndexExtractable {
            let col0: double4 = try data.value(for: 0)
            let col1: double4 = try data.value(for: 1)
            
            return double2x4([col0, col1])
        }
        else {
            let expectedType = "Extractable or IndexExtractable"
            throw OutlawError.typeMismatch(expected: expectedType, actual: type(of: object))
        }
    }
}

extension double2x4: Serializable {
    public func serialized() -> [String: [String: Double]] {
        typealias keys = double2x4.ExtractableKeys
        
        var result = [String: [String: Double]]()
        result[keys.column0] = self[0].serialized()
        result[keys.column1] = self[1].serialized()
        
        return result
    }
}

extension double2x4: IndexSerializable {
    public func serialized() -> [[Double]] {
        return [self[0].serialized(),
                self[1].serialized()]
    }
}
