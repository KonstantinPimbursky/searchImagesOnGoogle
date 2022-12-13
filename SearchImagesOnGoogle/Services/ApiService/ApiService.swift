//
//  ApiService.swift
//  SearchImagesOnGoogle
//
//  Created by Konstantin Pimbursky on 07.12.2022.
//

import Foundation

final class ApiService {
    
    // MARK: - Public Properties
    
    public static let shared = ApiService()
    
    // MARK: - Private Properties
    
    private let networkService = NetworkService.shared
    
    private let jsonService = JSONService.shared
    
    // MARK: - Initializers
    
    private init() {}
    
    // MARK: - Public Properties
    
    public func searchImages(
        for searchText: String,
        completion: @escaping (Result<ImagesResults, Error>) -> Void
    ) {
        let parameters = prepareParameters(searchText: searchText)
        guard let url = getSearchUrl(parameters: parameters) else { return }
        networkService.getData(from: url) { [weak self] result in
            switch result {
            case .success(let data):
                guard let response = self?.jsonService.decodeJSON(type: ImagesResults.self, from: data) else { return }
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // MARK: - Private Properties
    
    private func prepareParameters(searchText: String) -> [String: String] {
        return [
            "q": searchText,
            "tbm": "isch",
            "api_key": ApiComponents.privateKey
        ]
    }
    
    private func getSearchUrl(parameters: [String: String]) -> URL? {
        var components = URLComponents()
        components.scheme = ApiComponents.scheme
        components.host = ApiComponents.host
        components.path = ApiComponents.endpoint
        components.queryItems = parameters.map {
            URLQueryItem(name: $0, value: $1)
        }
        return components.url
    }
}
