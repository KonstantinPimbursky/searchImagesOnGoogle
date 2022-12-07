//
//  ImagesCollectionModel.swift
//  SearchImagesOnGoogle
//
//  Created by Konstantin Pimbursky on 06.12.2022.
//

import UIKit

// MARK: - Models

protocol ImagesCollectionModel {
    var cells: [ImagesCollectionCellModel] { get }
}

struct ImagesCollectionCellModel: Hashable {
    let image: UIImage
}

// MARK: - Implementations

struct ImagesCollectionModelImpl: ImagesCollectionModel {
    var cells: [ImagesCollectionCellModel] = [
        ImagesCollectionCellModel(image: R.image.test1()!),
        ImagesCollectionCellModel(image: R.image.test2()!),
        ImagesCollectionCellModel(image: R.image.test3()!),
        ImagesCollectionCellModel(image: R.image.test4()!),
        ImagesCollectionCellModel(image: R.image.test5()!),
        ImagesCollectionCellModel(image: R.image.test6()!),
        ImagesCollectionCellModel(image: R.image.test7()!),
        ImagesCollectionCellModel(image: R.image.test8()!),
        ImagesCollectionCellModel(image: R.image.test9()!),
        ImagesCollectionCellModel(image: R.image.test10()!)
    ]
}
