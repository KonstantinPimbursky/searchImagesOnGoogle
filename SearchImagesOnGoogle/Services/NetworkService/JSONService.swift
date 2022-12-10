//
//  JSONService.swift
//  SearchImagesOnGoogle
//
//  Created by Konstantin Pimbursky on 07.12.2022.
//

import Foundation

final class JSONService {
    
    // MARK: - Public Properties
    
    public static let shared = JSONService()
    
    // MARK: - Initializers
    
    private init() {}
    
    // MARK: - Public Methods
    
    /// Декодирует JSON Data в объект Swift
    /// - Parameters:
    ///   - type: тип объекта Swift, в который необходимо декодировать JSON Data
    ///   - from: JSON Data, которую необходимо декодировать
    /// - Returns: объект Swift, полученный при декодировании
    func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = from else { return nil }
        
        do {
            let objects = try decoder.decode(type.self, from: data)
            return objects
        } catch let jsonError {
            print("Failed to decode JSON", jsonError)
            return nil
        }
    }
    
    /// Формирует JSON Data из объекта Swift
    /// - Parameter object: объект Swift , из которого необходимо получить JSON Data
    /// - Returns: JSON Data, полученная на основе объекта Swift
    func encode<T: Encodable>(object: T) -> Data? {
        let encoder = JSONEncoder()
        
        do {
            let jsonData = try encoder.encode(object)
            return jsonData
        } catch let jsonError {
            print("Failed to encode to JSON", jsonError)
            return nil
        }
    }
}
