//
//  StoryContentCellViewModel.swift
//  EurosportTest
//
//  Created by Baptiste on 11/06/2023.
//

import UIKit
import EurosportKit

struct StoryContentCellViewModel: Hashable {

    let story: ESStory

    var content: String {
        return story.teaser
    }
}
