//
//  POCAppTests.swift
//  POCAppTests
//
//  Created by Ritesh on 08/11/20.
//  Copyright © 2020 Ritesh. All rights reserved.
//

import XCTest
@testable import POCApp

class POCAppTests: XCTestCase {
    var viewControllerUnderTest: HomeViewController!
    override func setUp() {
        super.setUp()
        self.viewControllerUnderTest = HomeViewController()
        self.viewControllerUnderTest.viewDidLoad()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testHasATableView() {
        XCTAssertNotNil(viewControllerUnderTest.tableView)
    }
    
    func testTableViewHasDelegate() {
        XCTAssertNotNil(viewControllerUnderTest.tableView.delegate)
    }
    
    func testTableViewConfromsToTableViewDelegateProtocol() {
        XCTAssertTrue(viewControllerUnderTest.conforms(to: UITableViewDelegate.self))
    }
    
    func testTableViewHasDataSource() {
        XCTAssertNotNil(viewControllerUnderTest.tableView.dataSource)
    }
}
