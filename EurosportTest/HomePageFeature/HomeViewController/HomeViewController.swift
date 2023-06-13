//
//  HomeViewController.swift
//  EurosportTest
//
//  Created by Baptiste on 11/06/2023.
//

import AVFoundation
import AVKit
import UIKit
import EurosportKit
import Combine

final class HomeViewController: UIViewController {

    private let titleContentView = UIView()
    private let titleLabel = UILabel()

    private var collectionView: UICollectionView!
    private var activityIndicator: UIActivityIndicatorView!
    
    private var dataSource: UICollectionViewDiffableDataSource<HomeSectionViewModel, HomeItemViewModel>!
    
    var viewModel: HomeViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        configureHierarchy()
        configureDataSource()
        configureActivityIndicator()

        startFetching()
    }
    
    private func startFetching() {
        activityIndicator.startAnimating()
        viewModel.delegate = self
        viewModel.fetchData()
    }
    
    private func configureHierarchy() {

        view.backgroundColor = .systemGray5

        let topInsets = UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0
        
        titleContentView.backgroundColor = .systemBlue
        view.addSubview(titleContentView)
        titleContentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleContentView.topAnchor.constraint(equalTo: view.topAnchor),
            titleContentView.heightAnchor.constraint(equalToConstant: topInsets + Constants.titleViewHeight),
            titleContentView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            titleContentView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])

        titleLabel.text = viewModel.title
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.bottomAnchor.constraint(equalTo: titleContentView.bottomAnchor, constant: -Constants.eightMargin),
            titleLabel.leadingAnchor.constraint(equalTo: titleContentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: titleContentView.trailingAnchor)
        ])

        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCollectionViewLayout())
        collectionView.backgroundColor = .systemGray5
        collectionView.delegate = self
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: titleContentView.bottomAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    private func configureDataSource() {
        
        let contentItemCardCellRegistration = ContentItemCardCell.cellRegistration

        dataSource = UICollectionViewDiffableDataSource<
            HomeSectionViewModel,
            HomeItemViewModel
        >(collectionView: collectionView) {
            (collectionView, indexPath, viewModel) -> UICollectionViewCell? in

            let cell: UICollectionViewCell

            switch viewModel {
                case .contentItemCard(let cellViewModel):
                    cell = collectionView.dequeueConfiguredReusableCell(
                        using: contentItemCardCellRegistration,
                        for: indexPath,
                        item: cellViewModel
                    )
            }

            return cell
        }
    }

    private func configureActivityIndicator() {
        
        activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .medium
        view.addSubview(activityIndicator)

        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

extension HomeViewController {
    
    private func createCollectionViewLayout() -> UICollectionViewLayout {
        let layoutSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(1)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: layoutSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        item.edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: .none, top: .fixed(8), trailing: .none, bottom: .fixed(8))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: layoutSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
}

extension HomeViewController: HomeViewModelDelegate {
  
    func didFinishFetchingData(error: Error?) {
        activityIndicator.stopAnimating()
        if let _ = error {
            let alertController = UIAlertController(
                title: "Error",
                message: "Cannot load content. Please try again later.",
                preferredStyle: .alert
            )
            alertController.addAction(UIAlertAction(title: "Ok", style: .default))
            present(alertController, animated: true)
        } else {
            dataSource.apply(viewModel.snapshot, animatingDifferences: true)
        }
    }
    
    func didUpdateSnapshot() {
        dataSource.apply(viewModel.snapshot, animatingDifferences: true)
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
        
        let cellViewModelType = viewModel.sections[indexPath.section].items[indexPath.row]
        
        switch cellViewModelType {
            case .contentItemCard(let cellViewModel):
                userDidSelectContentItem(cellViewModel.contentItem)
        }
    }
    
    private func userDidSelectContentItem(_ contentItem: AnyContentItem) {
        switch contentItem {
            case .video(let video):
                presentVideoPlayerViewController(with: video)
            case .story(let story):
                presentStoryReaderViewController(with: story)
        }
    }
    
    private func presentVideoPlayerViewController(with video: ESVideo) {
        guard let videoURL = URL(string: video.url) else {
            return
        }

        let player = AVPlayer(url: videoURL)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        
        present(playerViewController, animated: true, completion: {
            playerViewController.player?.play()
        })
    }
    
    private func presentStoryReaderViewController(with story: ESStory) {
        let viewController = StoryViewController()
        viewController.viewModel = StoryViewModel(story: story)
        viewController.modalPresentationStyle = .pageSheet
        present(viewController, animated: true)
    }
}
