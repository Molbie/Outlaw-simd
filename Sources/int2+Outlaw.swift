//
//  int2+Outlaw.swift
//  OutlawSimd
//
//  Created by Brian Mullen on 12/11/16.
//  Copyright © 2016 Molbie LLC. All rights reserved.
//

import simd
import Outlaw


public extension int2 {
    public struct ExtractableKeys {
        public static let x = "x"
        public static let y = "y"
    }
    public struct ExtractableIndexes {
        public static let x: Int = 0
        public static let y: Int = 1
    }
}

extension int2: Value {
    public static func value(from object: Any) throws -> int2 {
        if let data = object as? Extractable {
            typealias keys = int2.ExtractableKeys
            
            let x: Int32 = try data.value(for: keys.x)
            let y: Int32 = try data.value(for: keys.y)
            
            return int2(x: x, y: y)
        }
        else if let data = object as? IndexExtractable {
            typealias indexes = int2.ExtractableIndexes
            
            let x: Int32 = try data.value(for: indexes.x)
            let y: Int32 = try data.value(for: indexes.y)
            
            return int2(x: x, y: y)
        }
        else {
            let expectedType = "Extractable or IndexExtractable"
            throw OutlawError.typeMismatch(expected: expectedType, actual: type(of: object))
        }
    }
}

extension int2: Serializable {
    public func serialized() -> [String: Int32] {
        typealias keys = int2.ExtractableKeys
        
        var result = [String: Int32]()
        result[keys.x] = self.x
        result[keys.y] = self.y
        
        return result
    }
}

extension int2: IndexSerializable {
    public func serialized() -> [Int32] {
        typealias indexes = int2.ExtractableIndexes
        
        var result = [Int32](repeating: 0, count: 2)
        result[indexes.x] = self.x
        result[indexes.y] = self.y
        
        return result
    }
}
