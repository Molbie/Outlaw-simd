//
//  uint3Tests.swift
//  OutlawSimd
//
//  Created by Brian Mullen on 12/17/16.
//  Copyright © 2016 Molbie LLC. All rights reserved.
//

import XCTest
import simd
import Outlaw
@testable import OutlawSimd


class uint3Tests: XCTestCase {
    func testExtractableValue() {
        let rawData: [String: UInt32] = ["x": 1, "y": 2, "z": 3]
        let data: [String: [String: UInt32]] = ["value": rawData]
        let value: uint3 = try! data.value(for: "value")
        
        XCTAssertEqual(value.x, rawData["x"])
        XCTAssertEqual(value.y, rawData["y"])
        XCTAssertEqual(value.z, rawData["z"])
    }
    
    func testIndexExtractableValue() {
        let rawData: [UInt32] = [1, 2, 3]
        let data: [[UInt32]] = [rawData]
        let value: uint3 = try! data.value(for: 0)
        
        XCTAssertEqual(value.x, rawData[0])
        XCTAssertEqual(value.y, rawData[1])
        XCTAssertEqual(value.z, rawData[2])
    }
    
    func testInvalidValue() {
        let rawData: String = "Hello, Outlaw!"
        let data: [String] = [rawData]
        
        let ex = self.expectation(description: "Invalid data")
        do {
            let _: int3 = try data.value(for: 0)
        }
        catch {
            if case OutlawError.typeMismatchWithIndex = error {
                ex.fulfill()
            }
        }
        self.waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testSerializable() {
        let value = uint3(x: 1, y: 2, z: 3)
        let data: [String: UInt32] = value.serialized()
        
        XCTAssertEqual(data["x"], value.x)
        XCTAssertEqual(data["y"], value.y)
        XCTAssertEqual(data["z"], value.z)
    }
    
    func testIndexSerializable() {
        let value = uint3(x: 1, y: 2, z: 3)
        let data: [UInt32] = value.serialized()
        
        XCTAssertEqual(data[0], value.x)
        XCTAssertEqual(data[1], value.y)
        XCTAssertEqual(data[2], value.z)
    }
}
