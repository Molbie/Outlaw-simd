//
//  float2Tests.swift
//  OutlawSimd
//
//  Created by Brian Mullen on 12/17/16.
//  Copyright © 2016 Molbie LLC. All rights reserved.
//

import XCTest
import simd
import Outlaw
@testable import OutlawSimd


class float2Tests: XCTestCase {
    private typealias keys = SIMD2<Float>.keys
    private typealias indexes = SIMD2<Float>.indexes
    
    func testExtractableValue() {
        let rawData: [String: Float] = [keys.x: 1,
                                        keys.y: 2]
        let data: [String: [String: Float]] = ["value": rawData]
        let value: float2 = try! data.value(for: "value")
        
        XCTAssertEqual(value.x, rawData[keys.x])
        XCTAssertEqual(value.y, rawData[keys.y])
    }
    
    func testIndexExtractableValue() {
        var rawData = [Float](repeating: 0, count: 2)
        rawData[indexes.x] = 1
        rawData[indexes.y] = 2
        
        let data: [[Float]] = [rawData]
        let value: float2 = try! data.value(for: 0)
        
        XCTAssertEqual(value.x, rawData[indexes.x])
        XCTAssertEqual(value.y, rawData[indexes.y])
    }
    
    func testInvalidValue() {
        let rawData: String = "Hello, Outlaw!"
        let data: [String] = [rawData]
        
        let ex = self.expectation(description: "Invalid data")
        do {
            let _: float2 = try data.value(for: 0)
        }
        catch {
            if case OutlawError.typeMismatchWithIndex = error {
                ex.fulfill()
            }
        }
        self.waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testSerializable() {
        let value = float2(x: 1, y: 2)
        let data = value.serialized()
        
        XCTAssertEqual(data[keys.x], value.x)
        XCTAssertEqual(data[keys.y], value.y)
    }
    
    func testIndexSerializable() {
        let value = float2(x: 1, y: 2)
        let data = value.serializedIndexes()
        
        XCTAssertEqual(data[indexes.x], value.x)
        XCTAssertEqual(data[indexes.y], value.y)
    }
}
