//
//  float4x3Tests.swift
//  OutlawSimd
//
//  Created by Brian Mullen on 12/17/16.
//  Copyright © 2016 Molbie LLC. All rights reserved.
//

import XCTest
import simd
import Outlaw
@testable import OutlawSimd


class float4x3Tests: XCTestCase {
    func testExtractableValue() {
        typealias keys = float4x3.ExtractableKeys
        typealias subkeys = float3.ExtractableKeys
        
        let rawData: [String: [String: Float]] = [keys.column0: [subkeys.x: 0,
                                                                 subkeys.y: 10,
                                                                 subkeys.z: 20],
                                                  keys.column1: [subkeys.x: 1,
                                                                 subkeys.y: 11,
                                                                 subkeys.z: 21],
                                                  keys.column2: [subkeys.x: 2,
                                                                 subkeys.y: 12,
                                                                 subkeys.z: 22],
                                                  keys.column3: [subkeys.x: 3,
                                                                 subkeys.y: 13,
                                                                 subkeys.z: 23]]
        let data: [String: [String: [String: Float]]] = ["value": rawData]
        let value: float4x3 = try! data.value(for: "value")
        
        XCTAssertEqual(value[0].x, rawData[keys.column0]?[subkeys.x])
        XCTAssertEqual(value[0].y, rawData[keys.column0]?[subkeys.y])
        XCTAssertEqual(value[0].z, rawData[keys.column0]?[subkeys.z])
        
        XCTAssertEqual(value[1].x, rawData[keys.column1]?[subkeys.x])
        XCTAssertEqual(value[1].y, rawData[keys.column1]?[subkeys.y])
        XCTAssertEqual(value[1].z, rawData[keys.column1]?[subkeys.z])
        
        XCTAssertEqual(value[2].x, rawData[keys.column2]?[subkeys.x])
        XCTAssertEqual(value[2].y, rawData[keys.column2]?[subkeys.y])
        XCTAssertEqual(value[2].z, rawData[keys.column2]?[subkeys.z])
        
        XCTAssertEqual(value[3].x, rawData[keys.column3]?[subkeys.x])
        XCTAssertEqual(value[3].y, rawData[keys.column3]?[subkeys.y])
        XCTAssertEqual(value[3].z, rawData[keys.column3]?[subkeys.z])
    }
    
    func testIndexExtractableValue() {
        let rawData: [[Float]] = [[0, 10, 20],
                                  [1, 11, 21],
                                  [2, 12, 22],
                                  [3, 13, 23]]
        let data: [[[Float]]] = [rawData]
        let value: float4x3 = try! data.value(for: 0)
        
        XCTAssertEqual(value[0].x, rawData[0][0])
        XCTAssertEqual(value[0].y, rawData[0][1])
        XCTAssertEqual(value[0].z, rawData[0][2])
        
        XCTAssertEqual(value[1].x, rawData[1][0])
        XCTAssertEqual(value[1].y, rawData[1][1])
        XCTAssertEqual(value[1].z, rawData[1][2])
        
        XCTAssertEqual(value[2].x, rawData[2][0])
        XCTAssertEqual(value[2].y, rawData[2][1])
        XCTAssertEqual(value[2].z, rawData[2][2])
        
        XCTAssertEqual(value[3].x, rawData[3][0])
        XCTAssertEqual(value[3].y, rawData[3][1])
        XCTAssertEqual(value[3].z, rawData[3][2])
    }
    
    func testInvalidValue() {
        let rawData: String = "Hello, Outlaw!"
        let data: [String] = [rawData]
        
        let ex = self.expectation(description: "Invalid data")
        do {
            let _: float4x3 = try data.value(for: 0)
        }
        catch {
            if case OutlawError.typeMismatchWithIndex = error {
                ex.fulfill()
            }
        }
        self.waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testSerializable() {
        typealias keys = float4x3.ExtractableKeys
        typealias subkeys = float3.ExtractableKeys
        
        let value = float4x3([float3(0, 10, 20),
                              float3(1, 11, 21),
                              float3(2, 12, 22),
                              float3(3, 13, 23)])
        let data: [String: [String: Float]] = value.serialized()
        
        XCTAssertEqual(data[keys.column0]?[subkeys.x], value[0].x)
        XCTAssertEqual(data[keys.column0]?[subkeys.y], value[0].y)
        XCTAssertEqual(data[keys.column0]?[subkeys.z], value[0].z)
        
        XCTAssertEqual(data[keys.column1]?[subkeys.x], value[1].x)
        XCTAssertEqual(data[keys.column1]?[subkeys.y], value[1].y)
        XCTAssertEqual(data[keys.column1]?[subkeys.z], value[1].z)
        
        XCTAssertEqual(data[keys.column2]?[subkeys.x], value[2].x)
        XCTAssertEqual(data[keys.column2]?[subkeys.y], value[2].y)
        XCTAssertEqual(data[keys.column2]?[subkeys.z], value[2].z)
        
        XCTAssertEqual(data[keys.column3]?[subkeys.x], value[3].x)
        XCTAssertEqual(data[keys.column3]?[subkeys.y], value[3].y)
        XCTAssertEqual(data[keys.column3]?[subkeys.z], value[3].z)
    }
    
    func testIndexSerializable() {
        let value = float4x3([float3(0, 10, 20),
                              float3(1, 11, 21),
                              float3(2, 12, 22),
                              float3(3, 13, 23)])
        let data: [[Float]] = value.serialized()
        
        XCTAssertEqual(data[0][0], value[0].x)
        XCTAssertEqual(data[0][1], value[0].y)
        XCTAssertEqual(data[0][2], value[0].z)
        
        XCTAssertEqual(data[1][0], value[1].x)
        XCTAssertEqual(data[1][1], value[1].y)
        XCTAssertEqual(data[1][2], value[1].z)
        
        XCTAssertEqual(data[2][0], value[2].x)
        XCTAssertEqual(data[2][1], value[2].y)
        XCTAssertEqual(data[2][2], value[2].z)
        
        XCTAssertEqual(data[3][0], value[3].x)
        XCTAssertEqual(data[3][1], value[3].y)
        XCTAssertEqual(data[3][2], value[3].z)
    }
}
