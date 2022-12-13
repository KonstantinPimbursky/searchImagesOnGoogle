//
//  ToolsTable.swift
//  SearchImagesOnGoogle
//
//  Created by Konstantin Pimbursky on 12.12.2022.
//

import UIKit

final class ToolsTable: UIViewController {
    
    // MARK: - Private Properties
    
    private let mainView = ToolOptionsView()
    
    private let model: ToolsTableModel = ToolsTableModelImpl()
    
    // MARK: - Life Cycle
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    // MARK: - Private Methods
    
    private func setupTableView() {
        mainView.table.dataSource = self
        mainView.table.delegate = self
    }
    
    private func createSubtitlesString(from: [String]) -> String {
        var result = ""
        for (index, item) in from.enumerated() {
            if index > 0 {
                result += "; "
            }
            result += item
        }
        return result
    }
}

// MARK: - UITableViewDataSource

extension ToolsTable: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model.numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ToolsTableCell = tableView.dequeueCell(for: indexPath)
        let cellModel = model.cell(at: indexPath)
        cell.configure(
            title: cellModel.title,
            subtitle: createSubtitlesString(from: cellModel.subtitles)
        )
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ToolsTable: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}
