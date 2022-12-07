//
//  ImagesCollectionCell.swift
//  SearchImagesOnGoogle
//
//  Created by Konstantin Pimbursky on 06.12.2022.
//

import UIKit

final class ImagesCollectionCell: UICollectionViewCell {
    
    // MARK: - Private Properties
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerCurve = .continuous
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private var imageSize: CGSize = .zero
    
    private var heightConstraint = NSLayoutConstraint()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        heightConstraint.isActive = false
    }
    
    // MARK: - Public Methods
    
    public func configure(image: UIImage) {
        imageView.image = image
        imageSize = image.size
        setHeightConstraint()
    }
    
    // MARK: - Private Methods
    
    private func addSubviews() {
        contentView.addSubview(imageView)
    }
    
    private func setConstraints() {
        imageView.stretchFullOn(contentView)
    }
    
    private func setHeightConstraint() {
        let scale = imageSize.height / imageSize.width
        heightConstraint = imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: scale)
        heightConstraint.priority = UILayoutPriority(999)
        heightConstraint.isActive = true
    }
}
