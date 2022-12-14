//
//  SearchImagesController.swift
//  SearchImagesOnGoogle
//
//  Created by Konstantin Pimbursky on 05.12.2022.
//

import UIKit

final class SearchImagesController: UIViewController {
    
    // MARK: - Types
    
    typealias DataSource = UICollectionViewDiffableDataSource<Section, SingleImageResult>
    typealias DataSourceSnapshot = NSDiffableDataSourceSnapshot<Section, SingleImageResult>
    
    enum Section {
        case main
    }
    
    // MARK: - Private Properties
    
    private weak var coordinator: CoordinatorProtocol?
    
    private lazy var mainView = SearchImageView(delegate: self)
    
    private var model: SearchImagesModel = SearchImagesModelImpl()
    
    private var dataSource: DataSource!
    private var snapshot: DataSourceSnapshot!
    
    // MARK: - Initializers
    
    init(coordinator: CoordinatorProtocol?) {
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
        setupImagesCollection()
        applySnapshot()
        registerForKeyboardNotifications()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        removeKeyboardObservers()
    }
    
    // MARK: - Actions
    
    @objc private func kBWillShow(_ notification: Notification) {
        mainView.keyboard(isShown: true)
    }
    
    @objc private func kBWillHide() {
        mainView.keyboard(isShown: false)
    }
    
    // MARK: - Private Methods
    
    private func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(kBWillShow),
            name: UIResponder.keyboardWillShowNotification, object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(kBWillHide),
            name: UIResponder.keyboardWillHideNotification, object: nil
        )
    }
    
    private func removeKeyboardObservers() {
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    private func setupImagesCollection() {
        mainView.imagesCollection.prefetchDataSource = self
        mainView.imagesCollection.delegate = self
        createCollectionDataSource()
    }
    
    private func createCollectionDataSource() {
        dataSource = DataSource(
            collectionView: mainView.imagesCollection,
            cellProvider: { collectionView, indexPath, item in
                let cell: ImagesCollectionCell = collectionView.dequeueCell(for: indexPath)
                cell.configure(with: item.thumbnail)
                return cell
            }
        )
    }
    
    private func applySnapshot() {
        snapshot = DataSourceSnapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(model.searchResults)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    private func searchImages() {
        guard !model.searchParameters.searchText.isEmpty else { return }
        model.searchResults = []
        applySnapshot()
        mainView.startActivity(true)
        model.searchImages { [weak self] isSuccess, error in
            if isSuccess {
                self?.mainView.startActivity(false)
                self?.applySnapshot()
            } else if let error = error {
                self?.showErrorAlert(for: error)
            }
        }
    }
    
    private func fetchImages() {
        model.fetchNextPageOfImages { [weak self] isSuccess, error in
            if isSuccess {
                self?.applySnapshot()
            } else if let error = error {
                self?.showErrorAlert(for: error)
            }
        }
    }
    
    private func showErrorAlert(for error: Error) {
        coordinator?.showErrorAlert(message: error.localizedDescription)
    }
}

// MARK: - SearchImageViewDelegate

extension SearchImagesController: SearchImageViewDelegate {
    func setupNavigationBar(searchBar: SearchBarView) {
        searchBar.delegate = self
        navigationItem.titleView = searchBar
    }
}

// MARK: - SearchBarViewDelegate

extension SearchImagesController: SearchBarViewDelegate {
    func toolsButtonAction() {
        coordinator?.openToolsScreen(searchParameters: model.searchParameters, delegate: self)
    }
}

// MARK: - UICollectionViewDataSourcePrefetching

extension SearchImagesController: UICollectionViewDataSourcePrefetching {
    func collectionView(
        _ collectionView: UICollectionView,
        prefetchItemsAt indexPaths: [IndexPath]
    ) {
        if indexPaths.contains(where: { $0.item >= model.searchResults.count - 1 }) {
            fetchImages()
        }
    }
}

// MARK: - UICollectionViewDelegate

extension SearchImagesController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        coordinator?.openSingleImageScreen(imagesResults: model.searchResults, selectedIndex: indexPath.item)
    }
}

// MARK: - UISearchBarDelegate

extension SearchImagesController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text,
           !searchText.isEmpty {
            model.searchParameters.searchText = searchText
            searchImages()
        }
        searchBar.resignFirstResponder()
    }
}

// MARK: - ToolsScreenControllerDelegate

extension SearchImagesController: ToolsScreenControllerDelegate {
    func toolsApplied(searchParameters: SearchParameters) {
        model.searchParameters = searchParameters
        searchImages()
        coordinator?.closeToolsScreen()
    }
}
