//
//  SoftLightTests.swift
//  SoftLightTests
//
//  Created by Ben Groß on 11/12/21.
//

import XCTest
@testable import SoftLight

class SoftLightTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testMessageBuildZeros() {
        let message = PackedMessage(hue: 0, sat: 0, val: 0, white: 0)
        
        XCTAssertEqual(message.generateStringMessage(), "#00000000")
    }
    
    func testMessageBuildMax() {
        let message = PackedMessage(hue: 255, sat: 255, val: 255, white: 255)
        
        XCTAssertEqual(message.generateStringMessage(), "#FFFFFFFF")
    }
    

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
