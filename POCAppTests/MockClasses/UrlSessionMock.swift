//
//  UrlSessionMock.swift
//  POCAppTests
//
//  Copyright © 2020 Ritesh. All rights reserved.
//

import Foundation

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
