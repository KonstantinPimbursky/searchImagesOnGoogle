//
//  ImagesCollectionCell.swift
//  SearchImagesOnGoogle
//
//  Created by Konstantin Pimbursky on 06.12.2022.
//

import SDWebImage
import UIKit

final class ImagesCollectionCell: UICollectionViewCell {
    
    // MARK: - Private Properties
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
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
    
    public func configure(with imageURL: String) {
        guard let url = URL(string: imageURL) else { return }
        imageView.sd_imageIndicator = SDWebImageActivityIndicator.medium
        imageView.sd_setImage(with: url, completed: nil)
    }
    
    public func configure(image: UIImage) {
        imageView.image = image
    }
    
    // MARK: - Private Methods
    
    private func addSubviews() {
        contentView.addSubview(imageView)
    }
    
    private func setConstraints() {
        imageView.stretchFullOn(contentView)
    }
}
