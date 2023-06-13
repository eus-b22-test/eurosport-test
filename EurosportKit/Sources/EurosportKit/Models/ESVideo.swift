//
//  ESVideo.swift
//  
//
//  Created by Baptiste on 11/06/2023.
//

import Foundation

public struct ESVideo: Codable, Hashable {
    public let id: Int64
    public let title: String
    public let thumb: String
    public let url: String
    public let date: TimeInterval
    public let sport: ESSport
    public let views: Int64
    
    public init(
        id: Int64,
        title: String,
        thumb: String,
        url: String,
        date: TimeInterval,
        sport: ESSport,
        views: Int64
    ) {
        self.id = id
        self.title = title
        self.thumb = thumb
        self.url = url
        self.date = date
        self.sport = sport
        self.views = views
    }
}
