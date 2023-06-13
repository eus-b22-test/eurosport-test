//
//  HeaderCellViewModel.swift
//  EurosportTest
//
//  Created by Baptiste on 11/06/2023.
//

import UIKit
import EurosportKit

struct HeaderCellViewModel: Hashable {

    let story: ESStory

    var imageUrl: String {
        return story.image
    }
    
    var sport: ESSport {
        return story.sport
    }

    func makeSportBadgeViewModel() -> ESUIBadgeViewModel {
        return ESUIBadgeViewModel(
            backgroundColor: .systemBlue,
            tintColor: .white,
            text: sport.name.uppercased()
        )
    }
}
