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
        for searchParameters: SearchParameters,
        completion: @escaping (Result<ImagesResults, Error>) -> Void
    ) {
        let parameters = prepareParameters(searchParameters: searchParameters)
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

    private func prepareParameters(searchParameters: SearchParameters) -> [String: String] {
        var result = [String: String]()
        result["engine"] = "google"
        result["q"] = searchParameters.searchText
        result["google_domain"] = "google.com"
        result["tbm"] = "isch"
        result["ijn"] = "\(searchParameters.paginationPage)"
        if let country = searchParameters.country {
            result["gl"] = country.countryCode
        }
        if let language = searchParameters.language {
            result["hl"] = language.languageCode
        }
        if let imageSize = searchParameters.imageSize {
            result["tbs"] = imageSize.sizeCode
        }
        result["device"] = "mobile"
        result["api_key"] = ApiComponents.privateKey
        return result
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
