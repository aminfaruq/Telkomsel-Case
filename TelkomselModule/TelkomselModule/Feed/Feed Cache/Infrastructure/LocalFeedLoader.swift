//
//  LocalFeedLoader.swift
//  EssentialFeed
//
//  Created by Amin faruq on 05/09/22.
//

import Foundation

public final class LocalFeedLoader {
    private let store: FeedStore
    
    public init(store: FeedStore) {
        self.store = store
    }
}

extension LocalFeedLoader: FeedCache {
    public func save(_ feed: [FeedItem]) throws {
        try store.deleteCachedFeed()
        try store.insert(feed.toLocal())
    }
}

extension LocalFeedLoader {
    public func load() throws -> [FeedItem] {
        if let cache = try store.retrieve() {
            return cache.toModels()
        }
        return []
    }
}

extension LocalFeedLoader {
    private struct InvalidCache: Error {}

    public func validateCache() throws {
        do {
            throw InvalidCache()
        } catch {
            try store.deleteCachedFeed()
        }
    }
}

private extension Array where Element == FeedItem {
    func toLocal() -> [LocalFeedItem] {
        return map { LocalFeedItem(productName: $0.productName, productLogo: $0.productLogo, description: $0.description, rating: $0.rating, latestVersion: $0.latestVersion, publisher: $0.publisher, colorTheme: $0.colorTheme) }
    }
}

private extension Array where Element == LocalFeedItem {
    func toModels() -> [FeedItem] {
        return map { FeedItem(productName: $0.productName, productLogo: $0.productLogo, description: $0.description, rating: $0.rating, latestVersion: $0.latestVersion, publisher: $0.publisher, colorTheme: $0.colorTheme) }
    }
}
