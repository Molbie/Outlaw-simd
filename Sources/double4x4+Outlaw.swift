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
    public struct ExtractableIndexes {
        public static let column0: Int = 0
        public static let column1: Int = 1
        public static let column2: Int = 2
        public static let column3: Int = 3
    }
    fileprivate typealias keys = double4x4.ExtractableKeys
    fileprivate typealias indexes = double4x4.ExtractableIndexes
}

extension double4x4: Value {
    public static func value(from object: Any) throws -> double4x4 {
        if let data = object as? Extractable {
            let col0: double4 = try data.value(for: keys.column0)
            let col1: double4 = try data.value(for: keys.column1)
            let col2: double4 = try data.value(for: keys.column2)
            let col3: double4 = try data.value(for: keys.column3)
            
            return double4x4([col0, col1, col2, col3])
        }
        else if let data = object as? IndexExtractable {
            let col0: double4 = try data.value(for: indexes.column0)
            let col1: double4 = try data.value(for: indexes.column1)
            let col2: double4 = try data.value(for: indexes.column2)
            let col3: double4 = try data.value(for: indexes.column3)
            
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
        var result = [String: [String: Double]]()
        result[keys.column0] = self[0].serialized()
        result[keys.column1] = self[1].serialized()
        result[keys.column2] = self[2].serialized()
        result[keys.column3] = self[3].serialized()
        
        return result
    }
}

extension double4x4: IndexSerializable {
    public func serializedIndexes() -> [[Double]] {
        var result = [[Double]](repeating: [0], count: 4)
        result[indexes.column0] = self[0].serializedIndexes()
        result[indexes.column1] = self[1].serializedIndexes()
        result[indexes.column2] = self[2].serializedIndexes()
        result[indexes.column3] = self[3].serializedIndexes()
        
        return result
    }
}
