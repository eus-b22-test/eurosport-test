//
//  ESUIBadge.swift
//  
//
//  Created by Baptiste on 11/06/2023.
//

import UIKit

open class ESUIBadge: UIView {
    
    struct Constants {
        static let padding: CGFloat = 4
        static let spacing: CGFloat = 4
        static let cornerRadius: CGFloat = 8
        static let font: UIFont = .systemFont(ofSize: 14, weight: .medium)
    }

    public let textLabel = UILabel()
    
    public private(set) var viewModel: ESUIBadgeViewModel?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHierarchy()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        configureHierarchy()
    }

    private func configureHierarchy() {
        textLabel.numberOfLines = 1
        textLabel.font = Constants.font
        addSubview(textLabel)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: topAnchor, constant: Constants.padding),
            textLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.padding),
            textLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.padding * 2),
            textLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.padding * 2),
        ])
    }
    
    private func configureUI() {
        guard let viewModel = viewModel else {
            return
        }

        textLabel.text = viewModel.text
        textLabel.textColor = viewModel.tintColor
        backgroundColor = viewModel.backgroundColor
        layer.cornerRadius = Constants.cornerRadius
        layer.masksToBounds = true
    }
}

public extension ESUIBadge {
    func configure(with viewModel: ESUIBadgeViewModel) {
        self.viewModel = viewModel
        
        configureUI()
    }
}
