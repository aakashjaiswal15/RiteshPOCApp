//
//  NetworkCallTests.swift
//  POCAppTests
//
//  Created by Ritesh on 08/11/20.
//  Copyright © 2020 Ritesh. All rights reserved.
//

import XCTest
import Foundation

@testable import POCApp

class NetworkCallTests: XCTestCase {

    var httpClient: HttpClient!
    var viewControllerUnderTest: HomeViewController!
    let session = URLSessionMock()
    var sessionUnderTest: URLSession!
    override func setUp() {
        super.setUp()
        httpClient = HttpClient(session: session)
        sessionUnderTest = URLSession(configuration: .default)
        self.viewControllerUnderTest = HomeViewController()
        self.viewControllerUnderTest.viewDidLoad()
    }

    
    func test_get_resume_called() {
        let dataTask = MockURLSessionDataTask()
        session.nextDataTask = dataTask
        guard let url = URL(string: "https://mockurl") else {
            fatalError("URL can't be empty")
        }
        httpClient.get(url: url) { (success, response) in
                // Return data
            }
        XCTAssert(dataTask.resumeWasCalled)
    }
    
    func test_networkCallStatus() {
        let url =
            URL(string: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts")
        let promise = expectation(description: "Status code: 200")
        
        let dataTask = sessionUnderTest.dataTask(with: url!) { data, response, error in
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
                return
            } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if statusCode == 200 {
                    promise.fulfill()
                } else {
                    XCTFail("Status code: \(statusCode)")
                }
            }
        }
        dataTask.resume()
        wait(for: [promise], timeout: 5)
    }
    
    func test_fetchData() {
        let promise = expectation(description: "Data is not nil")
        viewControllerUnderTest.fetchDataDetails { (homeData, error) in
                guard homeData != nil else {
                    XCTFail("Unable to fetch data")
                    return
                }
                promise.fulfill()
            }
        wait(for: [promise], timeout: 5)
    }
    
    func test_fetchImage() {
        let promise = expectation(description: "Image fetched successfully ")
        let urlString = "http://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/American_Beaver.jpg/220px-American_Beaver.jpg"
        let url = URL(string: urlString)
        viewControllerUnderTest.fetchImageDetails(url: url!) {(image, error) in
            guard image != nil else {
                XCTFail("Unable to fetch image")
                return
            }
            promise.fulfill()
        }
        wait(for: [promise], timeout: 5)
    }
}
