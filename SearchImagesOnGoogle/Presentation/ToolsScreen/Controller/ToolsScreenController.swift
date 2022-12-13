//
//  ToolsScreenController.swift
//  SearchImagesOnGoogle
//
//  Created by Konstantin Pimbursky on 11.12.2022.
//

import UIKit

final class ToolsScreenController: UIViewController {
    
    // MARK: - Private Properties
    
    private let mainView = ToolsScreenView()
    
    private let jsonService = JSONService.shared
    
    private var googleCountries = GoogleCountries(countries: [])
    
    private let pageController = UIPageViewController(
        transitionStyle: .scroll,
        navigationOrientation: .horizontal
    )
    
    private let toolOptionsController = ToolsTable()
    
    // MARK: - Life Cycle
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getGoogleCountries()
        setupPageController()
    }
    
    // MARK: - Private Methods
    
    private func getGoogleCountries() {
        guard
            let filePath = Bundle.main.path(forResource: "GoogleCountries", ofType: "json"),
            let fileData = FileManager.default.contents(atPath: filePath),
            let countries = jsonService.decodeJSON(type: GoogleCountries.self, from: fileData)
        else { return }
        googleCountries = countries
    }
    
    private func setupPageController() {
        addChild(controller: pageController, rootView: mainView.pageContainer)
        pageController.setViewControllers([toolOptionsController], direction: .forward, animated: false)
    }
}
