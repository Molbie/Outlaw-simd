//
//  matrix_double2x4Tests.swift
//  OutlawSimd
//
//  Created by Brian Mullen on 12/17/16.
//  Copyright © 2016 Molbie LLC. All rights reserved.
//

import XCTest
import simd
import Outlaw
@testable import OutlawSimd


class matrix_double2x4Tests: XCTestCase {
    func testExtractableValue() {
        typealias keys = matrix_double2x4.ExtractableKeys
        typealias subkeys = vector_double4.ExtractableKeys
        
        let rawData: [String: [String: Double]] = [keys.column0: [subkeys.x: 0,
                                                                  subkeys.y: 10,
                                                                  subkeys.z: 20,
                                                                  subkeys.w: 30],
                                                   keys.column1: [subkeys.x: 1,
                                                                  subkeys.y: 11,
                                                                  subkeys.z: 21,
                                                                  subkeys.w: 31]]
        let data: [String: [String: [String: Double]]] = ["value": rawData]
        let value: matrix_double2x4 = try! data.value(for: "value")
        
        XCTAssertEqual(value.columns.0.x, rawData[keys.column0]?[subkeys.x])
        XCTAssertEqual(value.columns.0.y, rawData[keys.column0]?[subkeys.y])
        XCTAssertEqual(value.columns.0.z, rawData[keys.column0]?[subkeys.z])
        XCTAssertEqual(value.columns.0.w, rawData[keys.column0]?[subkeys.w])
        
        XCTAssertEqual(value.columns.1.x, rawData[keys.column1]?[subkeys.x])
        XCTAssertEqual(value.columns.1.y, rawData[keys.column1]?[subkeys.y])
        XCTAssertEqual(value.columns.1.z, rawData[keys.column1]?[subkeys.z])
        XCTAssertEqual(value.columns.1.w, rawData[keys.column1]?[subkeys.w])
    }
    
    func testIndexExtractableValue() {
        let rawData: [[Double]] = [[0, 10, 20, 30],
                                   [1, 11, 21, 31]]
        let data: [[[Double]]] = [rawData]
        let value: matrix_double2x4 = try! data.value(for: 0)
        
        XCTAssertEqual(value.columns.0.x, rawData[0][0])
        XCTAssertEqual(value.columns.0.y, rawData[0][1])
        XCTAssertEqual(value.columns.0.z, rawData[0][2])
        XCTAssertEqual(value.columns.0.w, rawData[0][3])
        
        XCTAssertEqual(value.columns.1.x, rawData[1][0])
        XCTAssertEqual(value.columns.1.y, rawData[1][1])
        XCTAssertEqual(value.columns.1.z, rawData[1][2])
        XCTAssertEqual(value.columns.1.w, rawData[1][3])
    }
    
    func testInvalidValue() {
        let rawData: String = "Hello, Outlaw!"
        let data: [String] = [rawData]
        
        let ex = self.expectation(description: "Invalid data")
        do {
            let _: matrix_double2x4 = try data.value(for: 0)
        }
        catch {
            if case OutlawError.typeMismatchWithIndex = error {
                ex.fulfill()
            }
        }
        self.waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testSerializable() {
        typealias keys = matrix_double2x4.ExtractableKeys
        typealias subkeys = vector_double4.ExtractableKeys
        
        let value = matrix_double2x4(columns: (vector_double4(0, 10, 20, 30),
                                               vector_double4(1, 11, 21, 31)))
        let data: [String: [String: Double]] = value.serialized()
        
        XCTAssertEqual(data[keys.column0]?[subkeys.x], value.columns.0.x)
        XCTAssertEqual(data[keys.column0]?[subkeys.y], value.columns.0.y)
        XCTAssertEqual(data[keys.column0]?[subkeys.z], value.columns.0.z)
        XCTAssertEqual(data[keys.column0]?[subkeys.w], value.columns.0.w)
        
        XCTAssertEqual(data[keys.column1]?[subkeys.x], value.columns.1.x)
        XCTAssertEqual(data[keys.column1]?[subkeys.y], value.columns.1.y)
        XCTAssertEqual(data[keys.column1]?[subkeys.z], value.columns.1.z)
        XCTAssertEqual(data[keys.column1]?[subkeys.w], value.columns.1.w)
    }
    
    func testIndexSerializable() {
        let value = matrix_double2x4(columns: (vector_double4(0, 10, 20, 30),
                                               vector_double4(1, 11, 21, 31)))
        let data: [[Double]] = value.serialized()
        
        XCTAssertEqual(data[0][0], value.columns.0.x)
        XCTAssertEqual(data[0][1], value.columns.0.y)
        XCTAssertEqual(data[0][2], value.columns.0.z)
        XCTAssertEqual(data[0][3], value.columns.0.w)
        
        XCTAssertEqual(data[1][0], value.columns.1.x)
        XCTAssertEqual(data[1][1], value.columns.1.y)
        XCTAssertEqual(data[1][2], value.columns.1.z)
        XCTAssertEqual(data[1][3], value.columns.1.w)
    }
}
