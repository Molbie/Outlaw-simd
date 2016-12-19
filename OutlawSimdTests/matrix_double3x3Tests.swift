//
//  matrix_double3x3Tests.swift
//  OutlawSimd
//
//  Created by Brian Mullen on 12/17/16.
//  Copyright © 2016 Molbie LLC. All rights reserved.
//

import XCTest
import simd
import Outlaw
@testable import OutlawSimd


class matrix_double3x3Tests: XCTestCase {
    func testExtractableValue() {
        typealias keys = matrix_double3x3.ExtractableKeys
        typealias subkeys = vector_double3.ExtractableKeys
        
        let rawData: [String: [String: Double]] = [keys.column0: [subkeys.x: 0,
                                                                  subkeys.y: 10,
                                                                  subkeys.z: 20],
                                                   keys.column1: [subkeys.x: 1,
                                                                  subkeys.y: 11,
                                                                  subkeys.z: 21],
                                                   keys.column2: [subkeys.x: 2,
                                                                  subkeys.y: 12,
                                                                  subkeys.z: 22]]
        let data: [String: [String: [String: Double]]] = ["value": rawData]
        let value: matrix_double3x3 = try! data.value(for: "value")
        
        XCTAssertEqual(value.columns.0.x, rawData[keys.column0]?[subkeys.x])
        XCTAssertEqual(value.columns.0.y, rawData[keys.column0]?[subkeys.y])
        XCTAssertEqual(value.columns.0.z, rawData[keys.column0]?[subkeys.z])
        
        XCTAssertEqual(value.columns.1.x, rawData[keys.column1]?[subkeys.x])
        XCTAssertEqual(value.columns.1.y, rawData[keys.column1]?[subkeys.y])
        XCTAssertEqual(value.columns.1.z, rawData[keys.column1]?[subkeys.z])
        
        XCTAssertEqual(value.columns.2.x, rawData[keys.column2]?[subkeys.x])
        XCTAssertEqual(value.columns.2.y, rawData[keys.column2]?[subkeys.y])
        XCTAssertEqual(value.columns.2.z, rawData[keys.column2]?[subkeys.z])
    }
    
    func testIndexExtractableValue() {
        let rawData: [[Double]] = [[0, 10, 20],
                                   [1, 11, 21],
                                   [2, 12, 22]]
        let data: [[[Double]]] = [rawData]
        let value: matrix_double3x3 = try! data.value(for: 0)
        
        XCTAssertEqual(value.columns.0.x, rawData[0][0])
        XCTAssertEqual(value.columns.0.y, rawData[0][1])
        XCTAssertEqual(value.columns.0.z, rawData[0][2])
        
        XCTAssertEqual(value.columns.1.x, rawData[1][0])
        XCTAssertEqual(value.columns.1.y, rawData[1][1])
        XCTAssertEqual(value.columns.1.z, rawData[1][2])
        
        XCTAssertEqual(value.columns.2.x, rawData[2][0])
        XCTAssertEqual(value.columns.2.y, rawData[2][1])
        XCTAssertEqual(value.columns.2.z, rawData[2][2])
    }
    
    func testInvalidValue() {
        let rawData: String = "Hello, Outlaw!"
        let data: [String] = [rawData]
        
        let ex = self.expectation(description: "Invalid data")
        do {
            let _: matrix_double3x3 = try data.value(for: 0)
        }
        catch {
            if case OutlawError.typeMismatchWithIndex = error {
                ex.fulfill()
            }
        }
        self.waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testSerializable() {
        typealias keys = matrix_double3x3.ExtractableKeys
        typealias subkeys = vector_double3.ExtractableKeys
        
        let value = matrix_double3x3(columns: (vector_double3(0, 10, 20),
                                               vector_double3(1, 11, 21),
                                               vector_double3(2, 12, 22)))
        let data: [String: [String: Double]] = value.serialized()
        
        XCTAssertEqual(data[keys.column0]?[subkeys.x], value.columns.0.x)
        XCTAssertEqual(data[keys.column0]?[subkeys.y], value.columns.0.y)
        XCTAssertEqual(data[keys.column0]?[subkeys.z], value.columns.0.z)
        
        XCTAssertEqual(data[keys.column1]?[subkeys.x], value.columns.1.x)
        XCTAssertEqual(data[keys.column1]?[subkeys.y], value.columns.1.y)
        XCTAssertEqual(data[keys.column1]?[subkeys.z], value.columns.1.z)
        
        XCTAssertEqual(data[keys.column2]?[subkeys.x], value.columns.2.x)
        XCTAssertEqual(data[keys.column2]?[subkeys.y], value.columns.2.y)
        XCTAssertEqual(data[keys.column2]?[subkeys.z], value.columns.2.z)
    }
    
    func testIndexSerializable() {
        let value = matrix_double3x3(columns: (vector_double3(0, 10, 20),
                                               vector_double3(1, 11, 21),
                                               vector_double3(2, 12, 22)))
        let data: [[Double]] = value.serialized()
        
        XCTAssertEqual(data[0][0], value.columns.0.x)
        XCTAssertEqual(data[0][1], value.columns.0.y)
        XCTAssertEqual(data[0][2], value.columns.0.z)
        
        XCTAssertEqual(data[1][0], value.columns.1.x)
        XCTAssertEqual(data[1][1], value.columns.1.y)
        XCTAssertEqual(data[1][2], value.columns.1.z)
        
        XCTAssertEqual(data[2][0], value.columns.2.x)
        XCTAssertEqual(data[2][1], value.columns.2.y)
        XCTAssertEqual(data[2][2], value.columns.2.z)
    }
}
