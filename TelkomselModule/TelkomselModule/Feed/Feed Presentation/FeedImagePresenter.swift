//
//  FeedImagePresenter.swift
//  TelkomselModule
//
//  Created by Amin faruq on 10/11/22.
//

import Foundation

public final class FeedImagePresenter {
    public static func map(_ item: FeedItem) -> FeedImageViewModel {
        FeedImageViewModel(productName: item.productName, description: item.description, rating: item.rating, latestVersion: item.latestVersion, publisher: item.publisher, colorTheme: item.colorTheme)
    }
}
