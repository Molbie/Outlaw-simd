//
//  double2x2+Outlaw.swift
//  OutlawSimd
//
//  Created by Brian Mullen on 12/11/16.
//  Copyright © 2016 Molbie LLC. All rights reserved.
//

import simd
import Outlaw


public extension double2x2 {
    public struct ExtractableKeys {
        public static let column0 = "0"
        public static let column1 = "1"
    }
    public struct ExtractableIndexes {
        public static let column0: Int = 0
        public static let column1: Int = 1
    }
    fileprivate typealias keys = double2x2.ExtractableKeys
    fileprivate typealias indexes = double2x2.ExtractableIndexes
}

extension double2x2: Value {
    public static func value(from object: Any) throws -> double2x2 {
        if let data = object as? Extractable {
            let col0: double2 = try data.value(for: keys.column0)
            let col1: double2 = try data.value(for: keys.column1)
            
            return double2x2([col0, col1])
        }
        else if let data = object as? IndexExtractable {
            let col0: double2 = try data.value(for: indexes.column0)
            let col1: double2 = try data.value(for: indexes.column1)
            
            return double2x2([col0, col1])
        }
        else {
            let expectedType = "Extractable or IndexExtractable"
            throw OutlawError.typeMismatch(expected: expectedType, actual: type(of: object))
        }
    }
}

extension double2x2: Serializable {
    public func serialized() -> [String: [String: Double]] {
        var result = [String: [String: Double]]()
        result[keys.column0] = self[0].serialized()
        result[keys.column1] = self[1].serialized()
        
        return result
    }
}

extension double2x2: IndexSerializable {
    public func serialized() -> [[Double]] {
        var result = [[Double]](repeating: [0], count: 2)
        result[indexes.column0] = self[0].serialized()
        result[indexes.column1] = self[1].serialized()
        
        return result
    }
}
