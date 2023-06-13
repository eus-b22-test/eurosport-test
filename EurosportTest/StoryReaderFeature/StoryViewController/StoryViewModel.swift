//
//  StoryViewModel.swift
//  EurosportTest
//
//  Created by Baptiste on 11/06/2023.
//

import UIKit
import EurosportKit
import Combine

struct StorySectionViewModel: Hashable {
    let items: [StoryItemViewModel]
}

enum StoryItemViewModel: Hashable {
    case header(HeaderCellViewModel)
    case storyInfos(StoryInfosCellViewModel)
    case storyContent(StoryContentCellViewModel)
}

final class StoryViewModel {
    
    let story: ESStory

    private(set) var snapshot = NSDiffableDataSourceSnapshot<StorySectionViewModel, StoryItemViewModel>()
    
    private var cancellables = Set<AnyCancellable>()
    
    init(story: ESStory) {
        self.story = story
    }
    
    func prepareSnapshot() {
        snapshot.deleteAllItems()
        snapshot.deleteSections(snapshot.sectionIdentifiers)
        
        let sections: [StorySectionViewModel] = [
            buildStorySectionViewModel()
        ]
        
        snapshot.appendSections(sections)
        for section in sections {
            snapshot.appendItems(section.items, toSection: section)
        }
    }
    
    private func buildStorySectionViewModel() -> StorySectionViewModel {
        return StorySectionViewModel(
            items: [
                .header(
                    HeaderCellViewModel(story: story)
                ),
                .storyInfos(
                    StoryInfosCellViewModel(story: story)
                ),
                .storyContent(
                    StoryContentCellViewModel(story: story)
                )
            ]
        )
    }
}
