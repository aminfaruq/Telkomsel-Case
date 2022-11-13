//
//  LocalFeedItem.swift
//  TelkomselModule
//
//  Created by Amin faruq on 13/11/22.
//

import Foundation
import RealmSwift

public class LocalFeedItem: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var productName: String = ""
    @Persisted var productLogo: String = ""
    @Persisted var productDescription: String = ""
    @Persisted var rating: Double = 0.0
    @Persisted var latestVersion: String = ""
    @Persisted var publisher: String = ""
    @Persisted var colorTheme: String = ""
    
    convenience init(productName: String, productLogo: String, productDescription: String, rating: Double, latestVersion: String, publisher: String, colorTheme: String) {
        self.init()
        self.productName = productName
        self.productLogo = productLogo
        self.productDescription = productDescription
        self.rating = rating
        self.latestVersion = latestVersion
        self.publisher = publisher
        self.colorTheme = colorTheme
    }

}
