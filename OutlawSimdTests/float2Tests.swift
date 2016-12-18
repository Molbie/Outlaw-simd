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
    func testExtractableValue() {
        let rawData: [String: Float] = ["x": 1, "y": 2]
        let data: [String: [String: Float]] = ["value": rawData]
        let value: float2 = try! data.value(for: "value")
        
        XCTAssertEqual(value.x, rawData["x"])
        XCTAssertEqual(value.y, rawData["y"])
    }
    
    func testIndexExtractableValue() {
        let rawData: [Float] = [1, 2]
        let data: [[Float]] = [rawData]
        let value: float2 = try! data.value(for: 0)
        
        XCTAssertEqual(value.x, rawData[0])
        XCTAssertEqual(value.y, rawData[1])
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
        let data: [String: Float] = value.serialized()
        
        XCTAssertEqual(data["x"], value.x)
        XCTAssertEqual(data["y"], value.y)
    }
    
    func testIndexSerializable() {
        let value = float2(x: 1, y: 2)
        let data: [Float] = value.serialized()
        
        XCTAssertEqual(data[0], value.x)
        XCTAssertEqual(data[1], value.y)
    }
}
