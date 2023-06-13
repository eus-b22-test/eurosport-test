//
//  StoryContentCell.swift
//  EurosportTest
//
//  Created by Baptiste on 11/06/2023.
//

import UIKit
import EurosportKit

final class StoryContentCell: UICollectionViewCell, ESUIRegistrableCell {
    
    typealias Cell = StoryContentCell
    typealias CellViewModel = StoryContentCellViewModel
    
    var viewModel: CellViewModel!

    private let contentLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHierarchy()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        configureHierarchy()
    }
    
    private func configureHierarchy() {
        
        contentView.backgroundColor = .white
        
        contentLabel.numberOfLines = 0
        contentLabel.font = .systemFont(ofSize: 16)
        contentLabel.textColor = .black
        contentView.addSubview(contentLabel)
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.fourMargin),
            contentLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.sixteenMargin),
            contentLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.sixteenMargin),
            contentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.sixteenMargin)
        ])
    }
    
    func updateUI() {
        contentLabel.text = viewModel.content
    }
}
