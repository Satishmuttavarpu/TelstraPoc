//
//  TelstraPocUITests.swift
//  TelstraPocUITests
//
//  Created by Satish Muttavarapu on 07/02/20.
//  Copyright © 2020 Satish Muttavarapu. All rights reserved.
//

import XCTest

class TelstraPocUITests: XCTestCase {

    override func setUp() {
     
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

}
