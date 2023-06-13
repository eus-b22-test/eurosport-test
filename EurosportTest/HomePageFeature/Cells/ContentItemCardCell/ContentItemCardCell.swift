//
//  ContentItemCardCell.swift
//  EurosportTest
//
//  Created by Baptiste on 11/06/2023.
//

import UIKit
import EurosportKit
import Combine

final class ContentItemCardCell: UICollectionViewCell, ESUIRegistrableCell {
    
    typealias Cell = ContentItemCardCell
    typealias CellViewModel = ContentItemCardCellViewModel
    
    var viewModel: CellViewModel!

    private let thumbnailImageView = ESUIImageView()
    private let playIconImageView = UIImageView()
    private let titleLabel = UILabel()
    private let annotationLabel = UILabel()
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
        
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true

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
        
        playIconImageView.image = UIImage(named: "play")
        contentView.addSubview(playIconImageView)
        playIconImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            playIconImageView.centerYAnchor.constraint(equalTo: thumbnailImageView.centerYAnchor),
            playIconImageView.centerXAnchor.constraint(equalTo: thumbnailImageView.centerXAnchor),
            playIconImageView.widthAnchor.constraint(equalTo: playIconImageView.heightAnchor)
        ])
        
        titleLabel.numberOfLines = 2
        titleLabel.font = .systemFont(ofSize: 18, weight: .black)
        titleLabel.textColor = .black
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: Constants.twentyMargin),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.eightMargin),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.eightMargin)
        ])

        annotationLabel.numberOfLines = 1
        annotationLabel.font = .systemFont(ofSize: 14)
        annotationLabel.textColor = .gray
        contentView.addSubview(annotationLabel)
        annotationLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            annotationLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.fourMargin),
            annotationLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.sixteenMargin),
            annotationLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.eightMargin),
            annotationLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.eightMargin)
        ])

        contentView.addSubview(sportBadge)
        sportBadge.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sportBadge.topAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: -Constants.badgeHeight/2),
            sportBadge.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.eightMargin),
            sportBadge.heightAnchor.constraint(equalToConstant: Constants.badgeHeight)
        ])
    }
    
    func updateUI() {
        thumbnailImageView.loadImage(
            from: viewModel.thumbUrl,
            placeholder: UIImage(named: "placeholder")
        )
        playIconImageView.isHidden = !viewModel.isVideo
        titleLabel.text = viewModel.title
        annotationLabel.text = viewModel.annotation
        sportBadge.configure(with: viewModel.makeSportBadgeViewModel())
    }
}
