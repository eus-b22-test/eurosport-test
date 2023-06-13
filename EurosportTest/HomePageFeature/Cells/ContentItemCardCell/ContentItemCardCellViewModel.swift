//
//  ContentItemCardCellViewModel.swift
//  EurosportTest
//
//  Created by Baptiste on 11/06/2023.
//

import UIKit
import EurosportKit

struct ContentItemCardCellViewModel: Hashable {

    let contentItem: AnyContentItem

    var thumbUrl: String {
        switch contentItem {
            case .video(let video):
                return video.thumb
            case .story(let story):
                return story.image
        }
    }
    
    var title: String {
        switch contentItem {
            case .video(let video):
                return video.title
            case .story(let story):
                return story.title
        }
    }
    
    var annotation: String {
        switch contentItem {
            case .video(let video):
                return String(video.views) + " views"
            case .story(let story):
                return "By " + story.author + " - " + Date(timeIntervalSince1970: story.date).formattedDateComparedToNow
        }
    }
    
    var sport: ESSport {
        switch contentItem {
            case .video(let video):
                return video.sport
            case .story(let story):
                return story.sport
        }
    }

    var isVideo: Bool {
        switch contentItem {
            case .video:
                return true
            case .story:
                return false
        }
    }
    
    func makeSportBadgeViewModel() -> ESUIBadgeViewModel {
        return ESUIBadgeViewModel(
            backgroundColor: .systemBlue,
            tintColor: .white,
            text: sport.name.uppercased()
        )
    }
}
