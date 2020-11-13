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
    
    func test_hasATableView() {
        XCTAssertNotNil(viewControllerUnderTest.tableView)
    }
    
    func test_tableViewHasDelegate() {
        XCTAssertNotNil(viewControllerUnderTest.tableView.delegate)
    }
    
    func test_tableViewConfromsToTableViewDelegateProtocol() {
        XCTAssertTrue(viewControllerUnderTest.conforms(to: UITableViewDelegate.self))
    }
    
    func test_tableViewHasDataSource() {
        XCTAssertNotNil(viewControllerUnderTest.tableView.dataSource)
    }
    
    func test_configureTableView() {
        viewControllerUnderTest.configureTableView()
        XCTAssertEqual(viewControllerUnderTest.tableView.estimatedRowHeight, 50.0)
        XCTAssertEqual(viewControllerUnderTest.tableView.rowHeight, UITableView.automaticDimension)
    }
    
    func test_setupConstraints() {
        viewControllerUnderTest.setupConstraints()
        XCTAssertFalse(viewControllerUnderTest.tableView.translatesAutoresizingMaskIntoConstraints)
    }
    
    func test_setUpCell() {
        let tableView = UITableView()
        let rowData = Row(title: "NewRowData", rowDescription: "FirstRow", imageURL: nil, image: UIImage())
        let homeData = Home(title: "NewData", rows: [rowData])
        self.viewControllerUnderTest.displayHomeData(data: homeData)
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: "homeRow")
        viewControllerUnderTest.tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: "homeRow")
        let cell = viewControllerUnderTest.tableView.dataSource?.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? HomeTableViewCell
        XCTAssertEqual(cell?.titleLabel.text, rowData.title)
        XCTAssertEqual(cell?.descriptionLabel.text, rowData.rowDescription)
        XCTAssertEqual(cell?.wikiImageView.image, rowData.image)
    }
    
}
