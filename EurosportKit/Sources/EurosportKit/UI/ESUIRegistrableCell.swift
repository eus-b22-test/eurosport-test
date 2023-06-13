//
//  ESUIRegistrableCell.swift
//  
//
//  Created by Baptiste on 11/06/2023.
//

import UIKit

public protocol ESUIRegistrableCell: ESUIUpdatableCell {
    associatedtype Cell: ESUIRegistrableCell
    static var cellRegistration: UICollectionView.CellRegistration<Cell, CellViewModel> { get }
}

public extension ESUIRegistrableCell where Self.CellViewModel == Self.Cell.CellViewModel {
    static var cellRegistration: UICollectionView.CellRegistration<Cell, CellViewModel> {
        return UICollectionView.CellRegistration<Cell, CellViewModel> {
            (cell, indexPath, viewModel) in
            cell.update(with: viewModel)
        }
    }
}
