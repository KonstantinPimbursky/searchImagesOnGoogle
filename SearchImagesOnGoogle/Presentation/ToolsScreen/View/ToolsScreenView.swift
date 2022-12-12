//
//  ToolsScreenView.swift
//  SearchImagesOnGoogle
//
//  Created by Konstantin Pimbursky on 11.12.2022.
//

import UIKit

final class ToolsScreenView: UIView {
    
    // MARK: - Private Properties
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .white
        label.text = R.string.localizable.tools()
        return label
    }()
    
    // MARK: - Initializers
    
    init() {
        super.init(frame: .zero)
        backgroundColor = R.color.backgroundColor()
        addSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func addSubviews() {
        addSubview(titleLabel)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
