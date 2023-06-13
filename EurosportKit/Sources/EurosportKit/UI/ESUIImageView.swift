//
//  ESUIImageView.swift
//  
//
//  Created by Baptiste on 11/06/2023.
//

import UIKit
import Combine

open class ESUIImageView: UIImageView {
    
    private var cancellables = Set<AnyCancellable>()

    open func loadImage(from urlString: String?, placeholder: UIImage?, imageLoader: ImageLoader = .shared) {
        self.image = placeholder

        guard let urlString = urlString, let url = URL(string: urlString) else {
            return
        }
        
        imageLoader.fetchImage(url: url)
            .sink(
                receiveValue: {
                    [weak self] image in
                    guard let image = image else { return }
                    
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            )
            .store(in: &cancellables)
    }
}
