//
//  uint2+Outlaw.swift
//  OutlawSimd
//
//  Created by Brian Mullen on 12/13/16.
//  Copyright © 2016 Molbie LLC. All rights reserved.
//

import simd
import Outlaw


public extension uint2 {
    public struct ExtractableKeys {
        public static let x = "x"
        public static let y = "y"
    }
    public struct ExtractableIndexes {
        public static let x: Int = 0
        public static let y: Int = 1
    }
}

extension uint2: Value {
    public static func value(from object: Any) throws -> uint2 {
        if let data = object as? Extractable {
            typealias keys = uint2.ExtractableKeys
            
            let x: UInt32 = try data.value(for: keys.x)
            let y: UInt32 = try data.value(for: keys.y)
            
            return uint2(x: x, y: y)
        }
        else if let data = object as? IndexExtractable {
            typealias indexes = uint2.ExtractableIndexes
            
            let x: UInt32 = try data.value(for: indexes.x)
            let y: UInt32 = try data.value(for: indexes.y)
            
            return uint2(x: x, y: y)
        }
        else {
            let expectedType = "Extractable or IndexExtractable"
            throw OutlawError.typeMismatch(expected: expectedType, actual: type(of: object))
        }
    }
}

extension uint2: Serializable {
    public func serialized() -> [String: UInt32] {
        typealias keys = uint2.ExtractableKeys
        
        var result = [String: UInt32]()
        result[keys.x] = self.x
        result[keys.y] = self.y
        
        return result
    }
}

extension uint2: IndexSerializable {
    public func serialized() -> [UInt32] {
        typealias indexes = uint2.ExtractableIndexes
        
        var result = [UInt32](repeating: 0, count: 2)
        result[indexes.x] = self.x
        result[indexes.y] = self.y
        
        return result
    }
}
