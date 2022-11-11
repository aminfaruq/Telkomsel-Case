//
//  FeedStore.swift
//  EssentialFeed
//
//  Created by Amin faruq on 05/09/22.
//

import Foundation

public typealias CachedFeed = ([LocalFeedItem])

public protocol FeedStore {
    func deleteCachedFeed() throws
    func insert(_ feed: [LocalFeedItem]) throws
    func retrieve() throws -> CachedFeed?
}
