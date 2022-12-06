//
//  SearchImageController.swift
//  SearchImagesOnGoogle
//
//  Created by Konstantin Pimbursky on 05.12.2022.
//

import UIKit

final class SearchImageController: UIViewController {
    
    // MARK: - Private Properties
    
    private let mainView = SearchImageView()
    
    // MARK: - Life Cycle
    
    override func loadView() {
        view = mainView
    }
    
}
