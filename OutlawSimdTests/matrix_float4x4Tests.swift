//
//  matrix_float4x4Tests.swift
//  OutlawSimd
//
//  Created by Brian Mullen on 12/17/16.
//  Copyright © 2016 Molbie LLC. All rights reserved.
//

import XCTest
import simd
import Outlaw
@testable import OutlawSimd


class matrix_float4x4Tests: XCTestCase {
    func testExtractableValue() {
        let rawData: [String: [String: Float]] = ["c0": ["x": 0, "y": 10, "z": 20, "w": 30],
                                                  "c1": ["x": 1, "y": 11, "z": 21, "w": 31],
                                                  "c2": ["x": 2, "y": 12, "z": 22, "w": 32],
                                                  "c3": ["x": 3, "y": 13, "z": 23, "w": 33]]
        let data: [String: [String: [String: Float]]] = ["value": rawData]
        let value: matrix_float4x4 = try! data.value(for: "value")
        
        XCTAssertEqual(value.columns.0.x, rawData["c0"]?["x"])
        XCTAssertEqual(value.columns.0.y, rawData["c0"]?["y"])
        XCTAssertEqual(value.columns.0.z, rawData["c0"]?["z"])
        XCTAssertEqual(value.columns.0.w, rawData["c0"]?["w"])
        
        XCTAssertEqual(value.columns.1.x, rawData["c1"]?["x"])
        XCTAssertEqual(value.columns.1.y, rawData["c1"]?["y"])
        XCTAssertEqual(value.columns.1.z, rawData["c1"]?["z"])
        XCTAssertEqual(value.columns.1.w, rawData["c1"]?["w"])
        
        XCTAssertEqual(value.columns.2.x, rawData["c2"]?["x"])
        XCTAssertEqual(value.columns.2.y, rawData["c2"]?["y"])
        XCTAssertEqual(value.columns.2.z, rawData["c2"]?["z"])
        XCTAssertEqual(value.columns.2.w, rawData["c2"]?["w"])
        
        XCTAssertEqual(value.columns.3.x, rawData["c3"]?["x"])
        XCTAssertEqual(value.columns.3.y, rawData["c3"]?["y"])
        XCTAssertEqual(value.columns.3.z, rawData["c3"]?["z"])
        XCTAssertEqual(value.columns.3.w, rawData["c3"]?["w"])
    }
    
    func testIndexExtractableValue() {
        let rawData: [[Float]] = [[0, 10, 20, 30],
                                  [1, 11, 21, 31],
                                  [2, 12, 22, 32],
                                  [3, 13, 23, 33]]
        let data: [[[Float]]] = [rawData]
        let value: matrix_float4x4 = try! data.value(for: 0)
        
        XCTAssertEqual(value.columns.0.x, rawData[0][0])
        XCTAssertEqual(value.columns.0.y, rawData[0][1])
        XCTAssertEqual(value.columns.0.z, rawData[0][2])
        XCTAssertEqual(value.columns.0.w, rawData[0][3])
        
        XCTAssertEqual(value.columns.1.x, rawData[1][0])
        XCTAssertEqual(value.columns.1.y, rawData[1][1])
        XCTAssertEqual(value.columns.1.z, rawData[1][2])
        XCTAssertEqual(value.columns.1.w, rawData[1][3])
        
        XCTAssertEqual(value.columns.2.x, rawData[2][0])
        XCTAssertEqual(value.columns.2.y, rawData[2][1])
        XCTAssertEqual(value.columns.2.z, rawData[2][2])
        XCTAssertEqual(value.columns.2.w, rawData[2][3])
        
        XCTAssertEqual(value.columns.3.x, rawData[3][0])
        XCTAssertEqual(value.columns.3.y, rawData[3][1])
        XCTAssertEqual(value.columns.3.z, rawData[3][2])
        XCTAssertEqual(value.columns.3.w, rawData[3][3])
    }
    
    func testInvalidValue() {
        let rawData: String = "Hello, Outlaw!"
        let data: [String] = [rawData]
        
        let ex = self.expectation(description: "Invalid data")
        do {
            let _: matrix_float4x4 = try data.value(for: 0)
        }
        catch {
            if case OutlawError.typeMismatchWithIndex = error {
                ex.fulfill()
            }
        }
        self.waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testSerializable() {
        let value = matrix_float4x4(columns: (vector_float4(0, 10, 20, 30),
                                              vector_float4(1, 11, 21, 31),
                                              vector_float4(2, 12, 22, 32),
                                              vector_float4(3, 13, 23, 33)))
        let data: [String: [String: Float]] = value.serialized()
        
        XCTAssertEqual(data["c0"]?["x"], value.columns.0.x)
        XCTAssertEqual(data["c0"]?["y"], value.columns.0.y)
        XCTAssertEqual(data["c0"]?["z"], value.columns.0.z)
        XCTAssertEqual(data["c0"]?["w"], value.columns.0.w)
        
        XCTAssertEqual(data["c1"]?["x"], value.columns.1.x)
        XCTAssertEqual(data["c1"]?["y"], value.columns.1.y)
        XCTAssertEqual(data["c1"]?["z"], value.columns.1.z)
        XCTAssertEqual(data["c1"]?["w"], value.columns.1.w)
        
        XCTAssertEqual(data["c2"]?["x"], value.columns.2.x)
        XCTAssertEqual(data["c2"]?["y"], value.columns.2.y)
        XCTAssertEqual(data["c2"]?["z"], value.columns.2.z)
        XCTAssertEqual(data["c2"]?["w"], value.columns.2.w)
        
        XCTAssertEqual(data["c3"]?["x"], value.columns.3.x)
        XCTAssertEqual(data["c3"]?["y"], value.columns.3.y)
        XCTAssertEqual(data["c3"]?["z"], value.columns.3.z)
        XCTAssertEqual(data["c3"]?["w"], value.columns.3.w)
    }
    
    func testIndexSerializable() {
        let value = matrix_float4x4(columns: (vector_float4(0, 10, 20, 30),
                                              vector_float4(1, 11, 21, 31),
                                              vector_float4(2, 12, 22, 32),
                                              vector_float4(3, 13, 23, 33)))
        let data: [[Float]] = value.serialized()
        
        XCTAssertEqual(data[0][0], value.columns.0.x)
        XCTAssertEqual(data[0][1], value.columns.0.y)
        XCTAssertEqual(data[0][2], value.columns.0.z)
        XCTAssertEqual(data[0][3], value.columns.0.w)
        
        XCTAssertEqual(data[1][0], value.columns.1.x)
        XCTAssertEqual(data[1][1], value.columns.1.y)
        XCTAssertEqual(data[1][2], value.columns.1.z)
        XCTAssertEqual(data[1][3], value.columns.1.w)
        
        XCTAssertEqual(data[2][0], value.columns.2.x)
        XCTAssertEqual(data[2][1], value.columns.2.y)
        XCTAssertEqual(data[2][2], value.columns.2.z)
        XCTAssertEqual(data[2][3], value.columns.2.w)
        
        XCTAssertEqual(data[3][0], value.columns.3.x)
        XCTAssertEqual(data[3][1], value.columns.3.y)
        XCTAssertEqual(data[3][2], value.columns.3.z)
        XCTAssertEqual(data[3][3], value.columns.3.w)
    }
}
