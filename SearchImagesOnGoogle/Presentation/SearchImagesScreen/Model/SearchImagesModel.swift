//
//  SearchImagesModel.swift
//  SearchImagesOnGoogle
//
//  Created by Konstantin Pimbursky on 15.12.2022.
//

import UIKit

// MARK: - Model

protocol SearchImagesModel {
    
    // MARK: - Public Properties
    
    var searchParameters: SearchParameters { get set }
    var searchResults: [SingleImageResult] { get set }
    
    // MARK: - Public Methods
    
    func searchImages(completion: @escaping (_ isSuccess: Bool, _ error: Error?) -> Void)
    func fetchNextPageOfImages(completion: @escaping (_ isSuccess: Bool, _ error: Error?) -> Void)
}

// MARK: - Implementation

final class SearchImagesModelImpl: SearchImagesModel {
    
    // MARK: - Public Properties
    
    public var searchParameters: SearchParameters
    public var searchResults: [SingleImageResult]
    
    // MARK: - Private Properties
    
    private let serverService = ApiService.shared
    
    // MARK: - Initializers
    
    /// Default initializer
    init(
        searchParameters: SearchParameters = SearchParameters(searchText: "", paginationPage: 0),
        searchResults: [SingleImageResult] = []
    ) {
        self.searchParameters = searchParameters
        self.searchResults = searchResults
    }
    
    // MARK: - Public Methods
    
    public func searchImages(
        completion: @escaping (_ isSuccess: Bool, _ error: Error?) -> Void
    ) {
        searchParameters.paginationPage = 0
        sendSearchRequest { [weak self] result in
            switch result {
            case .success(let imagesResults):
                self?.searchResults = imagesResults.results.filter({ $0.position <= 100 })
                completion(true, nil)
            case .failure(let error):
                completion(false, error)
            }
        }
    }
    
    public func fetchNextPageOfImages(
        completion: @escaping (_ isSuccess: Bool, _ error: Error?) -> Void
    ) {
        guard
            !searchParameters.searchText.isEmpty,
            searchResults.count % 100 == 0
        else { return }
        searchParameters.paginationPage += 1
        sendSearchRequest { [weak self] result in
            switch result {
            case .success(let imagesResults):
                self?.searchResults += imagesResults.results
                completion(true, nil)
            case .failure(let error):
                completion(false, error)
            }
        }
    }
    
    // MARK: - Private Methods
    
    private func sendSearchRequest(completion: @escaping (Result<ImagesResults, Error>) -> Void) {
        serverService.searchImages(
            for: searchParameters,
            completion: completion
        )
    }
}
