//
//  SearchImageView.swift
//  SearchImagesOnGoogle
//
//  Created by Konstantin Pimbursky on 05.12.2022.
//

import UIKit

protocol SearchImageViewDelegate: AnyObject {
    func setupNavigationBar(searchBar: SearchBarView)
}

final class SearchImageView: UIView {
    
    // MARK: - Public Properties
    
    public lazy var imagesCollection: UICollectionView = {
        let layout = createCollectionLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .clear
        collection.register(cell: ImagesCollectionCell.self)
        return collection
    }()
    
    // MARK: - Private Properties
    
    private weak var delegate: SearchImageViewDelegate?
    
    private let searchBar = SearchBarView()
    
    private lazy var tapView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTap))
        view.addGestureRecognizer(tapGesture)
        view.isHidden = true
        return view
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .large)
        activity.translatesAutoresizingMaskIntoConstraints = false
        return activity
    }()
    
    // MARK: - Initializers
    
    init(delegate: SearchImageViewDelegate?) {
        self.delegate = delegate
        super.init(frame: .zero)
        backgroundColor = R.color.backgroundColor()
        addSubviews()
        setConstraints()
        setupNavigationBar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    /// Добавляет вью для распознавания тапа, чтобы закрыть клавиатуру по тапу на свободном месте
    /// - Parameter isShown: флаг, отображается ли клавиатура на экране
    public func keyboard(isShown: Bool) {
        tapView.isHidden = !isShown
    }
    
    public func startActivity(_ isActive: Bool) {
        // swiftlint:disable:next void_function_in_ternary
        isActive ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
    }
    
    // MARK: - Actions
    
    @objc private func didTap() {
        searchBar.resignFirstResponder()
    }
    
    // MARK: - Private Methods
    
    private func createCollectionLayout() -> UICollectionViewCompositionalLayout {
        let itemWidth = NSCollectionLayoutDimension.fractionalWidth(0.5)
        let itemHeight = NSCollectionLayoutDimension.fractionalWidth(0.5)
        let itemSize = NSCollectionLayoutSize(widthDimension: itemWidth, heightDimension: itemHeight)
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupWidth = NSCollectionLayoutDimension.fractionalWidth(1)
        let groupHeight = NSCollectionLayoutDimension.fractionalWidth(0.5)
        let groupSize = NSCollectionLayoutSize(widthDimension: groupWidth, heightDimension: groupHeight)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)

        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    private func addSubviews() {
        [activityIndicator, imagesCollection, tapView].forEach { addSubview($0) }
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        imagesCollection.stretchFullOn(self)
        tapView.stretchFullOn(self)
    }
    
    private func setupNavigationBar() {
        delegate?.setupNavigationBar(searchBar: searchBar)
    }
}
