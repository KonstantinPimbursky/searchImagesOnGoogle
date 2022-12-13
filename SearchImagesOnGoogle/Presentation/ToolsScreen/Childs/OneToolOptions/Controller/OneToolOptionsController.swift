//
//  OneToolOptionsController.swift
//  SearchImagesOnGoogle
//
//  Created by Konstantin Pimbursky on 13.12.2022.
//

import UIKit

protocol OneToolOptionsControllerDelegate: AnyObject {
    func oneToolOptions(applied selectedIndexPaths: [IndexPath]?)
}

final class OneToolOptionsController: UIViewController {
    
    // MARK: - Types
    
    typealias DataSource = UICollectionViewDiffableDataSource<Int, String>
    typealias DataSourceSnapshot = NSDiffableDataSourceSnapshot<Int, String>
    
    // MARK: - Private Properties
    
    private weak var delegate: OneToolOptionsControllerDelegate?
    
    private lazy var mainView = OneToolOptionsView(delegate: self)
    
    private let model: [String]
    
    private var initialSelectedIndex: Int?
    
    private var dataSource: DataSource!
    private var snapShot: DataSourceSnapshot!
    
    // MARK: - Initializers
    
    init(model: [String], selectedIndex: Int?, delegate: OneToolOptionsControllerDelegate?) {
        self.model = model
        self.initialSelectedIndex = selectedIndex
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
        createDataSource()
        applySnapShot()
        selectItem()
    }
    
    // MARK: - Public Methods
    
    public func resetSelection() {
        guard let selectedIndexPaths = mainView.collection.indexPathsForSelectedItems else { return }
        selectedIndexPaths.forEach { mainView.collection.deselectItem(at: $0, animated: true) }
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
    
    private func selectItem() {
        guard let index = initialSelectedIndex else { return }
        mainView.collection.selectItem(at: IndexPath(item: index, section: 0), animated: false, scrollPosition: .top)
    }
}

// MARK: - OneToolOptionsViewDelegate

extension OneToolOptionsController: OneToolOptionsViewDelegate {
    func applyButtonAction() {
        delegate?.oneToolOptions(applied: mainView.collection.indexPathsForSelectedItems)
    }
}
