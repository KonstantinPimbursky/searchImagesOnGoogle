//
//  CoordinatorProtocol.swift
//  SearchImagesOnGoogle
//
//  Created by Konstantin Pimbursky on 09.12.2022.
//

import UIKit

protocol CoordinatorProtocol: AnyObject {
    
    // MARK: - Public Properties
    
    var navigationController: UINavigationController { get }
    
    // MARK: - Initializers
    
    init(navigationController: UINavigationController)
    
    // MARK: - Public Methods
    
    func showErrorAlert(message: String)
}
