//
//  StoryInfosCell.swift
//  EurosportTest
//
//  Created by Baptiste on 11/06/2023.
//

import UIKit
import EurosportKit

final class StoryInfosCell: UICollectionViewCell, ESUIRegistrableCell {
    
    typealias Cell = StoryInfosCell
    typealias CellViewModel = StoryInfosCellViewModel
    
    var viewModel: CellViewModel!

    private let titleLabel = UILabel()
    private let authorLabel = UILabel()
    private let publishedDateLabel = UILabel()

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
        
        titleLabel.numberOfLines = 0
        titleLabel.font = .systemFont(ofSize: 18, weight: .black)
        titleLabel.textColor = .black
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.fourMargin),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.sixteenMargin),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.sixteenMargin)
        ])
        
        authorLabel.numberOfLines = 1
        authorLabel.font = .systemFont(ofSize: 14)
        authorLabel.textColor = .systemBlue
        contentView.addSubview(authorLabel)
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.fourMargin),
            authorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.sixteenMargin),
            authorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.sixteenMargin)
        ])
        
        publishedDateLabel.numberOfLines = 1
        publishedDateLabel.font = .systemFont(ofSize: 14)
        publishedDateLabel.textColor = .gray
        contentView.addSubview(publishedDateLabel)
        publishedDateLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            publishedDateLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: Constants.twoMargin),
            publishedDateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.fourMargin),
            publishedDateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.sixteenMargin),
            publishedDateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.sixteenMargin)
        ])
    }
    
    func updateUI() {
        titleLabel.text = viewModel.title
        authorLabel.text = viewModel.author
        publishedDateLabel.text = viewModel.formattedPublishedDate
    }
}
