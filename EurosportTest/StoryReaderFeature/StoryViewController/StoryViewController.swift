//
//  StoryViewController.swift
//  EurosportTest
//
//  Created by Baptiste on 11/06/2023.
//

import UIKit
import Combine

final class StoryViewController: UIViewController {

    private let backButton = UIButton()
    private let shareButton = UIButton()
    private var collectionView: UICollectionView!

    private var dataSource: UICollectionViewDiffableDataSource<StorySectionViewModel, StoryItemViewModel>!
    
    var viewModel: StoryViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        configureHierarchy()
        configureNavigationButtons()
        configureDataSource()
        
        startFetching()
    }
    
    private func startFetching() {
        viewModel.prepareSnapshot()
        dataSource.apply(viewModel.snapshot, animatingDifferences: true)
    }
    
    private func configureNavigationButtons() {
        backButton.setImage(UIImage(named: "back"), for: [])
        backButton.addTarget(self, action: #selector(self.didTapBackButton), for: .touchUpInside)
        view.addSubview(backButton)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.twentyFourMargin),
            backButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.sixteenMargin)
        ])

        shareButton.setImage(UIImage(named: "share"), for: [])
        shareButton.addTarget(self, action: #selector(self.didTapShareButton), for: .touchUpInside)
        view.addSubview(shareButton)
        shareButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            shareButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.twentyFourMargin),
            shareButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Constants.sixteenMargin)
        ])
    }
    
    @objc func didTapBackButton() {
        self.dismiss(animated: true)
    }

    @objc func didTapShareButton() {
        let itemsToShare = [viewModel.story.title]
        let activityViewController = UIActivityViewController(
            activityItems: itemsToShare,
            applicationActivities: nil
        )
        activityViewController.popoverPresentationController?.sourceView = self.view
        present(activityViewController, animated: true, completion: nil)
    }

    private func configureHierarchy() {

        view.backgroundColor = .white
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCollectionViewLayout())
        view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    private func configureDataSource() {
        
        let headerCellRegistration = HeaderCell.cellRegistration
        let storyInfosCellRegistration = StoryInfosCell.cellRegistration
        let storyContentCellRegistration = StoryContentCell.cellRegistration

        dataSource = UICollectionViewDiffableDataSource<
            StorySectionViewModel,
            StoryItemViewModel
        >(collectionView: collectionView) {
            (collectionView, indexPath, viewModel) -> UICollectionViewCell? in

            let cell: UICollectionViewCell

            switch viewModel {
                case .header(let cellViewModel):
                    cell = collectionView.dequeueConfiguredReusableCell(
                        using: headerCellRegistration,
                        for: indexPath,
                        item: cellViewModel
                    )
                case .storyInfos(let cellViewModel):
                    cell = collectionView.dequeueConfiguredReusableCell(
                        using: storyInfosCellRegistration,
                        for: indexPath,
                        item: cellViewModel
                    )
                case .storyContent(let cellViewModel):
                    cell = collectionView.dequeueConfiguredReusableCell(
                        using: storyContentCellRegistration,
                        for: indexPath,
                        item: cellViewModel
                    )
            }

            return cell
        }
    }
}

extension StoryViewController {
    private func createCollectionViewLayout() -> UICollectionViewLayout {

        let layoutSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(1)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: layoutSize)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: layoutSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
}
