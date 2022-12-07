//
//  SearchImageController.swift
//  SearchImagesOnGoogle
//
//  Created by Konstantin Pimbursky on 05.12.2022.
//

import UIKit

final class SearchImageController: UIViewController {
    
    // MARK: - Types
    
    typealias DataSource = UICollectionViewDiffableDataSource<Section, ImagesCollectionCellModel>
    typealias DataSourceSnapshot = NSDiffableDataSourceSnapshot<Section, ImagesCollectionCellModel>
    
    enum Section {
        case main
    }
    
    // MARK: - Private Properties
    
    private lazy var mainView = SearchImageView(delegate: self)
    
    private let collectionModel: ImagesCollectionModel = ImagesCollectionModelImpl()
    
    private var dataSource: DataSource!
    private var snapshot: DataSourceSnapshot!
    
    // MARK: - Life Cycle
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupImagesCollection()
        applySnapshot(items: collectionModel.cells)
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
                cell.configure(image: item.image)
                return cell
            }
        )
    }
    
    private func applySnapshot(items: [ImagesCollectionCellModel]) {
        snapshot = DataSourceSnapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(items)
        dataSource.apply(snapshot, animatingDifferences: true)
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

// MARK: -

extension SearchImageController: UISearchBarDelegate {
    
}
