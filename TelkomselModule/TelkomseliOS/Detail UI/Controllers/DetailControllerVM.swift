//
//  DetailControllerVM.swift
//  TelkomseliOS
//
//  Created by Amin faruq on 13/11/22.
//

import Foundation
import RealmSwift
import TelkomselModule

public class DetailControllerVM {
    
    private lazy var store: FeedStore = {
        let realm = try! Realm()
        return  RealmDataFeedStore(realm: realm)
    }()

    private lazy var localFeedLoader: LocalFeedLoader = {
        LocalFeedLoader(store: store )
    }()
    
    public init() {}
    
    func isProductSaved(productName: String) -> Bool {
        try! localFeedLoader.isProductSaved(productName)
    }
    
    func saveProduct(item: FeedItem) {
        try? localFeedLoader.save(item)
    }
    
    func deleteProduct(productName: String) {
        try? localFeedLoader.deleteCacheFeed(productName)
    }
}
