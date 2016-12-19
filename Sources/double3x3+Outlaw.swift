//
//  double3x3+Outlaw.swift
//  OutlawSimd
//
//  Created by Brian Mullen on 12/11/16.
//  Copyright © 2016 Molbie LLC. All rights reserved.
//

import simd
import Outlaw


public extension double3x3 {
    public struct ExtractableKeys {
        public static let column0 = "0"
        public static let column1 = "1"
        public static let column2 = "2"
    }
}

extension double3x3: Value {
    public static func value(from object: Any) throws -> double3x3 {
        if let data = object as? Extractable {
            typealias keys = double3x3.ExtractableKeys
            
            let col0: double3 = try data.value(for: keys.column0)
            let col1: double3 = try data.value(for: keys.column1)
            let col2: double3 = try data.value(for: keys.column2)
            
            return double3x3([col0, col1, col2])
        }
        else if let data = object as? IndexExtractable {
            let col0: double3 = try data.value(for: 0)
            let col1: double3 = try data.value(for: 1)
            let col2: double3 = try data.value(for: 2)
            
            return double3x3([col0, col1, col2])
        }
        else {
            let expectedType = "Extractable or IndexExtractable"
            throw OutlawError.typeMismatch(expected: expectedType, actual: type(of: object))
        }
    }
}

extension double3x3: Serializable {
    public func serialized() -> [String: [String: Double]] {
        typealias keys = double3x3.ExtractableKeys
        
        var result = [String: [String: Double]]()
        result[keys.column0] = self[0].serialized()
        result[keys.column1] = self[1].serialized()
        result[keys.column2] = self[2].serialized()
        
        return result
    }
}

extension double3x3: IndexSerializable {
    public func serialized() -> [[Double]] {
        return [self[0].serialized(),
                self[1].serialized(),
                self[2].serialized()]
    }
}
