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
    
    private weak var coordinator: CoordinatorProtocol?
    
    private let mainView = SingleImagePageView()
    
    private let image: SingleImageResult
    
    // MARK: - Initializers
    
    init(imageIndex: Int, image: SingleImageResult, coordinator: CoordinatorProtocol?) {
        self.imageIndex = imageIndex
        self.image = image
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadImage()
    }
    
    // MARK: - Private Methods
    
    private func loadImage() {
        guard let url = URL(string: image.original) else { return }
        mainView.imageView.sd_imageIndicator = SDWebImageActivityIndicator.large
        mainView.imageView.sd_setImage(with: url) { [weak self] _, error, _, _ in
            if let error = error {
                self?.coordinator?.showErrorAlert(message: error.localizedDescription)
            }
        }
    }
}
