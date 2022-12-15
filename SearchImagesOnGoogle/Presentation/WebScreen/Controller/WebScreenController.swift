//
//  WebScreenController.swift
//  SearchImagesOnGoogle
//
//  Created by Konstantin Pimbursky on 11.12.2022.
//

import UIKit

final class WebScreenController: UIViewController {
    
    // MARK: - Private Properties
    
    private let mainView = WebScreenView()
    
    private let urlString: String
    
    // MARK: - Initializers
    
    init(urlString: String) {
        self.urlString = urlString
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
        loadWebPage()
    }
    
    // MARK: - Private Methods
    
    private func loadWebPage() {
        guard let url = URL(string: urlString) else { return }
        mainView.load(url: url)
    }
}
