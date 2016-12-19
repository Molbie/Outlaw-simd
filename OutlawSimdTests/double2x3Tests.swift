//
//  double2x3Tests.swift
//  OutlawSimd
//
//  Created by Brian Mullen on 12/17/16.
//  Copyright © 2016 Molbie LLC. All rights reserved.
//

import XCTest
import simd
import Outlaw
@testable import OutlawSimd


class double2x3Tests: XCTestCase {
    fileprivate typealias keys = double2x3.ExtractableKeys
    fileprivate typealias subkeys = double3.ExtractableKeys
    fileprivate typealias indexes = double2x3.ExtractableIndexes
    fileprivate typealias subindexes = double3.ExtractableIndexes
    
    func testExtractableValue() {
        let rawData: [String: [String: Double]] = [keys.column0: [subkeys.x: 0,
                                                                  subkeys.y: 10,
                                                                  subkeys.z: 20],
                                                   keys.column1: [subkeys.x: 1,
                                                                  subkeys.y: 11,
                                                                  subkeys.z: 21]]
        let data: [String: [String: [String: Double]]] = ["value": rawData]
        let value: double2x3 = try! data.value(for: "value")
        
        XCTAssertEqual(value[0].x, rawData[keys.column0]?[subkeys.x])
        XCTAssertEqual(value[0].y, rawData[keys.column0]?[subkeys.y])
        XCTAssertEqual(value[0].z, rawData[keys.column0]?[subkeys.z])
        
        XCTAssertEqual(value[1].x, rawData[keys.column1]?[subkeys.x])
        XCTAssertEqual(value[1].y, rawData[keys.column1]?[subkeys.y])
        XCTAssertEqual(value[1].z, rawData[keys.column1]?[subkeys.z])
    }
    
    func testIndexExtractableValue() {
        var rawData0 = [Double](repeating: 0, count: 3)
        rawData0[subindexes.x] = 0
        rawData0[subindexes.y] = 10
        rawData0[subindexes.z] = 20
        var rawData1 = [Double](repeating: 0, count: 3)
        rawData1[subindexes.x] = 1
        rawData1[subindexes.y] = 11
        rawData1[subindexes.z] = 21
        
        var rawData = [[Double]](repeating: [0], count: 2)
        rawData[indexes.column0] = rawData0
        rawData[indexes.column1] = rawData1
        
        let data: [[[Double]]] = [rawData]
        let value: double2x3 = try! data.value(for: 0)
        
        XCTAssertEqual(value[0].x, rawData[indexes.column0][subindexes.x])
        XCTAssertEqual(value[0].y, rawData[indexes.column0][subindexes.y])
        XCTAssertEqual(value[0].z, rawData[indexes.column0][subindexes.z])
        
        XCTAssertEqual(value[1].x, rawData[indexes.column1][subindexes.x])
        XCTAssertEqual(value[1].y, rawData[indexes.column1][subindexes.y])
        XCTAssertEqual(value[1].z, rawData[indexes.column1][subindexes.z])
    }
    
    func testInvalidValue() {
        let rawData: String = "Hello, Outlaw!"
        let data: [String] = [rawData]
        
        let ex = self.expectation(description: "Invalid data")
        do {
            let _: double2x3 = try data.value(for: 0)
        }
        catch {
            if case OutlawError.typeMismatchWithIndex = error {
                ex.fulfill()
            }
        }
        self.waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testSerializable() {
        let value = double2x3([double3(0, 10, 20),
                               double3(1, 11, 21)])
        let data: [String: [String: Double]] = value.serialized()
        
        XCTAssertEqual(data[keys.column0]?[subkeys.x], value[0].x)
        XCTAssertEqual(data[keys.column0]?[subkeys.y], value[0].y)
        XCTAssertEqual(data[keys.column0]?[subkeys.z], value[0].z)
        
        XCTAssertEqual(data[keys.column1]?[subkeys.x], value[1].x)
        XCTAssertEqual(data[keys.column1]?[subkeys.y], value[1].y)
        XCTAssertEqual(data[keys.column1]?[subkeys.z], value[1].z)
    }
    
    func testIndexSerializable() {
        let value = double2x3([double3(0, 10, 20),
                               double3(1, 11, 21)])
        let data: [[Double]] = value.serialized()
        
        XCTAssertEqual(data[indexes.column0][subindexes.x], value[0].x)
        XCTAssertEqual(data[indexes.column0][subindexes.y], value[0].y)
        XCTAssertEqual(data[indexes.column0][subindexes.z], value[0].z)
        
        XCTAssertEqual(data[indexes.column1][subindexes.x], value[1].x)
        XCTAssertEqual(data[indexes.column1][subindexes.y], value[1].y)
        XCTAssertEqual(data[indexes.column1][subindexes.z], value[1].z)
    }
}
