//
//  ImageLoader.swift
//  
//
//  Created by Baptiste on 11/06/2023.
//

import UIKit
import Combine

open class ImageLoader {

    private let session: URLSession

    public static let shared = ImageLoader()

    private init(session: URLSession = .shared) {
        self.session = session
    }
    
    public func fetchImage(url: URL) -> AnyPublisher<UIImage?, Never> {
        
        var request = URLRequest(url: url)
        request.timeoutInterval = 7
        
        return session.dataTaskPublisher(for: request)
            .map { $0.data }
            .compactMap { $0 }
            .compactMap { UIImage(data: $0) }
            .replaceError(with: nil)
            .eraseToAnyPublisher()
    }
}
