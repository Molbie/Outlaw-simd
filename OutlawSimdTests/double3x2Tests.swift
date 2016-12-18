//
//  double3x2Tests.swift
//  OutlawSimd
//
//  Created by Brian Mullen on 12/17/16.
//  Copyright © 2016 Molbie LLC. All rights reserved.
//

import XCTest
import simd
import Outlaw
@testable import OutlawSimd


class double3x2Tests: XCTestCase {
    func testExtractableValue() {
        let rawData: [String: [String: Double]] = ["c0": ["x": 0, "y": 10],
                                                   "c1": ["x": 1, "y": 11],
                                                   "c2": ["x": 2, "y": 12]]
        let data: [String: [String: [String: Double]]] = ["value": rawData]
        let value: double3x2 = try! data.value(for: "value")
        
        XCTAssertEqual(value[0].x, rawData["c0"]?["x"])
        XCTAssertEqual(value[0].y, rawData["c0"]?["y"])
        
        XCTAssertEqual(value[1].x, rawData["c1"]?["x"])
        XCTAssertEqual(value[1].y, rawData["c1"]?["y"])
        
        XCTAssertEqual(value[2].x, rawData["c2"]?["x"])
        XCTAssertEqual(value[2].y, rawData["c2"]?["y"])
    }
    
    func testIndexExtractableValue() {
        let rawData: [[Double]] = [[0, 10],
                                   [1, 11],
                                   [2, 12]]
        let data: [[[Double]]] = [rawData]
        let value: double3x2 = try! data.value(for: 0)
        
        XCTAssertEqual(value[0].x, rawData[0][0])
        XCTAssertEqual(value[0].y, rawData[0][1])
        
        XCTAssertEqual(value[1].x, rawData[1][0])
        XCTAssertEqual(value[1].y, rawData[1][1])
        
        XCTAssertEqual(value[2].x, rawData[2][0])
        XCTAssertEqual(value[2].y, rawData[2][1])
    }
    
    func testInvalidValue() {
        let rawData: String = "Hello, Outlaw!"
        let data: [String] = [rawData]
        
        let ex = self.expectation(description: "Invalid data")
        do {
            let _: double3x2 = try data.value(for: 0)
        }
        catch {
            if case OutlawError.typeMismatchWithIndex = error {
                ex.fulfill()
            }
        }
        self.waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testSerializable() {
        let value = double3x2([double2(0, 10),
                               double2(1, 11),
                               double2(2, 12)])
        let data: [String: [String: Double]] = value.serialized()
        
        XCTAssertEqual(data["c0"]?["x"], value[0].x)
        XCTAssertEqual(data["c0"]?["y"], value[0].y)
        
        XCTAssertEqual(data["c1"]?["x"], value[1].x)
        XCTAssertEqual(data["c1"]?["y"], value[1].y)
        
        XCTAssertEqual(data["c2"]?["x"], value[2].x)
        XCTAssertEqual(data["c2"]?["y"], value[2].y)
    }
    
    func testIndexSerializable() {
        let value = double3x2([double2(0, 10),
                               double2(1, 11),
                               double2(2, 12)])
        let data: [[Double]] = value.serialized()
        
        XCTAssertEqual(data[0][0], value[0].x)
        XCTAssertEqual(data[0][1], value[0].y)
        
        XCTAssertEqual(data[1][0], value[1].x)
        XCTAssertEqual(data[1][1], value[1].y)
        
        XCTAssertEqual(data[2][0], value[2].x)
        XCTAssertEqual(data[2][1], value[2].y)
    }
}