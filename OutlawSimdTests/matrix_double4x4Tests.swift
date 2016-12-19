//
//  matrix_double4x4Tests.swift
//  OutlawSimd
//
//  Created by Brian Mullen on 12/17/16.
//  Copyright © 2016 Molbie LLC. All rights reserved.
//

import XCTest
import simd
import Outlaw
@testable import OutlawSimd


class matrix_double4x4Tests: XCTestCase {
    fileprivate typealias keys = matrix_double4x4.ExtractableKeys
    fileprivate typealias subkeys = vector_double4.ExtractableKeys
    fileprivate typealias indexes = matrix_double4x4.ExtractableIndexes
    fileprivate typealias subindexes = vector_double4.ExtractableIndexes
    
    func testExtractableValue() {
        let rawData: [String: [String: Double]] = [keys.column0: [subkeys.x: 0,
                                                                  subkeys.y: 10,
                                                                  subkeys.z: 20,
                                                                  subkeys.w: 30],
                                                   keys.column1: [subkeys.x: 1,
                                                                  subkeys.y: 11,
                                                                  subkeys.z: 21,
                                                                  subkeys.w: 31],
                                                   keys.column2: [subkeys.x: 2,
                                                                  subkeys.y: 12,
                                                                  subkeys.z: 22,
                                                                  subkeys.w: 32],
                                                   keys.column3: [subkeys.x: 3,
                                                                  subkeys.y: 13,
                                                                  subkeys.z: 23,
                                                                  subkeys.w: 33]]
        let data: [String: [String: [String: Double]]] = ["value": rawData]
        let value: matrix_double4x4 = try! data.value(for: "value")
        
        XCTAssertEqual(value.columns.0.x, rawData[keys.column0]?[subkeys.x])
        XCTAssertEqual(value.columns.0.y, rawData[keys.column0]?[subkeys.y])
        XCTAssertEqual(value.columns.0.z, rawData[keys.column0]?[subkeys.z])
        XCTAssertEqual(value.columns.0.w, rawData[keys.column0]?[subkeys.w])
        
        XCTAssertEqual(value.columns.1.x, rawData[keys.column1]?[subkeys.x])
        XCTAssertEqual(value.columns.1.y, rawData[keys.column1]?[subkeys.y])
        XCTAssertEqual(value.columns.1.z, rawData[keys.column1]?[subkeys.z])
        XCTAssertEqual(value.columns.1.w, rawData[keys.column1]?[subkeys.w])
        
        XCTAssertEqual(value.columns.2.x, rawData[keys.column2]?[subkeys.x])
        XCTAssertEqual(value.columns.2.y, rawData[keys.column2]?[subkeys.y])
        XCTAssertEqual(value.columns.2.z, rawData[keys.column2]?[subkeys.z])
        XCTAssertEqual(value.columns.2.w, rawData[keys.column2]?[subkeys.w])
        
        XCTAssertEqual(value.columns.3.x, rawData[keys.column3]?[subkeys.x])
        XCTAssertEqual(value.columns.3.y, rawData[keys.column3]?[subkeys.y])
        XCTAssertEqual(value.columns.3.z, rawData[keys.column3]?[subkeys.z])
        XCTAssertEqual(value.columns.3.w, rawData[keys.column3]?[subkeys.w])
    }
    
    func testIndexExtractableValue() {
        var rawData0 = [Double](repeating: 0, count: 4)
        rawData0[subindexes.x] = 0
        rawData0[subindexes.y] = 10
        rawData0[subindexes.z] = 20
        rawData0[subindexes.w] = 30
        var rawData1 = [Double](repeating: 0, count: 4)
        rawData1[subindexes.x] = 1
        rawData1[subindexes.y] = 11
        rawData1[subindexes.z] = 21
        rawData1[subindexes.w] = 31
        var rawData2 = [Double](repeating: 0, count: 4)
        rawData2[subindexes.x] = 2
        rawData2[subindexes.y] = 12
        rawData2[subindexes.z] = 22
        rawData2[subindexes.w] = 32
        var rawData3 = [Double](repeating: 0, count: 4)
        rawData3[subindexes.x] = 3
        rawData3[subindexes.y] = 13
        rawData3[subindexes.z] = 23
        rawData3[subindexes.w] = 33
        
        var rawData = [[Double]](repeating: [0], count: 4)
        rawData[indexes.column0] = rawData0
        rawData[indexes.column1] = rawData1
        rawData[indexes.column2] = rawData2
        rawData[indexes.column3] = rawData3
        
        let data: [[[Double]]] = [rawData]
        let value: matrix_double4x4 = try! data.value(for: 0)
        
        XCTAssertEqual(value.columns.0.x, rawData[indexes.column0][subindexes.x])
        XCTAssertEqual(value.columns.0.y, rawData[indexes.column0][subindexes.y])
        XCTAssertEqual(value.columns.0.z, rawData[indexes.column0][subindexes.z])
        XCTAssertEqual(value.columns.0.w, rawData[indexes.column0][subindexes.w])
        
        XCTAssertEqual(value.columns.1.x, rawData[indexes.column1][subindexes.x])
        XCTAssertEqual(value.columns.1.y, rawData[indexes.column1][subindexes.y])
        XCTAssertEqual(value.columns.1.z, rawData[indexes.column1][subindexes.z])
        XCTAssertEqual(value.columns.1.w, rawData[indexes.column1][subindexes.w])
        
        XCTAssertEqual(value.columns.2.x, rawData[indexes.column2][subindexes.x])
        XCTAssertEqual(value.columns.2.y, rawData[indexes.column2][subindexes.y])
        XCTAssertEqual(value.columns.2.z, rawData[indexes.column2][subindexes.z])
        XCTAssertEqual(value.columns.2.w, rawData[indexes.column2][subindexes.w])
        
        XCTAssertEqual(value.columns.3.x, rawData[indexes.column3][subindexes.x])
        XCTAssertEqual(value.columns.3.y, rawData[indexes.column3][subindexes.y])
        XCTAssertEqual(value.columns.3.z, rawData[indexes.column3][subindexes.z])
        XCTAssertEqual(value.columns.3.w, rawData[indexes.column3][subindexes.w])
    }
    
