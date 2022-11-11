//
//  FeedImageDataStore.swift
//  EssentialFeed
//
//  Created by Amin faruq on 27/09/22.
//

import Foundation

public protocol FeedImageDataStore {
    func insert(_ data: Data, for url: URL) throws
    func retrieve(dataForURL url: URL) throws -> Data?
}
