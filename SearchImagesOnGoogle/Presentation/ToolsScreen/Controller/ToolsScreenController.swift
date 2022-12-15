//
//  ToolsScreenController.swift
//  SearchImagesOnGoogle
//
//  Created by Konstantin Pimbursky on 11.12.2022.
//

import UIKit

protocol ToolsScreenControllerDelegate: AnyObject {
    func toolsApplied(searchParameters: SearchParameters)
}

final class ToolsScreenController: UIViewController {
    
    // MARK: - Private Properties
    
    private weak var delegate: ToolsScreenControllerDelegate?
    
    private lazy var mainView = ToolsScreenView(delegate: self)
    
    private let jsonService = JSONService.shared
    
    private var toolsModel: ToolsTableModel = ToolsTableModelImpl()
    private var googleCountries = GoogleCountries(countries: [])
    private var googleLanguages = GoogleLanguages(languages: [])
    private let googleImageSizes = GoogleImageSize.allCases
    
    private var searchParameters: SearchParameters
    
    private var selectedImageSizeIndex: Int?
    private var selectedCountryIndex: Int?
    private var selectedLanguageIndex: Int?
    
    private let pageController = UIPageViewController(
        transitionStyle: .scroll,
        navigationOrientation: .horizontal
    )
    
    private lazy var toolsController = ToolsTable(model: toolsModel, delegate: self)
    
    private var oneToolOptionsController: OneToolOptionsController?
    
    // MARK: - Initializers
    
    init(
        searchParameters: SearchParameters,
        delegate: ToolsScreenControllerDelegate?
    ) {
        self.searchParameters = searchParameters
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getGoogleCountries()
        getGoogleLanguages()
        setupToolsModel()
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
        pageController.setViewControllers([toolsController], direction: .forward, animated: false)
    }
    
    private func setupToolsModel() {
        for (index, tool) in toolsModel.cells.enumerated() {
            switch tool.type {
            case .size:
                toolsModel.cells[index].subtitles = [searchParameters.imageSize?.sizeName ?? ""]
            case .language:
                toolsModel.cells[index].subtitles = [searchParameters.language?.languageName ?? ""]
            case .country:
                toolsModel.cells[index].subtitles = [searchParameters.country?.countryName ?? ""]
            }
        }
    }
}

// MARK: - ToolsScreenViewDelegate

extension ToolsScreenController: ToolsScreenViewDelegate {
    func backButtonAction() {
        toolsController.reloadTable(model: toolsModel)
        mainView.changeTitle(type: .tools)
        pageController.setViewControllers([toolsController], direction: .reverse, animated: true)
    }
    
    func resetButtonAction() {
        oneToolOptionsController?.resetSelection()
    }
}

// MARK: - ToolsTableDelegate

extension ToolsScreenController: ToolsTableDelegate {
    func toolsTable(didSelectItemAt indexPath: IndexPath) {
        switch toolsModel.cell(at: indexPath).type {
        case .size:
            mainView.changeTitle(type: .size)
            let sizes = googleImageSizes.map { $0.sizeName }
            let sizeTool = OneToolOptionsController(
                model: sizes,
                selectedIndex: selectedImageSizeIndex,
                delegate: self
            )
            oneToolOptionsController = sizeTool
            pageController.setViewControllers([sizeTool], direction: .forward, animated: true)
        case .country:
            mainView.changeTitle(type: .country)
            let countries = googleCountries.countries.map { $0.countryName }
            let countryTool = OneToolOptionsController(
                model: countries,
                selectedIndex: selectedCountryIndex,
                delegate: self
            )
            oneToolOptionsController = countryTool
            pageController.setViewControllers([countryTool], direction: .forward, animated: true)
        case .language:
            mainView.changeTitle(type: .language)
            let languages = googleLanguages.languages.map { $0.languageName }
            let languageTool = OneToolOptionsController(
                model: languages,
                selectedIndex: selectedLanguageIndex,
                delegate: self
            )
            oneToolOptionsController = languageTool
            pageController.setViewControllers([languageTool], direction: .forward, animated: true)
        }
    }
    
    func toolsTableApplied() {
        delegate?.toolsApplied(searchParameters: searchParameters)
    }
}

// MARK: - OneToolOptionsControllerDelegate

extension ToolsScreenController: OneToolOptionsControllerDelegate {
    func oneToolOptions(applied selectedIndexPaths: [IndexPath]?) {
        if let selectedIndex = selectedIndexPaths?.last?.item {
            switch mainView.currentTitleType {
            case .tools:
                break
            case .language:
                searchParameters.language = googleLanguages.languages[selectedIndex]
                selectedLanguageIndex = selectedIndex
            case .country:
                searchParameters.country = googleCountries.countries[selectedIndex]
                selectedCountryIndex = selectedIndex
            case .size:
                searchParameters.imageSize = googleImageSizes[selectedIndex]
                selectedImageSizeIndex = selectedIndex
            }
        } else {
            switch mainView.currentTitleType {
            case .tools:
                break
            case .language:
                searchParameters.language = nil
                selectedLanguageIndex = nil
            case .country:
                searchParameters.country = nil
                selectedCountryIndex = nil
            case .size:
                searchParameters.imageSize = nil
                selectedImageSizeIndex = nil
            }
        }
        setupToolsModel()
        backButtonAction()
    }
}
