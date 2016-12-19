//
//  float4x2+Outlaw.swift
//  OutlawSimd
//
//  Created by Brian Mullen on 12/11/16.
//  Copyright © 2016 Molbie LLC. All rights reserved.
//

import simd
import Outlaw


public extension float4x2 {
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
    fileprivate typealias keys = float4x2.ExtractableKeys
    fileprivate typealias indexes = float4x2.ExtractableIndexes
}

extension float4x2: Value {
    public static func value(from object: Any) throws -> float4x2 {
        if let data = object as? Extractable {
            let col0: float2 = try data.value(for: keys.column0)
            let col1: float2 = try data.value(for: keys.column1)
            let col2: float2 = try data.value(for: keys.column2)
            let col3: float2 = try data.value(for: keys.column3)
            
            return float4x2([col0, col1, col2, col3])
        }
        else if let data = object as? IndexExtractable {
            let col0: float2 = try data.value(for: indexes.column0)
            let col1: float2 = try data.value(for: indexes.column1)
            let col2: float2 = try data.value(for: indexes.column2)
            let col3: float2 = try data.value(for: indexes.column3)
            
            return float4x2([col0, col1, col2, col3])
        }
        else {
            let expectedType = "Extractable or IndexExtractable"
            throw OutlawError.typeMismatch(expected: expectedType, actual: type(of: object))
        }
    }
}

extension float4x2: Serializable {
    public func serialized() -> [String: [String: Float]] {
        var result = [String: [String: Float]]()
        result[keys.column0] = self[0].serialized()
        result[keys.column1] = self[1].serialized()
        result[keys.column2] = self[2].serialized()
        result[keys.column3] = self[3].serialized()
        
        return result
    }
}

extension float4x2: IndexSerializable {
    public func serialized() -> [[Float]] {
        var result = [[Float]](repeating: [0], count: 4)
        result[indexes.column0] = self[0].serialized()
        result[indexes.column1] = self[1].serialized()
        result[indexes.column2] = self[2].serialized()
        result[indexes.column3] = self[3].serialized()
        
        return result
    }
}
