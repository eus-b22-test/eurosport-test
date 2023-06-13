//
//  HeaderCell.swift
//  EurosportTest
//
//  Created by Baptiste on 11/06/2023.
//

import UIKit
import EurosportKit
import Combine

final class HeaderCell: UICollectionViewCell, ESUIRegistrableCell {
    
    typealias Cell = HeaderCell
    typealias CellViewModel = HeaderCellViewModel
    
    var viewModel: CellViewModel!

    private let thumbnailImageView = ESUIImageView()
    private let sportBadge = ESUIBadge()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHierarchy()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        configureHierarchy()
    }
    
    private func configureHierarchy() {

        thumbnailImageView.contentMode = .scaleAspectFill
        thumbnailImageView.clipsToBounds = true
        contentView.addSubview(thumbnailImageView)
        thumbnailImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            thumbnailImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            thumbnailImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            thumbnailImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            thumbnailImageView.widthAnchor.constraint(equalTo: thumbnailImageView.heightAnchor, multiplier: 1.77)
        ])
        
        contentView.addSubview(sportBadge)
        sportBadge.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sportBadge.topAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: -Constants.badgeHeight/2),
            sportBadge.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.fourMargin),
            sportBadge.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.sixteenMargin),
            sportBadge.heightAnchor.constraint(equalToConstant: Constants.badgeHeight)
        ])
    }
    
    func updateUI() {
        thumbnailImageView.loadImage(
            from: viewModel.imageUrl,
            placeholder: UIImage(named: "placeholder")
        )
        sportBadge.configure(with: viewModel.makeSportBadgeViewModel())
    }
}