    func testInvalidValue() {
        let rawData: String = "Hello, Outlaw!"
        let data: [String] = [rawData]
        
        let ex = self.expectation(description: "Invalid data")
        do {
            let _: matrix_double4x4 = try data.value(for: 0)
        }
        catch {
            if case OutlawError.typeMismatchWithIndex = error {
                ex.fulfill()
            }
        }
        self.waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testSerializable() {
        let value = matrix_double4x4(columns: (vector_double4(0, 10, 20, 30),
                                               vector_double4(1, 11, 21, 31),
                                               vector_double4(2, 12, 22, 32),
                                               vector_double4(3, 13, 23, 33)))
        let data: [String: [String: Double]] = value.serialized()
        
        XCTAssertEqual(data[keys.column0]?[subkeys.x], value.columns.0.x)
        XCTAssertEqual(data[keys.column0]?[subkeys.y], value.columns.0.y)
        XCTAssertEqual(data[keys.column0]?[subkeys.z], value.columns.0.z)
        XCTAssertEqual(data[keys.column0]?[subkeys.w], value.columns.0.w)
        
        XCTAssertEqual(data[keys.column1]?[subkeys.x], value.columns.1.x)
        XCTAssertEqual(data[keys.column1]?[subkeys.y], value.columns.1.y)
        XCTAssertEqual(data[keys.column1]?[subkeys.z], value.columns.1.z)
        XCTAssertEqual(data[keys.column1]?[subkeys.w], value.columns.1.w)
        
        XCTAssertEqual(data[keys.column2]?[subkeys.x], value.columns.2.x)
        XCTAssertEqual(data[keys.column2]?[subkeys.y], value.columns.2.y)
        XCTAssertEqual(data[keys.column2]?[subkeys.z], value.columns.2.z)
        XCTAssertEqual(data[keys.column2]?[subkeys.w], value.columns.2.w)
        
        XCTAssertEqual(data[keys.column3]?[subkeys.x], value.columns.3.x)
        XCTAssertEqual(data[keys.column3]?[subkeys.y], value.columns.3.y)
        XCTAssertEqual(data[keys.column3]?[subkeys.z], value.columns.3.z)
        XCTAssertEqual(data[keys.column3]?[subkeys.w], value.columns.3.w)
    }
    
    func testIndexSerializable() {
        let value = matrix_double4x4(columns: (vector_double4(0, 10, 20, 30),
                                               vector_double4(1, 11, 21, 31),
                                               vector_double4(2, 12, 22, 32),
                                               vector_double4(3, 13, 23, 33)))
        let data: [[Double]] = value.serialized()
        
        XCTAssertEqual(data[indexes.column0][subindexes.x], value.columns.0.x)
        XCTAssertEqual(data[indexes.column0][subindexes.y], value.columns.0.y)
        XCTAssertEqual(data[indexes.column0][subindexes.z], value.columns.0.z)
        XCTAssertEqual(data[indexes.column0][subindexes.w], value.columns.0.w)
        
        XCTAssertEqual(data[indexes.column1][subindexes.x], value.columns.1.x)
        XCTAssertEqual(data[indexes.column1][subindexes.y], value.columns.1.y)
        XCTAssertEqual(data[indexes.column1][subindexes.z], value.columns.1.z)
        XCTAssertEqual(data[indexes.column1][subindexes.w], value.columns.1.w)
        
        XCTAssertEqual(data[indexes.column2][subindexes.x], value.columns.2.x)
        XCTAssertEqual(data[indexes.column2][subindexes.y], value.columns.2.y)
        XCTAssertEqual(data[indexes.column2][subindexes.z], value.columns.2.z)
        XCTAssertEqual(data[indexes.column2][subindexes.w], value.columns.2.w)
        
        XCTAssertEqual(data[indexes.column3][subindexes.x], value.columns.3.x)
        XCTAssertEqual(data[indexes.column3][subindexes.y], value.columns.3.y)
        XCTAssertEqual(data[indexes.column3][subindexes.z], value.columns.3.z)
        XCTAssertEqual(data[indexes.column3][subindexes.w], value.columns.3.w)
    }
}
