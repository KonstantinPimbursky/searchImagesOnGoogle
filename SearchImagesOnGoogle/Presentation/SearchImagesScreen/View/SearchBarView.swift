//
//  SearchBarView.swift
//  SearchImagesOnGoogle
//
//  Created by Konstantin Pimbursky on 12.12.2022.
//

import UIKit

typealias SearchBarDelegate = UISearchBarDelegate & SearchBarViewDelegate

protocol SearchBarViewDelegate: AnyObject {
    func toolsButtonAction()
}

final class SearchBarView: UIView {
    
    // MARK: - Public Properties
    
    override var intrinsicContentSize: CGSize {
        CGSize(width: UIScreen.main.bounds.width - 2 * 16, height: 48)
    }
    
    public weak var delegate: SearchBarDelegate? {
        didSet {
            searchBar.delegate = delegate
        }
    }
    
    // MARK: - Private Properties
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = R.string.localizable.search()
        return searchBar
    }()
    
    private lazy var toolsButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(R.image.filterIcon(), for: .normal)
        button.tintColor = .white.withAlphaComponent(0.4)
        button.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
        button.addTarget(self, action: #selector(toolsButtonAction), for: .touchUpInside)
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
    
    // MARK: - Actions
    
    @objc private func toolsButtonAction() {
        delegate?.toolsButtonAction()
    }
    
    // MARK: - Private Methods
    
    private func addSubviews() {
        [searchBar, toolsButton].forEach { addSubview($0) }
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            toolsButton.topAnchor.constraint(equalTo: topAnchor),
            toolsButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            toolsButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            toolsButton.widthAnchor.constraint(equalTo: toolsButton.heightAnchor),
            
            searchBar.topAnchor.constraint(equalTo: topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            searchBar.bottomAnchor.constraint(equalTo: bottomAnchor),
            searchBar.trailingAnchor.constraint(equalTo: toolsButton.leadingAnchor, constant: -16)
        ])
    }
}
