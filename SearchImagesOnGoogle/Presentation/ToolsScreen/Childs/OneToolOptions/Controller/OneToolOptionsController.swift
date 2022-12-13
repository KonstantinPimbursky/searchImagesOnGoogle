//
//  OneToolOptionsController.swift
//  SearchImagesOnGoogle
//
//  Created by Konstantin Pimbursky on 13.12.2022.
//

import UIKit

final class OneToolOptionsController: UIViewController {
    
    // MARK: - Types
    
    typealias DataSource = UICollectionViewDiffableDataSource<Int, String>
    typealias DataSourceSnapshot = NSDiffableDataSourceSnapshot<Int, String>
    
    // MARK: - Private Properties
    
    private let mainView = OneToolOptionsView()
    
    private let model: [String]
    
    private var dataSource: DataSource!
    private var snapShot: DataSourceSnapshot!
    
    // MARK: - Initializers
    
    init(model: [String]) {
        self.model = model
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
        createDataSource()
        applySnapShot()
    }
    
    // MARK: - Private Methods
    
    private func createDataSource() {
        dataSource = DataSource(
            collectionView: mainView.collection,
            cellProvider: { collectionView, indexPath, item in
                let cell: OneToolOptionsCell = collectionView.dequeueCell(for: indexPath)
                cell.configure(title: item)
                return cell
            }
        )
    }
    
    private func applySnapShot() {
        snapShot = DataSourceSnapshot()
        snapShot.appendSections([0])
        snapShot.appendItems(model)
        dataSource.apply(snapShot, animatingDifferences: false)
    }
}
