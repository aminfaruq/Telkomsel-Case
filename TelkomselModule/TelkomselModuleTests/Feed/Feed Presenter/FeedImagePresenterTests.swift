//
//  FeedImagePresenterTests.swift
//  EssentialFeedTests
//
//  Created by Amin faruq on 26/09/22.
//

import XCTest
import TelkomselModule

class FeedImagePresenterTests: XCTestCase {
    
    func test_map_createsViewModel() {
        let image = uniqueImage()
        
        let viewModel = FeedImagePresenter.map(image)
        
        XCTAssertEqual(viewModel.productName, image.productName)
        XCTAssertEqual(viewModel.description, image.description)
        XCTAssertEqual(viewModel.rating, image.rating)
        XCTAssertEqual(viewModel.latestVersion, image.latestVersion)
        XCTAssertEqual(viewModel.publisher, image.publisher)
        XCTAssertEqual(viewModel.colorTheme, image.colorTheme)
    }
    
    func uniqueImage() -> FeedItem {
        return FeedItem(productName: "any", productLogo: anyURL(), description: "any", rating: 0.0, latestVersion: "any", publisher: "any", colorTheme: "any")
    }
}
