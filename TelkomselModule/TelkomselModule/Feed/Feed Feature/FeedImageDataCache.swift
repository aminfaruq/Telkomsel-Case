//
//  FeedImageDataCache.swift
//  EssentialFeed
//
//  Created by Amin faruq on 29/09/22.
//

import Foundation

public protocol FeedImageDataCache {
    func save(_ data: Data, for url: URL) throws
}
