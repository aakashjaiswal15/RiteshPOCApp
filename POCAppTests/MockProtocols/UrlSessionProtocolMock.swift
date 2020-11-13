//
//  URLSessionProtocolMock.swift
//  POCAppTests
//
//  Copyright © 2020 Ritesh. All rights reserved.
//

import Foundation

protocol URLSessionProtocol { typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Void
    func dataTask(with request: NSURLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol
}

protocol URLSessionDataTaskProtocol { func resume() }
