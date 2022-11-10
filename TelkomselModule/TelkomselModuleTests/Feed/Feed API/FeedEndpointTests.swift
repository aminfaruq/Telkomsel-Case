//
//  FeedEndpointTests.swift
//  TelkomselModuleTests
//
//  Created by Amin faruq on 10/11/22.
//

import XCTest
import TelkomselModule

class FeedEndpointTests: XCTestCase {
    
    func test_feedItems_endpointURL() {
        let baseURL = URL(string: "http://base-url.com")!
        
        let received = FeedEndpoint.post.url(baseURL: baseURL)
        let expected = URL(string: "http://base-url.com/telkom/v2/products")!
        
        XCTAssertEqual(received, expected)
    }
}
