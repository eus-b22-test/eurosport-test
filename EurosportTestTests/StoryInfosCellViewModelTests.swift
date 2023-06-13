//
//  StoryInfosCellViewModelTests.swift
//  EurosportTestTests
//
//  Created by Baptiste on 11/06/2023.
//

import XCTest
import EurosportKit
@testable import EurosportTest

final class StoryInfosCellViewModelTests: XCTestCase {

    func testStoryInfosCellViewModel() {
        let viewModel = StoryInfosCellViewModel(
            story: ESStory(
                id: 1234,
                title: "Sample Title",
                teaser: "Sample Teaser",
                image: "Sample Thumb",
                date: 123456789,
                author: "Sample Author",
                sport: ESSport(id: 1, name: "CrossFit")
            )
        )
        
        XCTAssertEqual(viewModel.title, "Sample Title")
        XCTAssertEqual(viewModel.author, "By Sample Author")
        XCTAssertEqual(viewModel.formattedPublishedDate, Date(timeIntervalSince1970: 123456789).formattedDateComparedToNow)
    }
}
