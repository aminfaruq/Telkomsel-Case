//
//  LocalFeedLoader.swift
//  TelkomselModule
//
//  Created by Amin faruq on 13/11/22.
//

import Foundation
import RealmSwift

public final class LocalFeedLoader {
    private let store: FeedStore
    
    public init(store: FeedStore) {
        self.store = store
    }
}

extension LocalFeedLoader: FeedCache {
    public func save(_ feed: FeedItem) throws {
        try store.insert(
            LocalFeedItem(
                productName: feed.productName,
                productLogo: feed.productLogo.absoluteString,
                productDescription: feed.description,
                rating: feed.rating,
                latestVersion: feed.latestVersion,
                publisher: feed.publisher,
                colorTheme: feed.colorTheme)
        )
    }
    
    public func isProductSaved(_ productName: String) throws -> Bool {
        try store.isProductSaved(productName)
    }
    
    public func deleteCacheFeed(_ productName: String) throws {
        try store.deleteCacheFeed(productName)
    }
}

extension LocalFeedLoader {
    public func load() throws -> [FeedItem] {
        if let cache = try store.retrieve() {
            return cache.map { result in
                FeedItem(
                    productName: result.productName,
                    productLogo: URL(string: result.productLogo)!,
                    description: result.productDescription,
                    rating: result.rating,
                    latestVersion: result.latestVersion,
                    publisher: result.publisher,
                    colorTheme: result.colorTheme)
            }
        }
        return []
    }
}

