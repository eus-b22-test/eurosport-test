//
//  HomeViewModel.swift
//  EurosportTest
//
//  Created by Baptiste on 11/06/2023.
//

import UIKit
import EurosportKit
import Combine

struct HomeSectionViewModel: Hashable {
    let items: [HomeItemViewModel]
}

enum HomeItemViewModel: Hashable {
    case contentItemCard(ContentItemCardCellViewModel)
}

enum AnyContentItem: Hashable {
    case video(ESVideo)
    case story(ESStory)
}

protocol HomeViewModelDelegate: AnyObject {
    func didFinishFetchingData(error: Error?)
    func didUpdateSnapshot()
}

final class HomeViewModel {
    
    private let service: ESCatalogService

    private(set) var sections: [HomeSectionViewModel] = []
    private(set) var snapshot = NSDiffableDataSourceSnapshot<HomeSectionViewModel, HomeItemViewModel>()
    
    private var cancellables = Set<AnyCancellable>()
    
    weak var delegate: HomeViewModelDelegate?
    
    let title: String = "FEATURED"
    
    init(service: ESCatalogService = .init()) {
        self.service = service
    }
    
    func fetchData() {
        service.fetchCatalog()
            .sink(
                receiveCompletion: {
                    [weak self] completion in
                    DispatchQueue.main.async {
                        switch completion {
                            case .failure(let error):
                                self?.delegate?.didFinishFetchingData(error: error)
                            case .finished:
                                self?.delegate?.didFinishFetchingData(error: nil)
                        }
                    }
                },
                receiveValue: {
                    [weak self] catalog in
                    self?.prepareSnapshot(catalog: catalog)
                }
            )
            .store(in: &cancellables)
    }
    
    private func prepareSnapshot(catalog: ESCatalog) {

        let sections: [HomeSectionViewModel] = [
            buildContentItemListSectionViewModel(catalog: catalog)
        ]
        
        self.sections = sections
        
        snapshot.appendSections(sections)
        for section in sections {
            snapshot.appendItems(section.items, toSection: section)
        }
    }
    
    // Returns Story - Video - Story - Video
    // Each type of item being sorted by date to keep mixed item types as long as possible.
    private func getSortedMixedContentItemList(
        from catalog: ESCatalog
    ) -> [AnyContentItem] {
        
        var sortedVideos = catalog.videos.sorted(by: {
            (lVideo, rVideo) -> Bool in
            return lVideo.date > rVideo.date
        })

        var sortedStories = catalog.stories.sorted(by: {
            (lStory, rStory) -> Bool in
            return lStory.date > rStory.date
        })
        
        var mixedContentItems: [AnyContentItem] = []

        while !sortedVideos.isEmpty || !sortedStories.isEmpty {
            if !sortedStories.isEmpty {
                mixedContentItems.append(
                    .story(sortedStories.removeFirst())
                )
            }
            if !sortedVideos.isEmpty {
                mixedContentItems.append(
                    .video(sortedVideos.removeFirst())
                )
            }
        }
        
        return mixedContentItems
    }
        
    private func buildContentItemListSectionViewModel(
        catalog: ESCatalog
    ) -> HomeSectionViewModel {

        let mixedContentItems = getSortedMixedContentItemList(from: catalog)
        
        let items: [HomeItemViewModel] = mixedContentItems.map {
            item in
            return .contentItemCard(
                ContentItemCardCellViewModel(contentItem: item)
            )
        }

        return HomeSectionViewModel(
            items: items
        )
    }
}
