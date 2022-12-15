//
//  UIViewController+Extensions.swift
//  SearchImagesOnGoogle
//
//  Created by Konstantin Pimbursky on 10.12.2022.
//

import UIKit

extension UIViewController {
    /// Добавляет child-контроллер
    /// - Parameters:
    ///   - controller: контроллер, который необходимо добавить в качестве child
    ///   - rootView: view, в которую необходимо добавить контроллер в качестве child
    func addChild(controller: UIViewController, rootView: UIView) {
        addChild(controller)
        rootView.addSubview(controller.view)
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            controller.view.topAnchor.constraint(equalTo: rootView.topAnchor),
            controller.view.leadingAnchor.constraint(equalTo: rootView.leadingAnchor),
            controller.view.trailingAnchor.constraint(equalTo: rootView.trailingAnchor),
            controller.view.bottomAnchor.constraint(equalTo: rootView.bottomAnchor)
        ])
        controller.didMove(toParent: self)
    }
}
