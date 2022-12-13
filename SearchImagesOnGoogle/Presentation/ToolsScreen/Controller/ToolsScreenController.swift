//
//  ToolsScreenController.swift
//  SearchImagesOnGoogle
//
//  Created by Konstantin Pimbursky on 11.12.2022.
//

import UIKit

final class ToolsScreenController: UIViewController {
    
    // MARK: - Private Properties
    
    private lazy var mainView = ToolsScreenView(delegate: self)
    
    private let jsonService = JSONService.shared
    
    private let toolsModel: ToolsTableModel = ToolsTableModelImpl()
    
    private var googleCountries = GoogleCountries(countries: [])
    
    private var googleLanguages = GoogleLanguages(languages: [])
    
    private let pageController = UIPageViewController(
        transitionStyle: .scroll,
        navigationOrientation: .horizontal
    )
    
    private lazy var toolOptionsController = ToolsTable(model: toolsModel, delegate: self)
    
    // MARK: - Life Cycle
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getGoogleCountries()
        getGoogleLanguages()
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
    
    private func getGoogleLanguages() {
        guard
            let filePath = Bundle.main.path(forResource: "GoogleLanguages", ofType: "json"),
            let fileData = FileManager.default.contents(atPath: filePath),
            let languages = jsonService.decodeJSON(type: GoogleLanguages.self, from: fileData)
        else { return }
        googleLanguages = languages
    }
    
    private func setupPageController() {
        addChild(controller: pageController, rootView: mainView.pageContainer)
        pageController.setViewControllers([toolOptionsController], direction: .forward, animated: false)
    }
}

// MARK: - ToolsScreenViewDelegate

extension ToolsScreenController: ToolsScreenViewDelegate {
    func backButtonAction() {
        mainView.changeTitle(type: .tools)
        pageController.setViewControllers([toolOptionsController], direction: .reverse, animated: true)
    }
}

// MARK: - ToolsTableDelegate

extension ToolsScreenController: ToolsTableDelegate {
    func toolsTable(didSelectItemAt indexPath: IndexPath) {
        switch toolsModel.cell(at: indexPath).type {
        case .size:
            print("Size")
        case .country:
            mainView.changeTitle(type: .country)
            let countries = googleCountries.countries.map { $0.countryName }
            let countryTool = OneToolOptionsController(model: countries)
            pageController.setViewControllers([countryTool], direction: .forward, animated: true)
        case .language:
            mainView.changeTitle(type: .language)
            let languages = googleLanguages.languages.map { $0.languageName }
            let languageTool = OneToolOptionsController(model: languages)
            pageController.setViewControllers([languageTool], direction: .forward, animated: true)
        }
    }
}
