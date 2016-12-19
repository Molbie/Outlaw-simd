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
    fileprivate typealias keys = uint4.ExtractableKeys
    fileprivate typealias indexes = uint4.ExtractableIndexes
    
    func testExtractableValue() {
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
        var rawData = [UInt32](repeating: 0, count: 4)
        rawData[indexes.x] = 1
        rawData[indexes.y] = 2
        rawData[indexes.z] = 3
        rawData[indexes.w] = 4
        
        let data: [[UInt32]] = [rawData]
        let value: uint4 = try! data.value(for: 0)
        
        XCTAssertEqual(value.x, rawData[indexes.x])
        XCTAssertEqual(value.y, rawData[indexes.y])
        XCTAssertEqual(value.z, rawData[indexes.z])
        XCTAssertEqual(value.w, rawData[indexes.w])
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
        let value = uint4(x: 1, y: 2, z: 3, w: 4)
        let data = value.serialized()
        
        XCTAssertEqual(data[keys.x], value.x)
        XCTAssertEqual(data[keys.y], value.y)
        XCTAssertEqual(data[keys.z], value.z)
        XCTAssertEqual(data[keys.w], value.w)
    }
    
    func testIndexSerializable() {
        let value = uint4(x: 1, y: 2, z: 3, w: 4)
        let data = value.serializedIndexes()
        
        XCTAssertEqual(data[indexes.x], value.x)
        XCTAssertEqual(data[indexes.y], value.y)
        XCTAssertEqual(data[indexes.z], value.z)
        XCTAssertEqual(data[indexes.w], value.w)
    }
}
