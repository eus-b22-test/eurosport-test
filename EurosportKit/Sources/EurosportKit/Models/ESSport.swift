//
//  ESSport.swift
//  
//
//  Created by Baptiste on 11/06/2023.
//

import Foundation

public struct ESSport: Codable, Hashable {
    public let id: Int64
    public let name: String
    
    public init(id: Int64, name: String) {
        self.id = id
        self.name = name
    }
}
