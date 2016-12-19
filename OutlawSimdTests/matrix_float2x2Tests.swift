//
//  matrix_float2x2Tests.swift
//  OutlawSimd
//
//  Created by Brian Mullen on 12/17/16.
//  Copyright © 2016 Molbie LLC. All rights reserved.
//

import XCTest
import simd
import Outlaw
@testable import OutlawSimd


class matrix_float2x2Tests: XCTestCase {
    func testExtractableValue() {
        typealias keys = matrix_float2x2.ExtractableKeys
        typealias subkeys = vector_float2.ExtractableKeys
        
        let rawData: [String: [String: Float]] = [keys.column0: [subkeys.x: 0,
                                                                 subkeys.y: 10],
                                                  keys.column1: [subkeys.x: 1,
                                                                 subkeys.y: 11]]
        let data: [String: [String: [String: Float]]] = ["value": rawData]
        let value: matrix_float2x2 = try! data.value(for: "value")
        
        XCTAssertEqual(value.columns.0.x, rawData[keys.column0]?[subkeys.x])
        XCTAssertEqual(value.columns.0.y, rawData[keys.column0]?[subkeys.y])
        
        XCTAssertEqual(value.columns.1.x, rawData[keys.column1]?[subkeys.x])
        XCTAssertEqual(value.columns.1.y, rawData[keys.column1]?[subkeys.y])
    }
    
    func testIndexExtractableValue() {
        let rawData: [[Float]] = [[0, 10],
                                  [1, 11]]
        let data: [[[Float]]] = [rawData]
        let value: matrix_float2x2 = try! data.value(for: 0)
        
        XCTAssertEqual(value.columns.0.x, rawData[0][0])
        XCTAssertEqual(value.columns.0.y, rawData[0][1])
        
        XCTAssertEqual(value.columns.1.x, rawData[1][0])
        XCTAssertEqual(value.columns.1.y, rawData[1][1])
    }
    
    func testInvalidValue() {
        let rawData: String = "Hello, Outlaw!"
        let data: [String] = [rawData]
        
        let ex = self.expectation(description: "Invalid data")
        do {
            let _: matrix_float2x2 = try data.value(for: 0)
        }
        catch {
            if case OutlawError.typeMismatchWithIndex = error {
                ex.fulfill()
            }
        }
        self.waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testSerializable() {
        typealias keys = matrix_float2x2.ExtractableKeys
        typealias subkeys = vector_float2.ExtractableKeys
        
        let value = matrix_float2x2(columns: (vector_float2(0, 10),
                                              vector_float2(1, 11)))
        let data: [String: [String: Float]] = value.serialized()
        
        XCTAssertEqual(data[keys.column0]?[subkeys.x], value.columns.0.x)
        XCTAssertEqual(data[keys.column0]?[subkeys.y], value.columns.0.y)
        
        XCTAssertEqual(data[keys.column1]?[subkeys.x], value.columns.1.x)
        XCTAssertEqual(data[keys.column1]?[subkeys.y], value.columns.1.y)
    }
    
    func testIndexSerializable() {
        let value = matrix_float2x2(columns: (vector_float2(0, 10),
                                              vector_float2(1, 11)))
        let data: [[Float]] = value.serialized()
        
        XCTAssertEqual(data[0][0], value.columns.0.x)
        XCTAssertEqual(data[0][1], value.columns.0.y)
        
        XCTAssertEqual(data[1][0], value.columns.1.x)
        XCTAssertEqual(data[1][1], value.columns.1.y)
    }
}
