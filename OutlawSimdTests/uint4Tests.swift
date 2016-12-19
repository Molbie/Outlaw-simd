//
//  uint4Tests.swift
//  OutlawSimd
//
//  Created by Brian Mullen on 12/17/16.
//  Copyright © 2016 Molbie LLC. All rights reserved.
//

import XCTest
import simd
import Outlaw
@testable import OutlawSimd


class uint4Tests: XCTestCase {
    func testExtractableValue() {
        typealias keys = uint4.ExtractableKeys
        
        let rawData: [String: UInt32] = [keys.x: 1,
                                         keys.y: 2,
                                         keys.z: 3,
                                         keys.w: 4]
        let data: [String: [String: UInt32]] = ["value": rawData]
        let value: uint4 = try! data.value(for: "value")
        
        XCTAssertEqual(value.x, rawData[keys.x])
        XCTAssertEqual(value.y, rawData[keys.y])
        XCTAssertEqual(value.z, rawData[keys.z])
        XCTAssertEqual(value.w, rawData[keys.w])
    }
    
    func testIndexExtractableValue() {
        let rawData: [UInt32] = [1, 2, 3, 4]
        let data: [[UInt32]] = [rawData]
        let value: uint4 = try! data.value(for: 0)
        
        XCTAssertEqual(value.x, rawData[0])
        XCTAssertEqual(value.y, rawData[1])
        XCTAssertEqual(value.z, rawData[2])
        XCTAssertEqual(value.w, rawData[3])
    }
    
    func testInvalidValue() {
        let rawData: String = "Hello, Outlaw!"
        let data: [String] = [rawData]
        
        let ex = self.expectation(description: "Invalid data")
        do {
            let _: uint4 = try data.value(for: 0)
        }
        catch {
            if case OutlawError.typeMismatchWithIndex = error {
                ex.fulfill()
            }
        }
        self.waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testSerializable() {
        typealias keys = uint4.ExtractableKeys
        
        let value = uint4(x: 1, y: 2, z: 3, w: 4)
        let data: [String: UInt32] = value.serialized()
        
        XCTAssertEqual(data[keys.x], value.x)
        XCTAssertEqual(data[keys.y], value.y)
        XCTAssertEqual(data[keys.z], value.z)
        XCTAssertEqual(data[keys.w], value.w)
    }
    
    func testIndexSerializable() {
        let value = uint4(x: 1, y: 2, z: 3, w: 4)
        let data: [UInt32] = value.serialized()
        
        XCTAssertEqual(data[0], value.x)
        XCTAssertEqual(data[1], value.y)
        XCTAssertEqual(data[2], value.z)
        XCTAssertEqual(data[3], value.w)
    }
}
