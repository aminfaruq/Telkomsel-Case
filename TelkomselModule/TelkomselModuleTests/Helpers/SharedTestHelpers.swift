//
//  SharedTestHelpers.swift
//  TelkomselModuleTests
//
//  Created by Amin faruq on 08/09/22.
//

import Foundation

func anyNSError() -> NSError {
    return NSError(domain: "any error", code: 0)
}

func anyURL() -> URL {
    return URL(string: "http://any-url.com")!
}

func anyData() -> Data {
    return Data("any data".utf8)
}

func anyURLRequest() -> URLRequest {
    return URLRequest(url: anyURL())
}

func makeItemsJSON(_ items: [[String: Any]]) -> Data {
    let json = ["data": items]
    return try! JSONSerialization.data(withJSONObject: json)
}

extension HTTPURLResponse {
    convenience init(statusCode: Int) {
        self.init(url: anyURL(), statusCode: statusCode, httpVersion: nil, headerFields: nil)!
    }
}
