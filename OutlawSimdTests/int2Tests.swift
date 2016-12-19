//
//  int2Tests.swift
//  OutlawSimd
//
//  Created by Brian Mullen on 12/17/16.
//  Copyright © 2016 Molbie LLC. All rights reserved.
//

import XCTest
import simd
import Outlaw
@testable import OutlawSimd


class int2Tests: XCTestCase {
    func testExtractableValue() {
        typealias keys = int2.ExtractableKeys
        
        let rawData: [String: Int32] = [keys.x: 1,
                                        keys.y: 2]
        let data: [String: [String: Int32]] = ["value": rawData]
        let value: int2 = try! data.value(for: "value")
        
        XCTAssertEqual(value.x, rawData[keys.x])
        XCTAssertEqual(value.y, rawData[keys.y])
    }
    
    func testIndexExtractableValue() {
        let rawData: [Int32] = [1, 2]
        let data: [[Int32]] = [rawData]
        let value: int2 = try! data.value(for: 0)
        
        XCTAssertEqual(value.x, rawData[0])
        XCTAssertEqual(value.y, rawData[1])
    }
    
    func testInvalidValue() {
        let rawData: String = "Hello, Outlaw!"
        let data: [String] = [rawData]
        
        let ex = self.expectation(description: "Invalid data")
        do {
            let _: int2 = try data.value(for: 0)
        }
        catch {
            if case OutlawError.typeMismatchWithIndex = error {
                ex.fulfill()
            }
        }
        self.waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testSerializable() {
        typealias keys = int2.ExtractableKeys
        
        let value = int2(x: 1, y: 2)
        let data: [String: Int32] = value.serialized()
        
        XCTAssertEqual(data[keys.x], value.x)
        XCTAssertEqual(data[keys.y], value.y)
    }
    
    func testIndexSerializable() {
        let value = int2(x: 1, y: 2)
        let data: [Int32] = value.serialized()
        
        XCTAssertEqual(data[0], value.x)
        XCTAssertEqual(data[1], value.y)
    }
}
