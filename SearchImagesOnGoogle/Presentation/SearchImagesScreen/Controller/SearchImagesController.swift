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
    
    private let serverService = ApiService.shared
    
    private var searchResults = ImagesResults(results: [])
    
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
        navigationItem.title = R.string.localizable.searchTitle()
        setupImagesCollection()
        applySnapshot()
        addTestButton()
    }
    
    // MARK: - Private Methods
    
    private func addTestButton() {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .gray
        button.setTitle("test button", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.addTarget(self, action: #selector(testButtonAction), for: .touchUpInside)
        
        mainView.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: mainView.centerYAnchor),
            button.heightAnchor.constraint(equalToConstant: 50),
            button.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    @objc private func testButtonAction() {
        coordinator?.openSingleImageScreen(imagesResults: searchResults.results, selectedIndex: 1)
    }
    
    private func setupImagesCollection() {
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
        snapshot.appendItems(searchResults.results)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    private func fetchImages(for searchString: String) {
        serverService.searchImages(for: searchString) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let imagesResults):
                self.searchResults = imagesResults
                self.applySnapshot()
            case .failure(let error):
                self.showErrorAlert(for: error)
            }
        }
    }
    
    private func showErrorAlert(for error: Error) {
        coordinator?.showErrorAlert(message: error.localizedDescription)
    }
}

// MARK: - SearchImageViewDelegate

extension SearchImagesController: SearchImageViewDelegate {
    func setupNavigationBar(searchBar: UISearchBar) {
        searchBar.delegate = self
        let searchItem = UIBarButtonItem(customView: searchBar)
        navigationItem.leftBarButtonItem = searchItem
    }
}

// MARK: - UICollectionViewDelegate

extension SearchImagesController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        coordinator?.openSingleImageScreen(imagesResults: searchResults.results, selectedIndex: indexPath.item)
    }
}

// MARK: - UISearchBarDelegate

extension SearchImagesController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text,
           !searchText.isEmpty {
            fetchImages(for: searchText)
        }
        searchBar.resignFirstResponder()
    }
}