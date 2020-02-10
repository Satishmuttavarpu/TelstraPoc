//
//  TelstraPocTests.swift
//  TelstraPocTests
//
//  Created by Satish Muttavarapu on 07/02/20.
//  Copyright © 2020 Satish Muttavarapu. All rights reserved.
//

import XCTest
@testable import TelstraPoc

class TelstraPocTests: XCTestCase {

    var nm = NetworkManager()
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        let expectation = XCTestExpectation.init(description: "Your expectation")
        // This is an example of a performance test case.
        nm.getNewFacts(page: 1) {  productList , error in
            if error != nil{
                XCTFail("Fail")
            }
            // The request is finished, so our expectation
            expectation.fulfill()
            
        }
        // We ask the unit test to wait our expectation to finish.
        self.waitForExpectations(timeout: 20)
        
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
