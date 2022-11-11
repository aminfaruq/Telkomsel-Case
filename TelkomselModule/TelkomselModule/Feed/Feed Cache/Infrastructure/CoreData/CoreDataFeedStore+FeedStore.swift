//
//  CoreDataFeedStore+FeedStore.swift
//  EssentialFeed
//
//  Created by Amin faruq on 27/09/22.
//

import CoreData

extension CoreDataFeedStore: FeedStore {
    
    public func retrieve() throws -> CachedFeed? {
        try performSync { context in
            Result {
                try ManagedCache.find(in: context).map {
                    CachedFeed($0.localFeed)
                }
            }
        }
    }
    
    public func insert(_ feed: [LocalFeedItem]) throws {
        try performSync { context in
            Result {
                let managedCache = try ManagedCache.newUniqueInstance(in: context)
                managedCache.feed = ManagedFeedItem.items(from: feed, in: context)
                
                try context.save()
            }
        }
    }
    
    public func deleteCachedFeed() throws {
        try performSync { context in
            Result {
                try ManagedCache.deleteCache(in: context)
            }
        }
    }
}
