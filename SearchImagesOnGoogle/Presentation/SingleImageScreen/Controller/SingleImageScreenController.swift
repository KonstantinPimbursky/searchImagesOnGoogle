//
//  SingleImageScreenController.swift
//  SearchImagesOnGoogle
//
//  Created by Konstantin Pimbursky on 09.12.2022.
//

import UIKit

protocol SingleImagePageProtocol: UIViewController {
    var imageIndex: Int { get }
}

final class SingleImageScreenController: UIViewController {
    
    // MARK: - Private Properties
    
    private weak var coordinator: CoordinatorProtocol?
    
    private lazy var mainView = SingleImageScreenView(delegate: self)
    
    private let imagesResults: [SingleImageResult]
    
    private let selectedIndex: Int
    
    private let pageController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
    
    private var currentPageNumber: Int {
        didSet {
            checkPreviousNextButtonsActivation()
        }
    }
    
    // MARK: - Initializers
    
    init(
        imagesResults: [SingleImageResult],
        selectedIndex: Int,
        coordinator: CoordinatorProtocol?
    ) {
        self.imagesResults = imagesResults
        self.selectedIndex = selectedIndex
        self.currentPageNumber = selectedIndex
        self.coordinator = coordinator
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
        navigationItem.backButtonDisplayMode = .minimal
        setupPageController()
    }
    
    // MARK: - Private Methods
    
    private func setupPageController() {
        pageController.dataSource = self
        
        let page = SingleImagePageController(
            imageIndex: selectedIndex,
            image: imagesResults[selectedIndex],
            coordinator: coordinator
        )
        pageController.setViewControllers([page], direction: .forward, animated: false)
        addChild(controller: pageController, rootView: mainView.pageContainer)
    }
    
    private func checkPreviousNextButtonsActivation() {
        mainView.previousButton(isActive: currentPageNumber > 0)
        mainView.nextButton(isActive: currentPageNumber < imagesResults.count - 1)
    }
    
    private func previousPage(for index: Int) -> UIViewController? {
        guard index > 0 else { return nil }
        
        currentPageNumber = index - 1
        let newPage = SingleImagePageController(
            imageIndex: currentPageNumber,
            image: imagesResults[currentPageNumber],
            coordinator: coordinator
        )
        
        return newPage
    }
    
    private func nextPage(for index: Int) -> UIViewController? {
        guard index < imagesResults.count - 1 else { return nil }
        
        currentPageNumber = index + 1
        let newPage = SingleImagePageController(
            imageIndex: currentPageNumber,
            image: imagesResults[currentPageNumber],
            coordinator: coordinator
        )
        
        return newPage
    }
}

// MARK: - SingleImageScreenViewDelegate

extension SingleImageScreenController: SingleImageScreenViewDelegate {
    func previousButtonAction() {
        guard let previousPage = previousPage(for: currentPageNumber) else { return }
        pageController.setViewControllers([previousPage], direction: .reverse, animated: true)
    }
    
    func nextButtonAction() {
        guard let nextPage = nextPage(for: currentPageNumber) else { return }
        pageController.setViewControllers([nextPage], direction: .forward, animated: true)
    }
    
    func openSourcePageButtonAction() {
        coordinator?.openWebScreen(urlString: imagesResults[currentPageNumber].link)
    }
}

// MARK: - UIPageViewControllerDataSource

extension SingleImageScreenController: UIPageViewControllerDataSource {
    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerBefore viewController: UIViewController
    ) -> UIViewController? {
        guard let page = viewController as? SingleImagePageProtocol else { return nil }
        return previousPage(for: page.imageIndex)
    }
    
    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerAfter viewController: UIViewController
    ) -> UIViewController? {
        guard let page = viewController as? SingleImagePageProtocol else { return nil }
        return nextPage(for: page.imageIndex)
    }
}
