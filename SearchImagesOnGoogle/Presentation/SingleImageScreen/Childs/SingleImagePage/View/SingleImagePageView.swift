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
    
    // MARK: - Initializers
    
    init() {
        super.init(frame: .zero)
        setupImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func setupImageView() {
        addSubview(imageView)
        imageView.stretchFullOn(self, withInsets: UIEdgeInsets(top: 0, left: 48, bottom: 0, right: 48))
    }
}
