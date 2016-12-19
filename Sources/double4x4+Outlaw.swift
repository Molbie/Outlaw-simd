//
//  double4x4+Outlaw.swift
//  OutlawSimd
//
//  Created by Brian Mullen on 12/11/16.
//  Copyright © 2016 Molbie LLC. All rights reserved.
//

import simd
import Outlaw


public extension double4x4 {
    public struct ExtractableKeys {
        public static let column0 = "0"
        public static let column1 = "1"
        public static let column2 = "2"
        public static let column3 = "3"
    }
}

extension double4x4: Value {
    public static func value(from object: Any) throws -> double4x4 {
        if let data = object as? Extractable {
            typealias keys = double4x4.ExtractableKeys
            
            let col0: double4 = try data.value(for: keys.column0)
            let col1: double4 = try data.value(for: keys.column1)
            let col2: double4 = try data.value(for: keys.column2)
            let col3: double4 = try data.value(for: keys.column3)
            
            return double4x4([col0, col1, col2, col3])
        }
        else if let data = object as? IndexExtractable {
            let col0: double4 = try data.value(for: 0)
            let col1: double4 = try data.value(for: 1)
            let col2: double4 = try data.value(for: 2)
            let col3: double4 = try data.value(for: 3)
            
            return double4x4([col0, col1, col2, col3])
        }
        else {
            let expectedType = "Extractable or IndexExtractable"
            throw OutlawError.typeMismatch(expected: expectedType, actual: type(of: object))
        }
    }
}

extension double4x4: Serializable {
    public func serialized() -> [String: [String: Double]] {
        typealias keys = double4x4.ExtractableKeys
        
        var result = [String: [String: Double]]()
        result[keys.column0] = self[0].serialized()
        result[keys.column1] = self[1].serialized()
        result[keys.column2] = self[2].serialized()
        result[keys.column3] = self[3].serialized()
        
        return result
    }
}

extension double4x4: IndexSerializable {
    public func serialized() -> [[Double]] {
        return [self[0].serialized(),
                self[1].serialized(),
                self[2].serialized(),
                self[3].serialized()]
    }
}
