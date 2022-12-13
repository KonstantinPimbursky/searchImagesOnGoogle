//
//  OneToolOptionsCell.swift
//  SearchImagesOnGoogle
//
//  Created by Konstantin Pimbursky on 13.12.2022.
//

import UIKit

final class OneToolOptionsCell: UICollectionViewCell {
    
    // MARK: - Public Properties
    
    override var isSelected: Bool {
        didSet {
            selectionView.isSelected = isSelected
        }
    }
    
    // MARK: - Private Properties
    
    private let selectionView = SelectionView()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .left
        return label
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white.withAlphaComponent(0.4)
        return view
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        addSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    public func configure(title: String) {
        titleLabel.text = title
    }
    
    // MARK: - Private Methods
    
    private func addSubviews() {
        [selectionView, titleLabel, separatorView].forEach { contentView.addSubview($0) }
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            selectionView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            selectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: selectionView.trailingAnchor, constant: 16),
            
            separatorView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            separatorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
}
