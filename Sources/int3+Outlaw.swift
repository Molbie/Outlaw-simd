//
//  int3+Outlaw.swift
//  OutlawSimd
//
//  Created by Brian Mullen on 12/11/16.
//  Copyright © 2016 Molbie LLC. All rights reserved.
//

import simd
import Outlaw


public extension int3 {
    public struct ExtractableKeys {
        public static let x = "x"
        public static let y = "y"
        public static let z = "z"
    }
}

extension int3: Value {
    public static func value(from object: Any) throws -> int3 {
        if let data = object as? Extractable {
            typealias keys = int3.ExtractableKeys
            
            let x: Int32 = try data.value(for: keys.x)
            let y: Int32 = try data.value(for: keys.y)
            let z: Int32 = try data.value(for: keys.z)
            
            return int3(x: x, y: y, z: z)
        }
        else if let data = object as? IndexExtractable {
            let x: Int32 = try data.value(for: 0)
            let y: Int32 = try data.value(for: 1)
            let z: Int32 = try data.value(for: 2)
            
            return int3(x: x, y: y, z: z)
        }
        else {
            let expectedType = "Extractable or IndexExtractable"
            throw OutlawError.typeMismatch(expected: expectedType, actual: type(of: object))
        }
    }
}

extension int3: Serializable {
    public func serialized() -> [String: Int32] {
        typealias keys = int3.ExtractableKeys
        
        var result = [String: Int32]()
        result[keys.x] = self.x
        result[keys.y] = self.y
        result[keys.z] = self.z
        
        return result
    }
}

extension int3: IndexSerializable {
    public func serialized() -> [Int32] {
        return [self.x, self.y, self.z]
    }
}
