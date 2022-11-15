//
//  FeedStoreSpy.swift
//  TelkomselModuleTests
//
//  Created by Amin faruq on 15/11/22.
//

import Foundation
import TelkomselModule
import RealmSwift

class FeedStoreSpy: FeedStore {
    
    enum ReceivedMessage: Equatable {
        case deleteCacheFeed(String)
        case isProductSaved(String)
        case insert(LocalFeedItem)
        case retrieve
    }

    private(set) var receivedMessages = [ReceivedMessage]()
    private var deletionResult: Result<Void, Error>?
    private var insertionResult: Result<Void, Error>?
    private var retrievalResult: Result<CachedFeed?, Error>?
    private var retrievalSavedResult: Result<Void, Error>?

    func deleteCacheFeed(_ productName: String) throws {
        receivedMessages.append(.deleteCacheFeed(productName))
        try deletionResult?.get()
    }

    func completeDeletion(with error: Error) {
        deletionResult = .failure(error)
    }

    func completeDeletionSuccessfully() {
        deletionResult = .success(())
    }

    func isProductSaved(_ productName: String) throws -> Bool {
        receivedMessages.append(.isProductSaved(productName))
        return ((try retrievalSavedResult?.get()) != nil)
    }

    func insert(_ feed: LocalFeedItem) throws {
        receivedMessages.append(.insert(feed))
        try insertionResult?.get()
    }

    func completeInsertion(with error: Error) {
        insertionResult = .failure(error)
    }

    func completeInsertionSuccessfully() {
        insertionResult = .success(())
    }

    func retrieve() throws -> CachedFeed? {
        receivedMessages.append(.retrieve)
        return try retrievalResult?.get()
    }
    
    func completeRetrieval(with error: Error) {
        retrievalResult = .failure(error)
    }
    
    func completeRetrievalWithEmptyCache() {
        retrievalResult = .success(.none)
    }
    
    func completeRetrieval(with feed: Results<LocalFeedItem>) {
        retrievalResult = .success(feed)
    }
}
