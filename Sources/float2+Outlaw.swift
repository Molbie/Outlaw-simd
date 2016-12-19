//
//  float2+Outlaw.swift
//  OutlawSimd
//
//  Created by Brian Mullen on 12/11/16.
//  Copyright © 2016 Molbie LLC. All rights reserved.
//

import simd
import Outlaw


public extension float2 {
    public struct ExtractableKeys {
        public static let x = "x"
        public static let y = "y"
    }
}

extension float2: Value {
    public static func value(from object: Any) throws -> float2 {
        if let data = object as? Extractable {
            typealias keys = float2.ExtractableKeys
            
            let x: Float = try data.value(for: keys.x)
            let y: Float = try data.value(for: keys.y)
            
            return float2(x: x, y: y)
        }
        else if let data = object as? IndexExtractable {
            let x: Float = try data.value(for: 0)
            let y: Float = try data.value(for: 1)
            
            return float2(x: x, y: y)
        }
        else {
            let expectedType = "Extractable or IndexExtractable"
            throw OutlawError.typeMismatch(expected: expectedType, actual: type(of: object))
        }
    }
}

extension float2: Serializable {
    public func serialized() -> [String: Float] {
        typealias keys = float2.ExtractableKeys
        
        var result = [String: Float]()
        result[keys.x] = self.x
        result[keys.y] = self.y
        
        return result
    }
}

extension float2: IndexSerializable {
    public func serialized() -> [Float] {
        return [self.x, self.y]
    }
}
