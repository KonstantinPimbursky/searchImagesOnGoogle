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
    
    private var dataSource: DataSource!
    private var snapShot: DataSourceSnapshot!
    
    // MARK: - Life Cycle
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createDataSource()
    }
    
    // MARK: - Private Methods
    
    private func createDataSource() {
        dataSource = DataSource(
            collectionView: mainView.collection,
            cellProvider: { collectionView, indexPath, item in
                <#code#>
            }
        )
    }
    
    private func applySnapShot() {
        
    }
}
