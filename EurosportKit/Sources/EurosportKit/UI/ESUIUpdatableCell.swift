//
//  ESUIUpdatableCell.swift
//  
//
//  Created by Baptiste on 11/06/2023.
//

import UIKit

public protocol ESUIUpdatableCell: UICollectionViewCell {
    associatedtype CellViewModel
    var viewModel: CellViewModel! { get set }
    func update(with viewModel: CellViewModel)
    func updateUI()
}

public extension ESUIUpdatableCell {
    func update(with viewModel: CellViewModel) {
        self.viewModel = viewModel
        updateUI()
    }
}
