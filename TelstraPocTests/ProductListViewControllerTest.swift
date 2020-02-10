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

    var vcTest : ProductListViewController!
    var vc = UINavigationController()
    
    override func setUp() {
        super.setUp()
        
        if let app = UIApplication.shared.delegate as? AppDelegate, let window = app.window {
            //            viewControllerUnderTest = window.rootViewController  as! ProductListViewController
            //            viewControllerUnderTest.loadView()
            vc = window.rootViewController as! UINavigationController
            vcTest = self.vc.viewControllers[0] as? ProductListViewController
            
        }
        
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testHasATableView() {
        XCTAssertNotNil(vcTest)
    }
    
    func testTableViewHasDelegate() {
        XCTAssertNotNil(vcTest.tableView.delegate)
    }
    
    func testTableViewConfromsToTableViewDelegateProtocol() {
        XCTAssertTrue(vcTest.conforms(to: UITableViewDelegate.self))
        // XCTAssertTrue(viewControllerUnderTest.responds(to: #selector(viewControllerUnderTest.tableView(_:didSelectRowAt:))))
    }
    
    func testTableViewHasDataSource() {
        XCTAssertNotNil(vcTest.tableView.dataSource)
    }
    
    func testTableViewConformsToTableViewDataSourceProtocol() {
        XCTAssertTrue(vcTest.conforms(to: UITableViewDataSource.self))
        XCTAssertTrue(vcTest.responds(to: #selector(vcTest.tableView(_:numberOfRowsInSection:))))
        XCTAssertTrue(vcTest.responds(to: #selector(vcTest.tableView(_:cellForRowAt:))))
    }
    
    func testTableViewHastitle()
    {
        let actualTitle = vcTest.navigationItem.title
        let expectedTitle = "About Canada"
        XCTAssertEqual(actualTitle, expectedTitle)
    }
}
