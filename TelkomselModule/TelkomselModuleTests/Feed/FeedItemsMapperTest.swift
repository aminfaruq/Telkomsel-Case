//
//  FeedItemsMapperTest.swift
//  EssentialFeedTests
//
//  Created by Amin faruq on 06/10/22.
//

import XCTest
import TelkomselModule

class FeedItemsMapperTest: XCTestCase {
    
    func test_map_throwsErrorOnNon2xxHTTPResponse() throws {
        let json = makeItemsJSON([])
        let samples = [199, 150, 300, 400, 500]
        
        try samples.forEach { code in
            XCTAssertThrowsError(
                try FeedItemsMapper.map(json, from: HTTPURLResponse(statusCode: code))
            )
        }
    }
    
    func test_map_throwsErrorOn2xxHTTPResponseWithInvalidJSON() throws {
        let invalidJSON = Data("invalid json".utf8)
        let samples = [200, 201, 250, 280, 299]
        
        try samples.forEach { code in
            XCTAssertThrowsError(
                try FeedItemsMapper.map(invalidJSON, from: HTTPURLResponse(statusCode: code))
            )
        }
    }
    
    func test_map_deliversNoItemsOn2xxHTTPResponseWithEmptyJSONList() throws {
        let emptyListJSON = makeItemsJSON([])
        let samples = [200, 201, 250, 280, 299]
        
        try samples.forEach { code in
            let result = try FeedItemsMapper.map(emptyListJSON, from: HTTPURLResponse(statusCode: code))
            
            XCTAssertEqual(result, [])
        }
    }
    
    func test_map_deliversItemsOn200HTTPResponseWithJSONItems() throws {
        
        let item1 = makeItem(productName: "myIndiHome",
            productLogo: URL(string: "https://i.ibb.co/1sCp7MV/myindihome.png")!,
            description: "Aplikasi myIndiHome memberi Anda kemudahan dan kenyamanan untuk mengelola layanan IndiHome Anda tanpa harus keluar rumah, ",
            rating: 3.1,
            latestVersion: "4.2.0",
            publisher: "PT. Telkom Indonesia, Tbk.",
            colorTheme: "B25068")
        
        
        let item2 = makeItem(productName: "UseeTV GO",
            productLogo: URL(string: "https://i.ibb.co/m86v2SB/useetv.png")!,
            description: "UseeTV GO menayangkan live streaming channel TV Indonesia atau internasional terlengkap dan ribuan film bioskop terbaik langsung dari handphonemu!",
            rating: 2.1,
            latestVersion: "3.9.0",
            publisher: "PT. Telkom Indonesia, Tbk.",
            colorTheme: "51557E")
        
        let json = makeItemsJSON([item1.json, item2.json])
        let samples = [200, 201, 250, 280, 299]
        
        try samples.forEach { code in
            let result = try FeedItemsMapper.map(json, from: HTTPURLResponse(statusCode: code))
            
            XCTAssertEqual(result, [item1.model, item2.model])
        }
    }
    
    
    // MARK: - Helpers
    
    private func makeItem(productName: String, productLogo: URL, description: String, rating: Double, latestVersion: String, publisher: String, colorTheme: String) -> (model: FeedItem, json: [String: Any]) {
        
        let item = FeedItem(productName: productName, productLogo: productLogo, description: description, rating: rating, latestVersion: latestVersion, publisher: publisher, colorTheme: colorTheme)
        
        let json: [String: Any] = [
            "productName": productName,
            "productLogo": productLogo.absoluteString,
            "description": description,
            "rating": rating,
            "latestVersion": latestVersion,
            "publisher": publisher,
            "colorTheme": colorTheme
        ].compactMapValues { $0 }
        
        return (item, json)
    }
}
