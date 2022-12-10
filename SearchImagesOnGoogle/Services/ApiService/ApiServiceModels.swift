//
//  ApiServiceModels.swift
//  SearchImagesOnGoogle
//
//  Created by Konstantin Pimbursky on 07.12.2022.
//

import Foundation

struct ApiComponents {
    static let scheme = "https"
    static let host = "serpapi.com"
    static let endpoint = "/search"
    static let privateKey = "23c8d1f8c626a73431cc5c8716e8c21c7056ad11d059936d40efea8bdc8acb62"
}

struct ImagesResults: Codable {
    
    enum CodingKeys: String, CodingKey {
        case results = "images_results"
    }
    
    let results: [SingleImageResult]
}

struct SingleImageResult: Codable, Hashable {
    /// Image index
    let position: Int
    /// Google Thumbnail URL (cache)
    let thumbnail: String
    /// Original Image URL (full resolution)
    let original: String
    /// Link to the page providing the image
    let link: String
}
