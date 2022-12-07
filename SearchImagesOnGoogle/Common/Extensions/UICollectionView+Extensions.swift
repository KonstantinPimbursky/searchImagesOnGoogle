//
//  UICollectionView+Extensions.swift
//  SearchImagesOnGoogle
//
//  Created by Konstantin Pimbursky on 06.12.2022.
//

import UIKit

// swiftlint:disable force_cast

extension UICollectionView {
    func register<T: UICollectionViewCell>(cell: T.Type) {
        register(T.self, forCellWithReuseIdentifier: T.identifier)
    }
    
    func dequeueCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as! T
    }
}
