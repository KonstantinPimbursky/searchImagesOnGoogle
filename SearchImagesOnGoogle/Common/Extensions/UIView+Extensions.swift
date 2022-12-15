//
//  UIView+Extensions.swift
//  SearchImagesOnGoogle
//
//  Created by Konstantin Pimbursky on 06.12.2022.
//

import UIKit

extension UIView {
    static var identifier: String {
        return String(describing: self)
    }
}

// MARK: - Fast Constrains

extension UIView {
    /// Устанавливает констрейнты по краям целевой вью.
    /// - Parameter view: Целевая вью, по краям которой нужно установить констрейнты.
    func stretchFullOn(_ view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: view.topAnchor),
            leadingAnchor.constraint(equalTo: view.leadingAnchor),
            trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    /// Устанавливает констрейнты по краям целевой вью с отступом от каждого края.
    /// - Parameters:
    ///   - view: Целевая вью, по краям которой нужно установить констрейнты.
    ///   - insets: Величина отступов от краёв целевой вью.
    func stretchFullOn(_ view: UIView, withInsets insets: UIEdgeInsets) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: view.topAnchor, constant: insets.top),
            leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: insets.left),
            trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -insets.right),
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -insets.bottom)
        ])
    }
    
    /// Устанавливает констрейнты по краям целевой вью с учётом SafeArea.
    /// - Parameter view: Целевая вью, по краям которой нужно установить констрейнты.
    func stretchFullSafelyOn(_ view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
