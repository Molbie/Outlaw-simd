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
    fileprivate typealias keys = float4x3.ExtractableKeys
    fileprivate typealias subkeys = float3.ExtractableKeys
    fileprivate typealias indexes = float4x3.ExtractableIndexes
    fileprivate typealias subindexes = float3.ExtractableIndexes
    
    func testExtractableValue() {
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
        var rawData0 = [Float](repeating: 0, count: 3)
        rawData0[subindexes.x] = 0
        rawData0[subindexes.y] = 10
        rawData0[subindexes.z] = 20
        var rawData1 = [Float](repeating: 0, count: 3)
        rawData1[subindexes.x] = 1
        rawData1[subindexes.y] = 11
        rawData1[subindexes.z] = 21
        var rawData2 = [Float](repeating: 0, count: 3)
        rawData2[subindexes.x] = 2
        rawData2[subindexes.y] = 12
        rawData2[subindexes.z] = 22
        var rawData3 = [Float](repeating: 0, count: 3)
        rawData3[subindexes.x] = 3
        rawData3[subindexes.y] = 13
        rawData3[subindexes.z] = 23
        
        var rawData = [[Float]](repeating: [0], count: 4)
        rawData[indexes.column0] = rawData0
        rawData[indexes.column1] = rawData1
        rawData[indexes.column2] = rawData2
        rawData[indexes.column3] = rawData3
        
        let data: [[[Float]]] = [rawData]
        let value: float4x3 = try! data.value(for: 0)
        
        XCTAssertEqual(value[0].x, rawData[indexes.column0][subindexes.x])
        XCTAssertEqual(value[0].y, rawData[indexes.column0][subindexes.y])
        XCTAssertEqual(value[0].z, rawData[indexes.column0][subindexes.z])
        
        XCTAssertEqual(value[1].x, rawData[indexes.column1][subindexes.x])
        XCTAssertEqual(value[1].y, rawData[indexes.column1][subindexes.y])
        XCTAssertEqual(value[1].z, rawData[indexes.column1][subindexes.z])
        
        XCTAssertEqual(value[2].x, rawData[indexes.column2][subindexes.x])
        XCTAssertEqual(value[2].y, rawData[indexes.column2][subindexes.y])
        XCTAssertEqual(value[2].z, rawData[indexes.column2][subindexes.z])
        
        XCTAssertEqual(value[3].x, rawData[indexes.column3][subindexes.x])
        XCTAssertEqual(value[3].y, rawData[indexes.column3][subindexes.y])
        XCTAssertEqual(value[3].z, rawData[indexes.column3][subindexes.z])
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
        
        XCTAssertEqual(data[indexes.column0][subindexes.x], value[0].x)
        XCTAssertEqual(data[indexes.column0][subindexes.y], value[0].y)
        XCTAssertEqual(data[indexes.column0][subindexes.z], value[0].z)
        
        XCTAssertEqual(data[indexes.column1][subindexes.x], value[1].x)
        XCTAssertEqual(data[indexes.column1][subindexes.y], value[1].y)
        XCTAssertEqual(data[indexes.column1][subindexes.z], value[1].z)
        
        XCTAssertEqual(data[indexes.column2][subindexes.x], value[2].x)
        XCTAssertEqual(data[indexes.column2][subindexes.y], value[2].y)
        XCTAssertEqual(data[indexes.column2][subindexes.z], value[2].z)
        
        XCTAssertEqual(data[indexes.column3][subindexes.x], value[3].x)
        XCTAssertEqual(data[indexes.column3][subindexes.y], value[3].y)
        XCTAssertEqual(data[indexes.column3][subindexes.z], value[3].z)
    }
}
