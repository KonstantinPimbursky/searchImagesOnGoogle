//
//  AppDelegate.swift
//  SearchImagesOnGoogle
//
//  Created by Konstantin Pimbursky on 05.12.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: - Public Properties
    
    var window: UIWindow?
    var coordinator: Coordinator?
    
    // MARK: - Public Methods

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let navigationController = createNavigationController()
        coordinator = Coordinator(navigationController: navigationController)
        let searchController = SearchImagesController(coordinator: coordinator)
        navigationController.viewControllers = [searchController]
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        window?.overrideUserInterfaceStyle = .dark
        return true
    }
    
    // MARK: - Private Methods
    
    private func createNavigationController() -> UINavigationController {
        let navigationController = UINavigationController()
        navigationController.navigationBar.tintColor = .systemGray2
        return navigationController
    }
}
