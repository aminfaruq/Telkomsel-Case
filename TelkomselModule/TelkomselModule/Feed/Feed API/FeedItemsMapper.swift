//
//  FeedItemsMapper.swift
//  TelkomselModule
//
//  Created by Amin faruq on 10/11/22.
//

import Foundation

public final class FeedItemsMapper {
    
    private struct Root: Decodable {
//        private let ok: Bool
        private let data: [Feed]
        
        private struct Feed: Decodable {
            let productName: String
            let productLogo: URL
            let description: String
            let rating: Double
            let latestVersion: String
            let publisher: String
            let colorTheme: String
        }
        
        var feed: [FeedItem] {
            data.map { FeedItem(productName: $0.productName, productLogo: $0.productLogo, description: $0.description, rating: $0.rating, latestVersion: $0.latestVersion, publisher: $0.publisher, colorTheme: $0.colorTheme) }
        }
    }
    
    public enum Error: Swift.Error {
        case invalidData
    }
    
    public static func map(_ data: Data, from response: HTTPURLResponse) throws -> [FeedItem] {
            
        guard isOK(response), let root = try? JSONDecoder().decode(Root.self, from: data) else {
            throw Error.invalidData
        }
        
        return root.feed
    }
    
    private static func isOK(_ response: HTTPURLResponse) -> Bool {
        (200...299).contains(response.statusCode)
    }
}
