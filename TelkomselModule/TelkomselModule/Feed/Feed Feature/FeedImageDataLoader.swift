//
//  FeedImageDataLoader.swift
//  TelkomselModule
//
//  Created by Amin faruq on 19/09/22.
//

import Foundation

public protocol FeedImageDataLoader {
    func loadImageData(from url: URL) throws -> Data
}
