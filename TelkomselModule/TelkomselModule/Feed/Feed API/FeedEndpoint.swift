//
//  FeedEndpoint.swift
//  TelkomselModule
//
//  Created by Amin faruq on 17/10/22.
//

import Foundation

public enum FeedEndpoint {
    case post

    public func url(baseURL: URL) -> URL {
        switch self {
        case .post:
            return baseURL.appendingPathComponent("/telkom/v2/products")
        }
    }
 }
