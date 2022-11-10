//
//  FeedItem.swift
//  TelkomselModule
//
//  Created by Amin faruq on 10/11/22.
//

import Foundation

public struct FeedItem: Hashable {
    public let productName: String
    public let productLogo: URL
    public let description: String
    public let rating: Double
    public let latestVersion: String
    public let publisher: String
    public let colorTheme: String
    
    public init(productName: String, productLogo: URL, description: String, rating: Double, latestVersion: String, publisher: String, colorTheme: String) {
        self.productName = productName
        self.productLogo = productLogo
        self.description = description
        self.rating = rating
        self.latestVersion = latestVersion
        self.publisher = publisher
        self.colorTheme = colorTheme
    }
}
