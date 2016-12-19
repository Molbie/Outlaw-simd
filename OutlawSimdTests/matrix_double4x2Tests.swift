//
//  matrix_double4x2Tests.swift
//  OutlawSimd
//
//  Created by Brian Mullen on 12/17/16.
//  Copyright © 2016 Molbie LLC. All rights reserved.
//

import XCTest
import simd
import Outlaw
@testable import OutlawSimd


class matrix_double4x2Tests: XCTestCase {
    func testExtractableValue() {
        typealias keys = matrix_double4x2.ExtractableKeys
        typealias subkeys = vector_double2.ExtractableKeys
        
        let rawData: [String: [String: Double]] = [keys.column0: [subkeys.x: 0,
                                                                  subkeys.y: 10],
                                                   keys.column1: [subkeys.x: 1,
                                                                  subkeys.y: 11],
                                                   keys.column2: [subkeys.x: 2,
                                                                  subkeys.y: 12],
                                                   keys.column3: [subkeys.x: 3,
                                                                  subkeys.y: 13]]
        let data: [String: [String: [String: Double]]] = ["value": rawData]
        let value: matrix_double4x2 = try! data.value(for: "value")
        
        XCTAssertEqual(value.columns.0.x, rawData[keys.column0]?[subkeys.x])
        XCTAssertEqual(value.columns.0.y, rawData[keys.column0]?[subkeys.y])
        
        XCTAssertEqual(value.columns.1.x, rawData[keys.column1]?[subkeys.x])
        XCTAssertEqual(value.columns.1.y, rawData[keys.column1]?[subkeys.y])
        
        XCTAssertEqual(value.columns.2.x, rawData[keys.column2]?[subkeys.x])
        XCTAssertEqual(value.columns.2.y, rawData[keys.column2]?[subkeys.y])
        
        XCTAssertEqual(value.columns.3.x, rawData[keys.column3]?[subkeys.x])
        XCTAssertEqual(value.columns.3.y, rawData[keys.column3]?[subkeys.y])
    }
    
    func testIndexExtractableValue() {
        typealias indexes = matrix_double4x2.ExtractableIndexes
        typealias subindexes = vector_double2.ExtractableIndexes
        
        var rawData0 = [Double](repeating: 0, count: 2)
        rawData0[subindexes.x] = 0
        rawData0[subindexes.y] = 10
        var rawData1 = [Double](repeating: 0, count: 2)
        rawData1[subindexes.x] = 1
        rawData1[subindexes.y] = 11
        var rawData2 = [Double](repeating: 0, count: 2)
        rawData2[subindexes.x] = 2
        rawData2[subindexes.y] = 12
        var rawData3 = [Double](repeating: 0, count: 2)
        rawData3[subindexes.x] = 3
        rawData3[subindexes.y] = 13
        
        var rawData = [[Double]](repeating: [0], count: 4)
        rawData[indexes.column0] = rawData0
        rawData[indexes.column1] = rawData1
        rawData[indexes.column2] = rawData2
        rawData[indexes.column3] = rawData3
        
        let data: [[[Double]]] = [rawData]
        let value: matrix_double4x2 = try! data.value(for: 0)
        
        XCTAssertEqual(value.columns.0.x, rawData[indexes.column0][subindexes.x])
        XCTAssertEqual(value.columns.0.y, rawData[indexes.column0][subindexes.y])
        
        XCTAssertEqual(value.columns.1.x, rawData[indexes.column1][subindexes.x])
        XCTAssertEqual(value.columns.1.y, rawData[indexes.column1][subindexes.y])
        
        XCTAssertEqual(value.columns.2.x, rawData[indexes.column2][subindexes.x])
        XCTAssertEqual(value.columns.2.y, rawData[indexes.column2][subindexes.y])
        
        XCTAssertEqual(value.columns.3.x, rawData[indexes.column3][subindexes.x])
        XCTAssertEqual(value.columns.3.y, rawData[indexes.column3][subindexes.y])
    }
    
    func testInvalidValue() {
        let rawData: String = "Hello, Outlaw!"
        let data: [String] = [rawData]
        
        let ex = self.expectation(description: "Invalid data")
        do {
            let _: matrix_double4x2 = try data.value(for: 0)
        }
        catch {
            if case OutlawError.typeMismatchWithIndex = error {
                ex.fulfill()
            }
        }
        self.waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testSerializable() {
        typealias keys = matrix_double4x2.ExtractableKeys
        typealias subkeys = vector_double2.ExtractableKeys
        
        let value = matrix_double4x2(columns: (vector_double2(0, 10),
                                               vector_double2(1, 11),
                                               vector_double2(2, 12),
                                               vector_double2(3, 13)))
        let data: [String: [String: Double]] = value.serialized()
        
        XCTAssertEqual(data[keys.column0]?[subkeys.x], value.columns.0.x)
        XCTAssertEqual(data[keys.column0]?[subkeys.y], value.columns.0.y)
        
        XCTAssertEqual(data[keys.column1]?[subkeys.x], value.columns.1.x)
        XCTAssertEqual(data[keys.column1]?[subkeys.y], value.columns.1.y)
        
        XCTAssertEqual(data[keys.column2]?[subkeys.x], value.columns.2.x)
        XCTAssertEqual(data[keys.column2]?[subkeys.y], value.columns.2.y)
        
        XCTAssertEqual(data[keys.column3]?[subkeys.x], value.columns.3.x)
        XCTAssertEqual(data[keys.column3]?[subkeys.y], value.columns.3.y)
    }
    
    func testIndexSerializable() {
        typealias indexes = matrix_double4x2.ExtractableIndexes
        typealias subindexes = vector_double2.ExtractableIndexes
        
        let value = matrix_double4x2(columns: (vector_double2(0, 10),
                                               vector_double2(1, 11),
                                               vector_double2(2, 12),
                                               vector_double2(3, 13)))
        let data: [[Double]] = value.serialized()
        
        XCTAssertEqual(data[indexes.column0][subindexes.x], value.columns.0.x)
        XCTAssertEqual(data[indexes.column0][subindexes.y], value.columns.0.y)
        
        XCTAssertEqual(data[indexes.column1][subindexes.x], value.columns.1.x)
        XCTAssertEqual(data[indexes.column1][subindexes.y], value.columns.1.y)
        
        XCTAssertEqual(data[indexes.column2][subindexes.x], value.columns.2.x)
        XCTAssertEqual(data[indexes.column2][subindexes.y], value.columns.2.y)
        
        XCTAssertEqual(data[indexes.column3][subindexes.x], value.columns.3.x)
        XCTAssertEqual(data[indexes.column3][subindexes.y], value.columns.3.y)
    }
}
