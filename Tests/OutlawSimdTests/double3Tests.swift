//
//  double3Tests.swift
//  OutlawSimd
//
//  Created by Brian Mullen on 12/17/16.
//  Copyright © 2016 Molbie LLC. All rights reserved.
//

import XCTest
import simd
import Outlaw
@testable import OutlawSimd


class double3Tests: XCTestCase {
    private typealias keys = SIMD3<Double>.keys
    private typealias indexes = SIMD3<Double>.indexes
    
    func testExtractableValue() {
        let rawData: [String: Double] = [keys.x: 1,
                                         keys.y: 2,
                                         keys.z: 3]
        let data: [String: [String: Double]] = ["value": rawData]
        let value: double3 = try! data.value(for: "value")
        
        XCTAssertEqual(value.x, rawData[keys.x])
        XCTAssertEqual(value.y, rawData[keys.y])
        XCTAssertEqual(value.z, rawData[keys.z])
    }
    
    func testIndexExtractableValue() {
        var rawData = [Double](repeating: 0, count: 3)
        rawData[indexes.x] = 1
        rawData[indexes.y] = 2
        rawData[indexes.z] = 3
        
        let data: [[Double]] = [rawData]
        let value: double3 = try! data.value(for: 0)
        
        XCTAssertEqual(value.x, rawData[indexes.x])
        XCTAssertEqual(value.y, rawData[indexes.y])
        XCTAssertEqual(value.z, rawData[indexes.z])
    }
    
    func testInvalidValue() {
        let rawData: String = "Hello, Outlaw!"
        let data: [String] = [rawData]
        
        let ex = self.expectation(description: "Invalid data")
        do {
            let _: double3 = try data.value(for: 0)
        }
        catch {
            if case OutlawError.typeMismatchWithIndex = error {
                ex.fulfill()
            }
        }
        self.waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testSerializable() {
        let value = double3(x: 1, y: 2, z: 3)
        let data = value.serialized()
        
        XCTAssertEqual(data[keys.x], value.x)
        XCTAssertEqual(data[keys.y], value.y)
        XCTAssertEqual(data[keys.z], value.z)
    }
    
    func testIndexSerializable() {
        let value = double3(x: 1, y: 2, z: 3)
        let data = value.serializedIndexes()
        
        XCTAssertEqual(data[indexes.x], value.x)
        XCTAssertEqual(data[indexes.y], value.y)
        XCTAssertEqual(data[indexes.z], value.z)
    }
}
