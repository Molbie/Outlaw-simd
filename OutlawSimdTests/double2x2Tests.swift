//
//  double2x2Tests.swift
//  OutlawSimd
//
//  Created by Brian Mullen on 12/17/16.
//  Copyright © 2016 Molbie LLC. All rights reserved.
//

import XCTest
import simd
import Outlaw
@testable import OutlawSimd


class double2x2Tests: XCTestCase {
    func testExtractableValue() {
        typealias keys = double2x2.ExtractableKeys
        typealias subkeys = double2.ExtractableKeys
        
        let rawData: [String: [String: Double]] = [keys.column0: [subkeys.x: 0,
                                                                  subkeys.y: 10],
                                                   keys.column1: [subkeys.x: 1,
                                                                  subkeys.y: 11]]
        let data: [String: [String: [String: Double]]] = ["value": rawData]
        let value: double2x2 = try! data.value(for: "value")
        
        XCTAssertEqual(value[0].x, rawData[keys.column0]?[subkeys.x])
        XCTAssertEqual(value[0].y, rawData[keys.column0]?[subkeys.y])
        
        XCTAssertEqual(value[1].x, rawData[keys.column1]?[subkeys.x])
        XCTAssertEqual(value[1].y, rawData[keys.column1]?[subkeys.y])
    }
    
    func testIndexExtractableValue() {
        let rawData: [[Double]] = [[0, 10],
                                   [1, 11]]
        let data: [[[Double]]] = [rawData]
        let value: double2x2 = try! data.value(for: 0)
        
        XCTAssertEqual(value[0].x, rawData[0][0])
        XCTAssertEqual(value[0].y, rawData[0][1])
        
        XCTAssertEqual(value[1].x, rawData[1][0])
        XCTAssertEqual(value[1].y, rawData[1][1])
    }
    
    func testInvalidValue() {
        let rawData: String = "Hello, Outlaw!"
        let data: [String] = [rawData]
        
        let ex = self.expectation(description: "Invalid data")
        do {
            let _: double2x2 = try data.value(for: 0)
        }
        catch {
            if case OutlawError.typeMismatchWithIndex = error {
                ex.fulfill()
            }
        }
        self.waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testSerializable() {
        typealias keys = double2x2.ExtractableKeys
        typealias subkeys = double2.ExtractableKeys
        
        let value = double2x2([double2(0, 10),
                               double2(1, 11)])
        let data: [String: [String: Double]] = value.serialized()
        
        XCTAssertEqual(data[keys.column0]?[subkeys.x], value[0].x)
        XCTAssertEqual(data[keys.column0]?[subkeys.y], value[0].y)
        
        XCTAssertEqual(data[keys.column1]?[subkeys.x], value[1].x)
        XCTAssertEqual(data[keys.column1]?[subkeys.y], value[1].y)
    }
    
    func testIndexSerializable() {
        let value = double2x2([double2(0, 10),
                               double2(1, 11)])
        let data: [[Double]] = value.serialized()
        
        XCTAssertEqual(data[0][0], value[0].x)
        XCTAssertEqual(data[0][1], value[0].y)
        
        XCTAssertEqual(data[1][0], value[1].x)
        XCTAssertEqual(data[1][1], value[1].y)
    }
}
