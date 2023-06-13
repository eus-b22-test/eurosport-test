//
//  ContentItemCardCellViewModel.swift
//  EurosportTestTests
//
//  Created by Baptiste on 11/06/2023.
//

import XCTest
import EurosportKit
@testable import EurosportTest

final class ContentItemCardCellViewModelTests: XCTestCase {

    func testContentItemCardCellViewModel_video() {
        let viewModel = ContentItemCardCellViewModel(
            contentItem: .video(
                ESVideo(
                    id: 1234,
                    title: "Sample Title",
                    thumb: "Sample Thumb",
                    url: "Sample URL",
                    date: 123456789,
                    sport: ESSport(id: 1, name: "Golf"),
                    views: 786
                )
            )
        )
        
        XCTAssertEqual(viewModel.title, "Sample Title")
        XCTAssertEqual(viewModel.thumbUrl, "Sample Thumb")
        XCTAssertEqual(viewModel.annotation, "786 views")
        XCTAssertEqual(viewModel.sport.name, "Golf")
        XCTAssertTrue(viewModel.isVideo)
    }
    
    func testContentItemCardCellViewModel_story() {
        let viewModel = ContentItemCardCellViewModel(
            contentItem: .story(
                ESStory (
                    id: 1234,
                    title: "Sample Title",
                    teaser: "Sample Teaser",
                    image: "Sample Thumb",
                    date: 123456789,
                    author: "Sample Author",
                    sport: ESSport(id: 1, name: "Golf")
                )
            )
        )
        
        XCTAssertEqual(viewModel.title, "Sample Title")
        XCTAssertEqual(viewModel.thumbUrl, "Sample Thumb")
        XCTAssertEqual(viewModel.annotation, "By Sample Author - " + Date(timeIntervalSince1970: 123456789).formattedDateComparedToNow)
        XCTAssertEqual(viewModel.sport.name, "Golf")
        XCTAssertFalse(viewModel.isVideo)
    }
}
