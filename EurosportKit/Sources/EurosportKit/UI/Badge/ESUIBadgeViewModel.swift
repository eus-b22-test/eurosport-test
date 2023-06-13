//
//  ESUIBadgeViewModel.swift
//  
//
//  Created by Baptiste on 11/06/2023.
//

import UIKit

public struct ESUIBadgeViewModel {
    public let backgroundColor: UIColor
    public let tintColor: UIColor
    public let text: String
    
    public init(
        backgroundColor: UIColor,
        tintColor: UIColor,
        text: String
    ) {
        self.backgroundColor = backgroundColor
        self.tintColor = tintColor
        self.text = text
    }
}
