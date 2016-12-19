//
//  float3Tests.swift
//  OutlawSimd
//
//  Created by Brian Mullen on 12/17/16.
//  Copyright © 2016 Molbie LLC. All rights reserved.
//

import XCTest
import simd
import Outlaw
@testable import OutlawSimd


class float3Tests: XCTestCase {
    fileprivate typealias keys = float3.ExtractableKeys
    fileprivate typealias indexes = float3.ExtractableIndexes
    
    func testExtractableValue() {
        let rawData: [String: Float] = [keys.x: 1,
                                        keys.y: 2,
                                        keys.z: 3]
        let data: [String: [String: Float]] = ["value": rawData]
        let value: float3 = try! data.value(for: "value")
        
        XCTAssertEqual(value.x, rawData[keys.x])
        XCTAssertEqual(value.y, rawData[keys.y])
        XCTAssertEqual(value.z, rawData[keys.z])
    }
    
    func testIndexExtractableValue() {
        var rawData = [Float](repeating: 0, count: 3)
        rawData[indexes.x] = 1
        rawData[indexes.y] = 2
        rawData[indexes.z] = 3
        
        let data: [[Float]] = [rawData]
        let value: float3 = try! data.value(for: 0)
        
        XCTAssertEqual(value.x, rawData[indexes.x])
        XCTAssertEqual(value.y, rawData[indexes.y])
        XCTAssertEqual(value.z, rawData[indexes.z])
    }
    
    func testInvalidValue() {
        let rawData: String = "Hello, Outlaw!"
        let data: [String] = [rawData]
        
        let ex = self.expectation(description: "Invalid data")
        do {
            let _: float3 = try data.value(for: 0)
        }
        catch {
            if case OutlawError.typeMismatchWithIndex = error {
                ex.fulfill()
            }
        }
        self.waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testSerializable() {
        let value = float3(x: 1, y: 2, z: 3)
        let data: [String: Float] = value.serialized()
        
        XCTAssertEqual(data[keys.x], value.x)
        XCTAssertEqual(data[keys.y], value.y)
        XCTAssertEqual(data[keys.z], value.z)
    }
    
    func testIndexSerializable() {
        let value = float3(x: 1, y: 2, z: 3)
        let data: [Float] = value.serialized()
        
        XCTAssertEqual(data[indexes.x], value.x)
        XCTAssertEqual(data[indexes.y], value.y)
        XCTAssertEqual(data[indexes.z], value.z)
    }
}
