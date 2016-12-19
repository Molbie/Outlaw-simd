//
//  double3+Outlaw.swift
//  OutlawSimd
//
//  Created by Brian Mullen on 12/11/16.
//  Copyright © 2016 Molbie LLC. All rights reserved.
//

import simd
import Outlaw


public extension double3 {
    public struct ExtractableKeys {
        public static let x = "x"
        public static let y = "y"
        public static let z = "z"
    }
    public struct ExtractableIndexes {
        public static let x: Int = 0
        public static let y: Int = 1
        public static let z: Int = 2
    }
}

extension double3: Value {
    public static func value(from object: Any) throws -> double3 {
        if let data = object as? Extractable {
            typealias keys = double3.ExtractableKeys
            
            let x: Double = try data.value(for: keys.x)
            let y: Double = try data.value(for: keys.y)
            let z: Double = try data.value(for: keys.z)
            
            return double3(x: x, y: y, z: z)
        }
        else if let data = object as? IndexExtractable {
            typealias indexes = double3.ExtractableIndexes
            
            let x: Double = try data.value(for: indexes.x)
            let y: Double = try data.value(for: indexes.y)
            let z: Double = try data.value(for: indexes.z)
            
            return double3(x: x, y: y, z: z)
        }
        else {
            let expectedType = "Extractable or IndexExtractable"
            throw OutlawError.typeMismatch(expected: expectedType, actual: type(of: object))
        }
    }
}

extension double3: Serializable {
    public func serialized() -> [String: Double] {
        typealias keys = double3.ExtractableKeys
        
        var result = [String: Double]()
        result[keys.x] = self.x
        result[keys.y] = self.y
        result[keys.z] = self.z
        
        return result
    }
}

extension double3: IndexSerializable {
    public func serialized() -> [Double] {
        typealias indexes = double3.ExtractableIndexes
        
        var result = [Double](repeating: 0, count: 3)
        result[indexes.x] = self.x
        result[indexes.y] = self.y
        result[indexes.z] = self.z
        
        return result
    }
}
