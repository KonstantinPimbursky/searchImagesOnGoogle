//
//  Coordinator.swift
//  SearchImagesOnGoogle
//
//  Created by Konstantin Pimbursky on 09.12.2022.
//

import UIKit

final class Coordinator: CoordinatorProtocol {
    
    // MARK: - Public Properties
    
    public var navigationController: UINavigationController
    
    // MARK: - Initializers
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Public Methods
    
    public func showErrorAlert(
        message: String
    ) {
        let alert = UIAlertController(
            title: R.string.localizable.error(),
            message: message,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        presentController(controller: alert, animated: true)
    }
    
    public func openToolsScreen(searchParameters: SearchParameters, delegate: ToolsScreenControllerDelegate?) {
        let toolsScreen = ToolsScreenController(searchParameters: searchParameters, delegate: delegate)
        presentController(controller: toolsScreen, animated: true)
    }
    
    public func closeToolsScreen() {
        dismissController(animated: true)
    }
    
    public func openSingleImageScreen(imagesResults: [SingleImageResult], selectedIndex: Int) {
        let singleImageScreen = SingleImageScreenController(
            imagesResults: imagesResults,
            selectedIndex: selectedIndex,
            coordinator: self
        )
        pushController(controller: singleImageScreen, animated: true)
    }
    
    public func openWebScreen(urlString: String) {
        let webScreenController = WebScreenController(urlString: urlString)
        pushController(controller: webScreenController, animated: true)
    }
    
    // MARK: - Private Methods
    
    private func pushController(
        controller: UIViewController,
        animated: Bool
    ) {
        navigationController.pushViewController(controller, animated: animated)
    }
    
    private func popController(
        animated: Bool,
        hideNavBar: Bool = false
    ) {
        navigationController.popViewController(animated: animated)
        navigationController.navigationBar.isHidden = hideNavBar
    }
    
    private func presentController(
        controller: UIViewController,
        animated: Bool,
        completion: (() -> Void)? = nil
    ) {
        navigationController.present(controller, animated: animated, completion: completion)
    }
    
    private func dismissController(
        animated: Bool,
        completion: (() -> Void)? = nil
    ) {
        navigationController.dismiss(animated: animated, completion: completion)
    }
}
