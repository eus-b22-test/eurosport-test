//
//  NetworkProvider.swift
//  
//
//  Created by Baptiste on 11/06/2023.
//

import Foundation
import Combine

open class NetworkProvider<Target: AnyNetworkTarget> {
    
    public let urlSession: URLSession

    public init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    open func request(target: Target) -> AnyPublisher<Data, Error> {
        
        var request = URLRequest(url: target.url)
        request.httpMethod = target.method.rawValue
        
        return urlSession
            .dataTaskPublisher(for: request)
            .tryMap() { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return element.data
            }
            .eraseToAnyPublisher()
    }
}
