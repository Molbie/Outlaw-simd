//
//  double4+Outlaw.swift
//  OutlawSimd
//
//  Created by Brian Mullen on 12/11/16.
//  Copyright © 2016 Molbie LLC. All rights reserved.
//

import simd
import Outlaw


public extension double4 {
    public struct ExtractableKeys {
        public static let x = "x"
        public static let y = "y"
        public static let z = "z"
        public static let w = "w"
    }
}

extension double4: Value {
    public static func value(from object: Any) throws -> double4 {
        if let data = object as? Extractable {
            typealias keys = double4.ExtractableKeys
            
            let x: Double = try data.value(for: keys.x)
            let y: Double = try data.value(for: keys.y)
            let z: Double = try data.value(for: keys.z)
            let w: Double = try data.value(for: keys.w)
            
            return double4(x: x, y: y, z: z, w: w)
        }
        else if let data = object as? IndexExtractable {
            let x: Double = try data.value(for: 0)
            let y: Double = try data.value(for: 1)
            let z: Double = try data.value(for: 2)
            let w: Double = try data.value(for: 3)
            
            return double4(x: x, y: y, z: z, w: w)
        }
        else {
            let expectedType = "Extractable or IndexExtractable"
            throw OutlawError.typeMismatch(expected: expectedType, actual: type(of: object))
        }
    }
}

extension double4: Serializable {
    public func serialized() -> [String: Double] {
        typealias keys = double4.ExtractableKeys
        
        var result = [String: Double]()
        result[keys.x] = self.x
        result[keys.y] = self.y
        result[keys.z] = self.z
        result[keys.w] = self.w
        
        return result
    }
}

extension double4: IndexSerializable {
    public func serialized() -> [Double] {
        return [self.x, self.y, self.z, self.w]
    }
}
