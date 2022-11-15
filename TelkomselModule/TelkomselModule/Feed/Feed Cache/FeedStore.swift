//
//  FeedStore.swift
//  TelkomselModule
//
//  Created by Amin faruq on 13/11/22.
//

import Foundation
import RealmSwift

public  typealias CachedFeed = Results<LocalFeedItem>

public protocol FeedStore {
    func deleteCacheFeed(_ productName: String) throws
    func isProductSaved(_ productName: String) throws -> Bool
    func insert(_ feed: LocalFeedItem) throws
    func retrieve() throws -> CachedFeed?
}
