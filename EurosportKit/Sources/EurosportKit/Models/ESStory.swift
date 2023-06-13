//
//  ESStory.swift
//  
//
//  Created by Baptiste on 11/06/2023.
//

import Foundation

public struct ESStory: Codable, Hashable {
    public let id: Int64
    public let title: String
    public let teaser: String
    public let image: String
    public let date: TimeInterval
    public let author: String
    public let sport: ESSport
    
    public init(
        id: Int64,
        title: String,
        teaser: String,
        image: String,
        date: TimeInterval,
        author: String,
        sport: ESSport
    ) {
        self.id = id
        self.title = title
        self.teaser = teaser
        self.image = image
        self.date = date
        self.author = author
        self.sport = sport
    }
}
