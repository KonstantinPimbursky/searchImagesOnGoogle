//
//  NetworkService.swift
//  SearchImagesOnGoogle
//
//  Created by Konstantin Pimbursky on 07.12.2022.
//

import Foundation

final class NetworkService {
    
    // MARK: - Types
    
    typealias CompletionHandler = (Result<Data, Error>) -> Void
    
    // MARK: - Public Properties
    
    public static let shared = NetworkService()
    
    // MARK: - Initializers
    
    private init() {}
    
    // MARK: - Public Methods
    
    /// GET запрос на сервер
    /// - Parameters:
    ///   - url: URL, по которому необходимо направить запрос
    ///   - completion: замыкание, которое вызывается при получении ответа от сервера на отправленный запрос
    public func getData(from url: URL, completion: @escaping CompletionHandler) {
        var request = URLRequest(url: url)
        request.httpMethod = "get"
        let task = createDataTask(with: request, completion: completion)
        DispatchQueue.global(qos: .userInitiated).async {
            task.resume()
        }
    }
    
    // MARK: - Private Methods
    
    private func createDataTask(
        with request: URLRequest,
        completion: @escaping CompletionHandler
    ) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { data, _, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                } else if let data = data {
                    completion(.success(data))
                }
            }
        }
    }
}
