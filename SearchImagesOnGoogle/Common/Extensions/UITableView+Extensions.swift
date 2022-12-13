//
//  UITableView+Extensions.swift
//  SearchImagesOnGoogle
//
//  Created by Konstantin Pimbursky on 13.12.2022.
//

import UIKit

// swiftlint:disable force_cast

extension UITableView {
    func register<T: UITableViewCell>(cell: T.Type) {
        register(T.self, forCellReuseIdentifier: T.identifier)
    }
    
    func dequeueCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as! T
    }
}
