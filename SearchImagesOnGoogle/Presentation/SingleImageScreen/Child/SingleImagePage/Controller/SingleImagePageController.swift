//
//  SingleImagePageController.swift
//  SearchImagesOnGoogle
//
//  Created by Konstantin Pimbursky on 10.12.2022.
//

import SDWebImage
import UIKit

final class SingleImagePageController: UIViewController, SingleImagePageProtocol {
    
    // MARK: - SingleImagePageProtocol
    
    public let imageIndex: Int
    
    // MARK: - Private Properties
    
    private let mainView = SingleImagePageView()
    
    private let image: SingleImageResult
    
    // MARK: - Initializers
    
    init(imageIndex: Int, image: SingleImageResult) {
        self.imageIndex = imageIndex
        self.image = image
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func loadView() {
        view = mainView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadImage()
    }
    
    // MARK: - Private Methods
    
    private func loadImage() {
        guard let url = URL(string: image.original) else { return }
        mainView.imageView.sd_setImage(with: url)
    }
}
