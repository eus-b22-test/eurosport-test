//
//  ESCatalogService.swift
//  
//
//  Created by Baptiste on 11/06/2023.
//

import Foundation
import Combine

public struct ESCatalogService {
    
    public let networkProvider: NetworkProvider<ESCatalogNetworkTarget>
    
    public init(
        networkProvider: NetworkProvider<ESCatalogNetworkTarget> = .init()
    ) {
        self.networkProvider = networkProvider
    }
    
    public func fetchCatalog() -> AnyPublisher<ESCatalog, Error> {
        return networkProvider.request(target: .fetchCatalog)
            .decode(type: ESCatalog.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
