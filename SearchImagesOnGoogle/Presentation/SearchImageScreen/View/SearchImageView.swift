//
//  SearchImageView.swift
//  SearchImagesOnGoogle
//
//  Created by Konstantin Pimbursky on 05.12.2022.
//

import UIKit

protocol SearchImageViewDelegate: AnyObject {
    func setupNavigationBar(searchBar: UISearchBar)
}

final class SearchImageView: UIView {
    
    // MARK: - Constants
    
    private enum Constants {
        static let spacing: CGFloat = 16
        static let itemWidth: CGFloat = (UIScreen.main.bounds.width - spacing * 3) / 2
        static let itemHeight: CGFloat = itemWidth
    }
    
    // MARK: - Public Properties
    
    public lazy var imagesCollection: UICollectionView = {
        let layout = createCollectionLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(cell: ImagesCollectionCell.self)
        return collection
    }()
    
    // MARK: - Private Properties
    
    private weak var delegate: SearchImageViewDelegate?
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar(
            frame: CGRect(
                origin: CGPoint(x: 0, y: 0),
                size: CGSize(width: UIScreen.main.bounds.width - 2 * 16, height: 20)
            )
        )
        searchBar.placeholder = R.string.localizable.searchPlaceholder()
        return searchBar
    }()
    
    // MARK: - Initializers
    
    init(delegate: SearchImageViewDelegate?) {
        self.delegate = delegate
        super.init(frame: .zero)
        backgroundColor = .white
        addSubviews()
        setConstraints()
        setupNavigationBar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func createCollectionLayout() -> UICollectionViewCompositionalLayout {
        let itemWidth = NSCollectionLayoutDimension.absolute(Constants.itemWidth)
        let itemHeight = NSCollectionLayoutDimension.estimated(50)
        let itemSize = NSCollectionLayoutSize(widthDimension: itemWidth, heightDimension: itemHeight)
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupWidth = NSCollectionLayoutDimension.fractionalWidth(1)
        let groupHeight = NSCollectionLayoutDimension.estimated(50)
        let groupSize = NSCollectionLayoutSize(widthDimension: groupWidth, heightDimension: groupHeight)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        group.interItemSpacing = .fixed(Constants.spacing)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = Constants.spacing
        section.contentInsets = NSDirectionalEdgeInsets(
            top: Constants.spacing,
            leading: Constants.spacing,
            bottom: Constants.spacing,
            trailing: Constants.spacing
        )

        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    private func addSubviews() {
        addSubview(imagesCollection)
    }
    
    private func setConstraints() {
        imagesCollection.stretchFullSafelyOn(self)
    }
    
    private func setupNavigationBar() {
        delegate?.setupNavigationBar(searchBar: searchBar)
    }
}
