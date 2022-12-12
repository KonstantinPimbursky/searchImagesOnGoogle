//
//  ToolsTableModel.swift
//  SearchImagesOnGoogle
//
//  Created by Konstantin Pimbursky on 12.12.2022.
//

import UIKit

// MARK: - Models

protocol ToolsTableModel {
    var cells: [ToolsTableCellModel] { get set }
}

protocol ToolsTableCellModel {
    var type: ToolsTableCellType { get }
    var title: String { get }
    var subtitles: [String] { get set }
}

// MARK: - Implementations

struct ToolsTableModelImpl: ToolsTableModel {
    var cells: [ToolsTableCellModel] = ToolsTableCellType.allCases.map { ToolsTableCellModelImpl(type: $0) }
}

enum ToolsTableCellType: CaseIterable {
    case size, country, language
    
    var title: String {
        switch self {
        case .size:
            return R.string.localizable.size()
        case .country:
            return R.string.localizable.country()
        case .language:
            return R.string.localizable.language()
        }
    }
}

struct ToolsTableCellModelImpl: Hashable, ToolsTableCellModel {
    
    // MARK: - Public Properties
    
    let type: ToolsTableCellType
    let title: String
    var subtitles: [String]
    
    // MARK: - Initializers
    
    init(type: ToolsTableCellType, subtitles: [String] = []) {
        self.type = type
        self.title = type.title
        self.subtitles = subtitles
    }
}
