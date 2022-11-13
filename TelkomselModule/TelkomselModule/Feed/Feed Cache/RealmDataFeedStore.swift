//
//  RealmDataFeedStore.swift
//  TelkomselModule
//
//  Created by Amin faruq on 13/11/22.
//

import RealmSwift

public final class RealmDataFeedStore {
    private let realm: Realm
    
    public init(realm: Realm) {
        self.realm = realm
    }
}

extension RealmDataFeedStore : FeedStore {
    
    public func deleteCacheFeed(_ productName: String) throws {
        let object = realm.objects(LocalFeedItem.self).filter("productName = %@", productName).first
        try! realm.write {
            if let obj = object {
                realm.delete(obj)
            }
        }
    }
    
    public func insert(_ feed: LocalFeedItem) throws {
        let product = LocalFeedItem(productName: feed.productName, productLogo: feed.productLogo, productDescription: feed.productDescription, rating: feed.rating, latestVersion: feed.latestVersion, publisher: feed.publisher, colorTheme: feed.colorTheme)
        try! self.realm.write {
            self.realm.add(product)
        }
        
    }
    
    public func retrieve() throws -> Results<LocalFeedItem> {
        let object = realm.objects(LocalFeedItem.self)
        return object
    }
    
    public func isProductSaved(_ productName: String) throws -> Bool {
        let product = realm.objects(LocalFeedItem.self)
        let filteredProduct = product.where({$0.productName == productName})
        return (filteredProduct.count > 0)
    }
}
