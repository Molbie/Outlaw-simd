//
//  double3x4Tests.swift
//  OutlawSimd
//
//  Created by Brian Mullen on 12/17/16.
//  Copyright © 2016 Molbie LLC. All rights reserved.
//

import XCTest
import simd
import Outlaw
@testable import OutlawSimd


class double3x4Tests: XCTestCase {
    func testExtractableValue() {
        typealias keys = double3x4.ExtractableKeys
        typealias subkeys = double4.ExtractableKeys
        
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
                                                                  subkeys.w: 32]]
        let data: [String: [String: [String: Double]]] = ["value": rawData]
        let value: double3x4 = try! data.value(for: "value")
        
        XCTAssertEqual(value[0].x, rawData[keys.column0]?[subkeys.x])
        XCTAssertEqual(value[0].y, rawData[keys.column0]?[subkeys.y])
        XCTAssertEqual(value[0].z, rawData[keys.column0]?[subkeys.z])
        XCTAssertEqual(value[0].w, rawData[keys.column0]?[subkeys.w])
        
        XCTAssertEqual(value[1].x, rawData[keys.column1]?[subkeys.x])
        XCTAssertEqual(value[1].y, rawData[keys.column1]?[subkeys.y])
        XCTAssertEqual(value[1].z, rawData[keys.column1]?[subkeys.z])
        XCTAssertEqual(value[1].w, rawData[keys.column1]?[subkeys.w])
        
        XCTAssertEqual(value[2].x, rawData[keys.column2]?[subkeys.x])
        XCTAssertEqual(value[2].y, rawData[keys.column2]?[subkeys.y])
        XCTAssertEqual(value[2].z, rawData[keys.column2]?[subkeys.z])
        XCTAssertEqual(value[2].w, rawData[keys.column2]?[subkeys.w])
    }
    
    func testIndexExtractableValue() {
        let rawData: [[Double]] = [[0, 10, 20, 30],
                                   [1, 11, 21, 31],
                                   [2, 12, 22, 32]]
        let data: [[[Double]]] = [rawData]
        let value: double3x4 = try! data.value(for: 0)
        
        XCTAssertEqual(value[0].x, rawData[0][0])
        XCTAssertEqual(value[0].y, rawData[0][1])
        XCTAssertEqual(value[0].z, rawData[0][2])
        XCTAssertEqual(value[0].w, rawData[0][3])
        
        XCTAssertEqual(value[1].x, rawData[1][0])
        XCTAssertEqual(value[1].y, rawData[1][1])
        XCTAssertEqual(value[1].z, rawData[1][2])
        XCTAssertEqual(value[1].w, rawData[1][3])
        
        XCTAssertEqual(value[2].x, rawData[2][0])
        XCTAssertEqual(value[2].y, rawData[2][1])
        XCTAssertEqual(value[2].z, rawData[2][2])
        XCTAssertEqual(value[2].w, rawData[2][3])
    }
    
    func testInvalidValue() {
        let rawData: String = "Hello, Outlaw!"
        let data: [String] = [rawData]
        
        let ex = self.expectation(description: "Invalid data")
        do {
            let _: double3x4 = try data.value(for: 0)
        }
        catch {
            if case OutlawError.typeMismatchWithIndex = error {
                ex.fulfill()
            }
        }
        self.waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testSerializable() {
        typealias keys = double3x4.ExtractableKeys
        typealias subkeys = double4.ExtractableKeys
        
        let value = double3x4([double4(0, 10, 20, 30),
                               double4(1, 11, 21, 31),
                               double4(2, 12, 22, 32)])
        let data: [String: [String: Double]] = value.serialized()
        
        XCTAssertEqual(data[keys.column0]?[subkeys.x], value[0].x)
        XCTAssertEqual(data[keys.column0]?[subkeys.y], value[0].y)
        XCTAssertEqual(data[keys.column0]?[subkeys.z], value[0].z)
        XCTAssertEqual(data[keys.column0]?[subkeys.w], value[0].w)
        
        XCTAssertEqual(data[keys.column1]?[subkeys.x], value[1].x)
        XCTAssertEqual(data[keys.column1]?[subkeys.y], value[1].y)
        XCTAssertEqual(data[keys.column1]?[subkeys.z], value[1].z)
        XCTAssertEqual(data[keys.column1]?[subkeys.w], value[1].w)
        
        XCTAssertEqual(data[keys.column2]?[subkeys.x], value[2].x)
        XCTAssertEqual(data[keys.column2]?[subkeys.y], value[2].y)
        XCTAssertEqual(data[keys.column2]?[subkeys.z], value[2].z)
        XCTAssertEqual(data[keys.column2]?[subkeys.w], value[2].w)
    }
    
    func testIndexSerializable() {
        let value = double3x4([double4(0, 10, 20, 30),
                               double4(1, 11, 21, 31),
                               double4(2, 12, 22, 32)])
        let data: [[Double]] = value.serialized()
        
        XCTAssertEqual(data[0][0], value[0].x)
        XCTAssertEqual(data[0][1], value[0].y)
        XCTAssertEqual(data[0][2], value[0].z)
        XCTAssertEqual(data[0][3], value[0].w)
        
        XCTAssertEqual(data[1][0], value[1].x)
        XCTAssertEqual(data[1][1], value[1].y)
        XCTAssertEqual(data[1][2], value[1].z)
        XCTAssertEqual(data[1][3], value[1].w)
        
        XCTAssertEqual(data[2][0], value[2].x)
        XCTAssertEqual(data[2][1], value[2].y)
        XCTAssertEqual(data[2][2], value[2].z)
        XCTAssertEqual(data[2][3], value[2].w)
    }
}
