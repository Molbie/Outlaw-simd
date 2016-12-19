//
//  float2x4Tests.swift
//  OutlawSimd
//
//  Created by Brian Mullen on 12/17/16.
//  Copyright © 2016 Molbie LLC. All rights reserved.
//

import XCTest
import simd
import Outlaw
@testable import OutlawSimd


class float2x4Tests: XCTestCase {
    func testExtractableValue() {
        typealias keys = float2x4.ExtractableKeys
        typealias subkeys = float4.ExtractableKeys
        
        let rawData: [String: [String: Float]] = [keys.column0: [subkeys.x: 0,
                                                                 subkeys.y: 10,
                                                                 subkeys.z: 20,
                                                                 subkeys.w: 30],
                                                  keys.column1: [subkeys.x: 1,
                                                                 subkeys.y: 11,
                                                                 subkeys.z: 21,
                                                                 subkeys.w: 31]]
        let data: [String: [String: [String: Float]]] = ["value": rawData]
        let value: float2x4 = try! data.value(for: "value")
        
        XCTAssertEqual(value[0].x, rawData[keys.column0]?[subkeys.x])
        XCTAssertEqual(value[0].y, rawData[keys.column0]?[subkeys.y])
        XCTAssertEqual(value[0].z, rawData[keys.column0]?[subkeys.z])
        XCTAssertEqual(value[0].w, rawData[keys.column0]?[subkeys.w])
        
        XCTAssertEqual(value[1].x, rawData[keys.column1]?[subkeys.x])
        XCTAssertEqual(value[1].y, rawData[keys.column1]?[subkeys.y])
        XCTAssertEqual(value[1].z, rawData[keys.column1]?[subkeys.z])
        XCTAssertEqual(value[1].w, rawData[keys.column1]?[subkeys.w])
    }
    
    func testIndexExtractableValue() {
        let rawData: [[Float]] = [[0, 10, 20, 30],
                                  [1, 11, 21, 31]]
        let data: [[[Float]]] = [rawData]
        let value: float2x4 = try! data.value(for: 0)
        
        XCTAssertEqual(value[0].x, rawData[0][0])
        XCTAssertEqual(value[0].y, rawData[0][1])
        XCTAssertEqual(value[0].z, rawData[0][2])
        XCTAssertEqual(value[0].w, rawData[0][3])
        
        XCTAssertEqual(value[1].x, rawData[1][0])
        XCTAssertEqual(value[1].y, rawData[1][1])
        XCTAssertEqual(value[1].z, rawData[1][2])
        XCTAssertEqual(value[1].w, rawData[1][3])
    }
    
    func testInvalidValue() {
        let rawData: String = "Hello, Outlaw!"
        let data: [String] = [rawData]
        
        let ex = self.expectation(description: "Invalid data")
        do {
            let _: float2x4 = try data.value(for: 0)
        }
        catch {
            if case OutlawError.typeMismatchWithIndex = error {
                ex.fulfill()
            }
        }
        self.waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testSerializable() {
        typealias keys = float2x4.ExtractableKeys
        typealias subkeys = float4.ExtractableKeys
        
        let value = float2x4([float4(0, 10, 20, 30),
                              float4(1, 11, 21, 31)])
        let data: [String: [String: Float]] = value.serialized()
        
        XCTAssertEqual(data[keys.column0]?[subkeys.x], value[0].x)
        XCTAssertEqual(data[keys.column0]?[subkeys.y], value[0].y)
        XCTAssertEqual(data[keys.column0]?[subkeys.z], value[0].z)
        XCTAssertEqual(data[keys.column0]?[subkeys.w], value[0].w)
        
        XCTAssertEqual(data[keys.column1]?[subkeys.x], value[1].x)
        XCTAssertEqual(data[keys.column1]?[subkeys.y], value[1].y)
        XCTAssertEqual(data[keys.column1]?[subkeys.z], value[1].z)
        XCTAssertEqual(data[keys.column1]?[subkeys.w], value[1].w)
    }
    
    func testIndexSerializable() {
        let value = float2x4([float4(0, 10, 20, 30),
                              float4(1, 11, 21, 31)])
        let data: [[Float]] = value.serialized()
        
        XCTAssertEqual(data[0][0], value[0].x)
        XCTAssertEqual(data[0][1], value[0].y)
        XCTAssertEqual(data[0][2], value[0].z)
        XCTAssertEqual(data[0][3], value[0].w)
        
        XCTAssertEqual(data[1][0], value[1].x)
        XCTAssertEqual(data[1][1], value[1].y)
        XCTAssertEqual(data[1][2], value[1].z)
        XCTAssertEqual(data[1][3], value[1].w)
    }
}
