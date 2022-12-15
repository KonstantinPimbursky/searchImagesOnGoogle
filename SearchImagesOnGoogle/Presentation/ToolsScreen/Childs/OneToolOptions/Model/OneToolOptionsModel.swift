//
//  OneToolOptionsModel.swift
//  SearchImagesOnGoogle
//
//  Created by Konstantin Pimbursky on 13.12.2022.
//

import UIKit

protocol OneToolOptionsModel {
    var numberOfItems: Int { get }
    var cells: [String] { get set }
    
    /// Хелпер, помогает получить ячейку по IndexPath
    /// - Parameter indexPath: indexPath для ячейки
    /// - Returns: модель для ячейки по указанному indexPath
    func cell(at indexPath: IndexPath) -> String
}

struct OneToolOptionsModelImpl: OneToolOptionsModel {
    
    // MARK: - Public Properties
    
    let numberOfItems: Int
    var cells: [String]
    
    // MARK: - Initializers
    
    init(cells: [String]) {
        self.numberOfItems = cells.count
        self.cells = cells
    }
    
    // MARK: - Public Methods
    
    func cell(at indexPath: IndexPath) -> String {
        cells[indexPath.item]
    }
}
