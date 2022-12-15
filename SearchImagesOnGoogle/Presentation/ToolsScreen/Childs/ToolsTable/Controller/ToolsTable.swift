//
//  ToolsTable.swift
//  SearchImagesOnGoogle
//
//  Created by Konstantin Pimbursky on 12.12.2022.
//

import UIKit

protocol ToolsTableDelegate: AnyObject {
    func toolsTable(didSelectItemAt indexPath: IndexPath)
    func toolsTableApplied()
}

final class ToolsTable: UIViewController {
    
    // MARK: - Private Properties
    
    private weak var delegate: ToolsTableDelegate?
    
    private lazy var mainView = ToolsTableView(delegate: self)
    
    private var model: ToolsTableModel
    
    // MARK: - Initializers
    
    init(model: ToolsTableModel, delegate: ToolsTableDelegate?) {
        self.model = model
        self.delegate = delegate
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
        setupTableView()
    }
    
    // MARK: - Public Methods
    
    public func reloadTable(model: ToolsTableModel) {
        self.model = model
        mainView.table.reloadData()
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

// MARK: - ToolOptionsViewDelegate

extension ToolsTable: ToolsTableViewDelegate {
    func applyButtonAction() {
        delegate?.toolsTableApplied()
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
        delegate?.toolsTable(didSelectItemAt: indexPath)
    }
}
