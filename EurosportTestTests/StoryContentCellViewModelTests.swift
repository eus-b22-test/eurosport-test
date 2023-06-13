//
//  StoryContentCellViewModelTests.swift
//  EurosportTestTests
//
//  Created by Baptiste on 13/06/2023.
//

import Foundation

import XCTest
import EurosportKit
@testable import EurosportTest

final class StoryContentCellViewModelTests: XCTestCase {

    func testStoryContentCellViewModel() {
        let viewModel = StoryContentCellViewModel(
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
        
        XCTAssertEqual(viewModel.content, "Sample Teaser")
    }
}
