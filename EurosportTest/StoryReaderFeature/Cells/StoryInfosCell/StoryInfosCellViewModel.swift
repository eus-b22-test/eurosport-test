//
//  StoryInfosCellViewModel.swift
//  EurosportTest
//
//  Created by Baptiste on 11/06/2023.
//

import UIKit
import EurosportKit

struct StoryInfosCellViewModel: Hashable {

    let story: ESStory

    var title: String {
        return story.title
    }

    var author: String {
        return "By " + story.author
    }

    var formattedPublishedDate: String {
        return Date(timeIntervalSince1970: story.date).formattedDateComparedToNow
    }
}
