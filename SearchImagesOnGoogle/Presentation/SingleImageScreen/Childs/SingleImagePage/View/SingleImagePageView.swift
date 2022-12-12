//
//  SingleImagePageView.swift
//  SearchImagesOnGoogle
//
//  Created by Konstantin Pimbursky on 10.12.2022.
//

import UIKit

final class SingleImagePageView: UIView {
    
    // MARK: - Public Properties
    
    public let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // MARK: - Private Properties
    
    private let activityIndicator: UIActivityIndicatorView = {
        let activityView = UIActivityIndicatorView()
        activityView.translatesAutoresizingMaskIntoConstraints = false
        return activityView
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
    
    private func addSubviews() {
        [
            activityIndicator,
            imageView
        ].forEach { addSubview($0) }
    }
    
    private func setConstraints() {
        imageView.stretchFullSafelyOn(self)
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: imageView.centerXAnchor)
        ])
    }
}
