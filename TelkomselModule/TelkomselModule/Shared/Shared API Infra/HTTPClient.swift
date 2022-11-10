//
//  HTTPClient.swift
//  TelkomselModule
//
//  Created by Amin faruq on 31/10/22.
//

import Foundation

public protocol HTTPClientTask {
    func cancel()
}

public protocol HTTPClient {
    typealias Result = Swift.Result<(Data, HTTPURLResponse), Error>
    
    /// The completion handler can be invoked in any thread.
    /// Clients are responsible to dispatch to appropriate threads, if needed.
    @discardableResult
    func get(from url: URL, completion: @escaping(Result) -> Void) -> HTTPClientTask
    
    @discardableResult
    func post(from url: URL, completion: @escaping (Result) -> Void) -> HTTPClientTask
}

