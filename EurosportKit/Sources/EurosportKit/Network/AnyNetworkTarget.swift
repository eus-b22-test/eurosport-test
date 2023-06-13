//
//  AnyNetworkTarget.swift
//  
//
//  Created by Baptiste on 11/06/2023.
//

import Foundation

public protocol AnyNetworkTarget {
    var host: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
}

public extension AnyNetworkTarget {
    var url: URL {
        return host.appendingPathComponent(path)
    }
}
