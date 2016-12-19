//
//  float3x3+Outlaw.swift
//  OutlawSimd
//
//  Created by Brian Mullen on 12/11/16.
//  Copyright © 2016 Molbie LLC. All rights reserved.
//

import simd
import Outlaw


public extension float3x3 {
    public struct ExtractableKeys {
        public static let column0 = "0"
        public static let column1 = "1"
        public static let column2 = "2"
    }
    public struct ExtractableIndexes {
        public static let column0: Int = 0
        public static let column1: Int = 1
        public static let column2: Int = 2
    }
}

extension float3x3: Value {
    public static func value(from object: Any) throws -> float3x3 {
        if let data = object as? Extractable {
            typealias keys = float3x3.ExtractableKeys
            
            let col0: float3 = try data.value(for: keys.column0)
            let col1: float3 = try data.value(for: keys.column1)
            let col2: float3 = try data.value(for: keys.column2)
            
            return float3x3([col0, col1, col2])
        }
        else if let data = object as? IndexExtractable {
            typealias indexes = float3x3.ExtractableIndexes
            
            let col0: float3 = try data.value(for: indexes.column0)
            let col1: float3 = try data.value(for: indexes.column1)
            let col2: float3 = try data.value(for: indexes.column2)
            
            return float3x3([col0, col1, col2])
        }
        else {
            let expectedType = "Extractable or IndexExtractable"
            throw OutlawError.typeMismatch(expected: expectedType, actual: type(of: object))
        }
    }
}

extension float3x3: Serializable {
    public func serialized() -> [String: [String: Float]] {
        typealias keys = float3x3.ExtractableKeys
        
        var result = [String: [String: Float]]()
        result[keys.column0] = self[0].serialized()
        result[keys.column1] = self[1].serialized()
        result[keys.column2] = self[2].serialized()
        
        return result
    }
}

extension float3x3: IndexSerializable {
    public func serialized() -> [[Float]] {
        typealias indexes = float3x3.ExtractableIndexes
        
        var result = [[Float]](repeating: [0], count: 3)
        result[indexes.column0] = self[0].serialized()
        result[indexes.column1] = self[1].serialized()
        result[indexes.column2] = self[2].serialized()
        
        return result
    }
}
