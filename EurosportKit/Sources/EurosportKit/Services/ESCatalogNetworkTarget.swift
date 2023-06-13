//
//  ESCatalogNetworkTarget.swift
//  
//
//  Created by Baptiste on 11/06/2023.
//

import Foundation

public enum ESCatalogNetworkTarget {
    case fetchCatalog
}

extension ESCatalogNetworkTarget: AnyNetworkTarget {

    public var host: URL {
        return URL(string: "https://extendsclass.com")!
    }

    public var path: String {
        switch self {
            case .fetchCatalog:
                return "/api/json-storage/bin/edfefba"
        }
    }
    
    public var method: HTTPMethod {
        switch self {
            case .fetchCatalog:
                return .get
        }
    }
}
