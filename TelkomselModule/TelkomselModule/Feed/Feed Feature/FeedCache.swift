//
//  FeedCache.swift
//  EssentialFeed
//
//  Created by Amin faruq on 29/09/22.
//

import Foundation

public protocol FeedCache {
    func save(_ feed: [FeedItem]) throws
}
