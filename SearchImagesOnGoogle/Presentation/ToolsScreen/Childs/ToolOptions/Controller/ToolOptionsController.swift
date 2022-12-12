//
//  ToolOptionsController.swift
//  SearchImagesOnGoogle
//
//  Created by Konstantin Pimbursky on 12.12.2022.
//

import UIKit

final class ToolOptionsController: UIViewController {
    
    // MARK: - Private Properties
    
    private let mainView = ToolOptionsView()
    
    // MARK: - Life Cycle
    
    override func loadView() {
        view = mainView
    }
}
