//
//  CombineLabAPI.swift
//  CombineLabAPI
//
//  Created by Carlo Rapisarda on 10/3/19.
//  Copyright © 2019 Carlo Rapisarda. All rights reserved.
//

import Foundation
import Combine
import CombineLabModel

public enum APIError: Error {
    case unknown
    case withResponseCode(Int)
}

enum APIEndpoint: String {
    case user
}

extension APIEndpoint {
    
    static let baseURL = URL(string: "http://localhost:8080")!
    
    var url: URL {
        APIEndpoint.baseURL.appendingPathComponent(rawValue)
    }
}

public class CombineLabAPI {

    private init() {}
    
    static func makePublisher<T: Decodable>(_ url: URL) -> AnyPublisher<T, Error> {
        let request = URLRequest(url: url)
        let session = URLSession(configuration: .default)
        
        return session.dataTaskPublisher(for: request)
            .tryMap { data, response in
                if let response = response as? HTTPURLResponse {
                    guard 200...299 ~= response.statusCode else {
                        throw APIError.withResponseCode(response.statusCode)
                    }
                } else {
                    throw APIError.unknown
                }
                return data
        }
        .decode(type: T.self, decoder: JSONDecoder())
        .eraseToAnyPublisher()
    }
    
    static func makePublisher<T: Decodable>(_ endpoint: APIEndpoint) -> AnyPublisher<T, Error> {
        makePublisher(endpoint.url)
    }
}

extension CombineLabAPI {
    
    public static func userPublisher() -> AnyPublisher<User, Error> {
        makePublisher(.user)
    }
}
