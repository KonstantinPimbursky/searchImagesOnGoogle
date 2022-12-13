//
//  OneToolOptionsView.swift
//  SearchImagesOnGoogle
//
//  Created by Konstantin Pimbursky on 13.12.2022.
//

import UIKit

final class OneToolOptionsView: UIView {
    
    // MARK: - Public Properties
    
    public lazy var collection: UICollectionView = {
        let layout = createCollectionLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        return collection
    }()
    
    // MARK: - Private Properties
    
    private let applyButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerCurve = .continuous
        button.layer.cornerRadius = 8
        button.layer.borderColor = UIColor.white.withAlphaComponent(0.16).cgColor
        button.layer.borderWidth = 2
        return button
    }()
    
    // MARK: - Initializers
    
    init() {
        super.init(frame: .zero)
        addSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func createCollectionLayout() -> UICollectionViewCompositionalLayout {
        let itemWidth = NSCollectionLayoutDimension.fractionalWidth(1)
        let itemHeight = NSCollectionLayoutDimension.estimated(40)
        let itemSize = NSCollectionLayoutSize(widthDimension: itemWidth, heightDimension: itemHeight)
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: itemSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    private func addSubviews() {
        [collection, applyButton].forEach { addSubview($0) }
    }
    
    private func setConstraints() {
        collection.stretchFullOn(self)
        NSLayoutConstraint.activate([
            applyButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 56),
            applyButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -56),
            applyButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -16),
            applyButton.heightAnchor.constraint(equalToConstant: 36)
        ])
    }
}