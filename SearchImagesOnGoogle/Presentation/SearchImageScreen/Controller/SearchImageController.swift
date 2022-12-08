//
//  SearchImageController.swift
//  SearchImagesOnGoogle
//
//  Created by Konstantin Pimbursky on 05.12.2022.
//

import UIKit

final class SearchImageController: UIViewController {
    
    // MARK: - Types
    
    typealias DataSource = UICollectionViewDiffableDataSource<Section, SingleImageResult>
    typealias DataSourceSnapshot = NSDiffableDataSourceSnapshot<Section, SingleImageResult>
    
    enum Section {
        case main
    }
    
    // MARK: - Private Properties
    
    private lazy var mainView = SearchImageView(delegate: self)
    
    private let serverService = ApiService.shared
    
    private var searchResults = ImagesResults(results: [])
    
    private var dataSource: DataSource!
    private var snapshot: DataSourceSnapshot!
    
    private var timer: Timer?
    
    // MARK: - Life Cycle
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupImagesCollection()
        applySnapshot()
    }
    
    // MARK: - Private Methods
    
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
        serverService.searchImages(for: searchString) { [weak self] imagesResults in
            self?.searchResults = imagesResults
            self?.applySnapshot()
        }
    }
}

// MARK: - SearchImageViewDelegate

extension SearchImageController: SearchImageViewDelegate {
    func setupNavigationBar(searchBar: UISearchBar) {
        searchBar.delegate = self
        let searchItem = UIBarButtonItem(customView: searchBar)
        navigationItem.leftBarButtonItem = searchItem
    }
}

// MARK: - UICollectionViewDelegate

extension SearchImageController: UICollectionViewDelegate {
    
}

// MARK: - UISearchBarDelegate

extension SearchImageController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        timer?.invalidate()
//        timer = Timer.scheduledTimer(
//            withTimeInterval: 2,
//            repeats: false,
//            block: { [weak self] _ in
//                self?.fetchImages(for: searchText)
//            }
//        )
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text,
           !searchText.isEmpty {
            fetchImages(for: searchText)
        }
        searchBar.resignFirstResponder()
    }
}
