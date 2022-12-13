//
//  ToolOptionsView.swift
//  SearchImagesOnGoogle
//
//  Created by Konstantin Pimbursky on 12.12.2022.
//

import UIKit

final class ToolOptionsView: UIView {
    
    // MARK: - Public Properties
    
    public lazy var table: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(cell: ToolsTableCell.self)
        tableView.rowHeight = 56
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        tableView.isScrollEnabled = false
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    // MARK: - Private Properties
    
    private let applyButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerCurve = .continuous
        button.layer.cornerRadius = 8
        button.layer.borderColor = R.color.purple()?.cgColor
        button.layer.borderWidth = 2
        button.backgroundColor = R.color.buttonColor()
        button.setTitle(R.string.localizable.apply(), for: .normal)
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
        [table, applyButton].forEach { addSubview($0) }
    }
    
    private func setConstraints() {
        table.stretchFullOn(self)
        NSLayoutConstraint.activate([
            applyButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 56),
            applyButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -56),
            applyButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -16),
            applyButton.heightAnchor.constraint(equalToConstant: 36)
        ])
    }
}
