//
//  ESCatalog.swift
//  
//
//  Created by Baptiste on 11/06/2023.
//

import Foundation

public struct ESCatalog: Codable, Hashable {
    public let videos: [ESVideo]
    public let stories: [ESStory]
    
    public init(videos: [ESVideo], stories: [ESStory]) {
        self.videos = videos
        self.stories = stories
    }
}
