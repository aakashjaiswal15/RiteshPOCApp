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
    let session = URLSessionMock()
    override func setUp() {
        super.setUp()
        httpClient = HttpClient(session: session)
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
}

class URLSessionMock: URLSessionProtocol {
    var nextDataTask = MockURLSessionDataTask()
    private (set) var lastURL: URL?
    func dataTask(with request: NSURLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
        lastURL = request.url
        return nextDataTask
    }
}

class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    private (set) var resumeWasCalled = false
    func resume() {
        resumeWasCalled = true
    }
}

class HttpClient {
    typealias completeClosure = ( _ data: Data?, _ error: Error?)->Void
    private let session: URLSessionProtocol
    init(session: URLSessionProtocol) {
        self.session = session
    }
    func get( url: URL, callback: @escaping completeClosure ) {
        let request = NSMutableURLRequest(url: url)
        let task = session.dataTask(with: request as NSURLRequest) { (data, response, error) in
            callback(data, error)
        }
        task.resume()
    }
}

protocol URLSessionProtocol { typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Void
    func dataTask(with request: NSURLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol
}

protocol URLSessionDataTaskProtocol { func resume() }
