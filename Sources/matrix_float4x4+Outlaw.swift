//
//  matrix_float4x4+Outlaw.swift
//  OutlawSimd
//
//  Created by Brian Mullen on 12/11/16.
//  Copyright © 2016 Molbie LLC. All rights reserved.
//

import simd
import Outlaw


public extension matrix_float4x4 {
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
    fileprivate typealias keys = matrix_float4x4.ExtractableKeys
    fileprivate typealias indexes = matrix_float4x4.ExtractableIndexes
}

extension matrix_float4x4: Value {
    public static func value(from object: Any) throws -> matrix_float4x4 {
        if let data = object as? Extractable {
            let col0: vector_float4 = try data.value(for: keys.column0)
            let col1: vector_float4 = try data.value(for: keys.column1)
            let col2: vector_float4 = try data.value(for: keys.column2)
            let col3: vector_float4 = try data.value(for: keys.column3)
            
            return matrix_float4x4(columns: (col0, col1, col2, col3))
        }
        else if let data = object as? IndexExtractable {
            let col0: vector_float4 = try data.value(for: indexes.column0)
            let col1: vector_float4 = try data.value(for: indexes.column1)
            let col2: vector_float4 = try data.value(for: indexes.column2)
            let col3: vector_float4 = try data.value(for: indexes.column3)
            
            return matrix_float4x4(columns: (col0, col1, col2, col3))
        }
        else {
            let expectedType = "Extractable or IndexExtractable"
            throw OutlawError.typeMismatch(expected: expectedType, actual: type(of: object))
        }
    }
}

extension matrix_float4x4: Serializable {
    public func serialized() -> [String: [String: Float]] {
        var result = [String: [String: Float]]()
        result[keys.column0] = self.columns.0.serialized()
        result[keys.column1] = self.columns.1.serialized()
        result[keys.column2] = self.columns.2.serialized()
        result[keys.column3] = self.columns.3.serialized()
        
        return result
    }
}

extension matrix_float4x4: IndexSerializable {
    public func serialized() -> [[Float]] {
        var result = [[Float]](repeating: [0], count: 4)
        result[indexes.column0] = self.columns.0.serialized()
        result[indexes.column1] = self.columns.1.serialized()
        result[indexes.column2] = self.columns.2.serialized()
        result[indexes.column3] = self.columns.3.serialized()
        
        return result
    }
}
