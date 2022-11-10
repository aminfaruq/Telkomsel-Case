//
//  URLSessionHTTPClient.swift
//  TelkomselModule
//
//  Created by Amin faruq on 31/10/22.
//

import Foundation

public final class URLSessionHTTPClient : HTTPClient {
    
    private let session: URLSession
    
    public init(session: URLSession) {
        self.session = session
    }
    
    private struct UnexpectedValuesRepresentation: Error {}
    
    private struct URLSessionTaskWrapper: HTTPClientTask {
        let wrapped: URLSessionTask
        
        func cancel() {
            wrapped.cancel()
        }
    }
    
    public func get(from url: URL, completion: @escaping (HTTPClient.Result) -> Void) -> HTTPClientTask {
        let task = session.dataTask(with: url) { data, response, error in
            completion(Result {
                if let error = error {
                    throw error
                } else if let data = data, let response = response as? HTTPURLResponse {
                    return (data, response)
                } else {
                    throw UnexpectedValuesRepresentation()
                }
            })
        }
        task.resume()
        return URLSessionTaskWrapper(wrapped: task)
    }
    
    public func post(from url: URL, completion: @escaping (HTTPClient.Result) -> Void) -> HTTPClientTask {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let task = session.dataTask(with: request) {  data, response, error in
            completion(Result {
                if let error = error {
                    throw error
                } else if let data = data, let response = response as? HTTPURLResponse {
                    return (data, response)
                } else {
                    throw UnexpectedValuesRepresentation()
                }
            })
        }
        
        task.resume()
        return URLSessionTaskWrapper(wrapped: task)
        
    }
}

public extension URLRequest {
    var httpBodyData: Data? {
        guard let stream = httpBodyStream else { return httpBody }
        
        let bufferSize = 1024
        var data = Data()
        var buffer = [UInt8](repeating: 0, count: bufferSize)
        
        stream.open()
        
        while stream.hasBytesAvailable {
            let length = stream.read(&buffer, maxLength: bufferSize)
            
            if length == 0 {
                break
            } else {
                data.append(&buffer, count: length)
            }
        }
        stream.close()
        
        return data
    }
}
