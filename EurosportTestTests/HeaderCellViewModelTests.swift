//
//  HeaderCellViewModelTests.swift
//  EurosportTestTests
//
//  Created by Baptiste on 11/06/2023.
//

import XCTest
import EurosportKit
@testable import EurosportTest

final class HeaderCellViewModelTests: XCTestCase {

    func testHeaderCellViewModel() {
        let viewModel = HeaderCellViewModel(
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

        XCTAssertEqual(viewModel.imageUrl, "Sample Thumb")
        XCTAssertEqual(viewModel.sport.name, "CrossFit")
    }
    
    func testHeaderCellViewModel_sportBadge() {
        let viewModel = HeaderCellViewModel(
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
        
        let badgeViewModel = viewModel.makeSportBadgeViewModel()
        
        XCTAssertEqual(badgeViewModel.text, "CROSSFIT")
    }
}
