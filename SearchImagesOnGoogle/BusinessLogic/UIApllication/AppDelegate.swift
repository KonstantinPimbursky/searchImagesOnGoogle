//
//  AppDelegate.swift
//  SearchImagesOnGoogle
//
//  Created by Konstantin Pimbursky on 05.12.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var coordinator: Coordinator?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let navigationController = UINavigationController()
        coordinator = Coordinator(navigationController: navigationController)
        let searchController = SearchImageController(coordinator: coordinator)
        navigationController.viewControllers = [searchController]
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }
}
