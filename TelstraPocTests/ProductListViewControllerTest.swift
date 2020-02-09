//
//  ProductListViewControllerTest.swift
//  TelstraPocTests
//
//  Created by Satish Muttavarapu on 09/02/20.
//  Copyright © 2020 Satish Muttavarapu. All rights reserved.
//

import XCTest
@testable import TelstraPoc

class ProductListViewControllerTest: XCTestCase {

    var viewControllerUnderTest : ProductListViewController!
    var vc = UINavigationController()
    
    override func setUp() {
        super.setUp()
        
        if let app = UIApplication.shared.delegate as? AppDelegate, let window = app.window {
            //            viewControllerUnderTest = window.rootViewController  as! ProductListViewController
            //            viewControllerUnderTest.loadView()
            vc = window.rootViewController as! UINavigationController
            viewControllerUnderTest = self.vc.viewControllers[0] as? ProductListViewController
            
        }
        
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testHasATableView() {
        XCTAssertNotNil(viewControllerUnderTest)
    }
    
    func testTableViewHasDelegate() {
        XCTAssertNotNil(viewControllerUnderTest.tableView.delegate)
    }
    
    func testTableViewConfromsToTableViewDelegateProtocol() {
        XCTAssertTrue(viewControllerUnderTest.conforms(to: UITableViewDelegate.self))
        // XCTAssertTrue(viewControllerUnderTest.responds(to: #selector(viewControllerUnderTest.tableView(_:didSelectRowAt:))))
    }
    
    func testTableViewHasDataSource() {
        XCTAssertNotNil(viewControllerUnderTest.tableView.dataSource)
    }
    
    func testTableViewConformsToTableViewDataSourceProtocol() {
        XCTAssertTrue(viewControllerUnderTest.conforms(to: UITableViewDataSource.self))
        XCTAssertTrue(viewControllerUnderTest.responds(to: #selector(viewControllerUnderTest.numberOfSections(in:))))
        XCTAssertTrue(viewControllerUnderTest.responds(to: #selector(viewControllerUnderTest.tableView(_:numberOfRowsInSection:))))
        XCTAssertTrue(viewControllerUnderTest.responds(to: #selector(viewControllerUnderTest.tableView(_:cellForRowAt:))))
    }
    
    func testTableViewHastitle()
    {
        let actualTitle = viewControllerUnderTest.navigationItem.title
        let expectedTitle = "About Canada"
        XCTAssertEqual(actualTitle, expectedTitle)
    }
}
