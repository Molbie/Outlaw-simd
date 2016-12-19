//
//  double2+Outlaw.swift
//  OutlawSimd
//
//  Created by Brian Mullen on 12/11/16.
//  Copyright © 2016 Molbie LLC. All rights reserved.
//

import simd
import Outlaw


public extension double2 {
    public struct ExtractableKeys {
        public static let x = "x"
        public static let y = "y"
    }
    public struct ExtractableIndexes {
        public static let x: Int = 0
        public static let y: Int = 1
    }
}

extension double2: Value {
    public static func value(from object: Any) throws -> double2 {
        if let data = object as? Extractable {
            typealias keys = double2.ExtractableKeys
            
            let x: Double = try data.value(for: keys.x)
            let y: Double = try data.value(for: keys.y)
            
            return double2(x: x, y: y)
        }
        else if let data = object as? IndexExtractable {
            typealias indexes = double2.ExtractableIndexes
            
            let x: Double = try data.value(for: indexes.x)
            let y: Double = try data.value(for: indexes.y)
            
            return double2(x: x, y: y)
        }
        else {
            let expectedType = "Extractable or IndexExtractable"
            throw OutlawError.typeMismatch(expected: expectedType, actual: type(of: object))
        }
    }
}

extension double2: Serializable {
    public func serialized() -> [String: Double] {
        typealias keys = double2.ExtractableKeys
        
        var result = [String: Double]()
        result[keys.x] = self.x
        result[keys.y] = self.y
        
        return result
    }
}

extension double2: IndexSerializable {
    public func serialized() -> [Double] {
        typealias indexes = double2.ExtractableIndexes
        
        var result = [Double](repeating: 0, count: 2)
        result[indexes.x] = self.x
        result[indexes.y] = self.y
        
        return result
    }
}
