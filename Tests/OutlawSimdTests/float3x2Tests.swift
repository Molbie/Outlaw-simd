//
//  float3x2Tests.swift
//  OutlawSimd
//
//  Created by Brian Mullen on 12/17/16.
//  Copyright © 2016 Molbie LLC. All rights reserved.
//

import XCTest
import simd
import Outlaw
@testable import OutlawSimd


class float3x2Tests: XCTestCase {
    private typealias keys = simd_float3x2.keys
    private typealias subkeys = SIMD2<Float>.keys
    private typealias indexes = simd_float3x2.indexes
    private typealias subindexes = SIMD2<Float>.indexes
    
    func testExtractableValue() {
        let rawData: [String: [String: Float]] = [keys.column0: [subkeys.x: 0,
                                                                 subkeys.y: 10],
                                                  keys.column1: [subkeys.x: 1,
                                                                 subkeys.y: 11],
                                                  keys.column2: [subkeys.x: 2,
                                                                 subkeys.y: 12]]
        let data: [String: [String: [String: Float]]] = ["value": rawData]
        let value: float3x2 = try! data.value(for: "value")
        
        XCTAssertEqual(value[0].x, rawData[keys.column0]?[subkeys.x])
        XCTAssertEqual(value[0].y, rawData[keys.column0]?[subkeys.y])
        
        XCTAssertEqual(value[1].x, rawData[keys.column1]?[subkeys.x])
        XCTAssertEqual(value[1].y, rawData[keys.column1]?[subkeys.y])
        
        XCTAssertEqual(value[2].x, rawData[keys.column2]?[subkeys.x])
        XCTAssertEqual(value[2].y, rawData[keys.column2]?[subkeys.y])
    }
    
    func testIndexExtractableValue() {
        var rawData0 = [Float](repeating: 0, count: 2)
        rawData0[subindexes.x] = 0
        rawData0[subindexes.y] = 10
        var rawData1 = [Float](repeating: 0, count: 2)
        rawData1[subindexes.x] = 1
        rawData1[subindexes.y] = 11
        var rawData2 = [Float](repeating: 0, count: 2)
        rawData2[subindexes.x] = 2
        rawData2[subindexes.y] = 12
        
        var rawData = [[Float]](repeating: [0], count: 3)
        rawData[indexes.column0] = rawData0
        rawData[indexes.column1] = rawData1
        rawData[indexes.column2] = rawData2
        
        let data: [[[Float]]] = [rawData]
        let value: float3x2 = try! data.value(for: 0)
        
        XCTAssertEqual(value[0].x, rawData[indexes.column0][subindexes.x])
        XCTAssertEqual(value[0].y, rawData[indexes.column0][subindexes.y])
        
        XCTAssertEqual(value[1].x, rawData[indexes.column1][subindexes.x])
        XCTAssertEqual(value[1].y, rawData[indexes.column1][subindexes.y])
        
        XCTAssertEqual(value[2].x, rawData[indexes.column2][subindexes.x])
        XCTAssertEqual(value[2].y, rawData[indexes.column2][subindexes.y])
    }
    
    func testInvalidValue() {
        let rawData: String = "Hello, Outlaw!"
        let data: [String] = [rawData]
        
        let ex = self.expectation(description: "Invalid data")
        do {
            let _: float3x2 = try data.value(for: 0)
        }
        catch {
            if case OutlawError.typeMismatchWithIndex = error {
                ex.fulfill()
            }
        }
        self.waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testSerializable() {
        let value = float3x2([float2(0, 10),
                              float2(1, 11),
                              float2(2, 12)])
        let data = value.serialized()
        
        XCTAssertEqual(data[keys.column0]?[subkeys.x], value[0].x)
        XCTAssertEqual(data[keys.column0]?[subkeys.y], value[0].y)
        
        XCTAssertEqual(data[keys.column1]?[subkeys.x], value[1].x)
        XCTAssertEqual(data[keys.column1]?[subkeys.y], value[1].y)
        
        XCTAssertEqual(data[keys.column2]?[subkeys.x], value[2].x)
        XCTAssertEqual(data[keys.column2]?[subkeys.y], value[2].y)
    }
    
    func testIndexSerializable() {
        let value = float3x2([float2(0, 10),
                              float2(1, 11),
                              float2(2, 12)])
        let data = value.serializedIndexes()
        
        XCTAssertEqual(data[indexes.column0][subindexes.x], value[0].x)
        XCTAssertEqual(data[indexes.column0][subindexes.y], value[0].y)
        
        XCTAssertEqual(data[indexes.column1][subindexes.x], value[1].x)
        XCTAssertEqual(data[indexes.column1][subindexes.y], value[1].y)
        
        XCTAssertEqual(data[indexes.column2][subindexes.x], value[2].x)
        XCTAssertEqual(data[indexes.column2][subindexes.y], value[2].y)
    }
}
