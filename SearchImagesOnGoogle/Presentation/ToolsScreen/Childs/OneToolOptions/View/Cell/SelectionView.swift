//
//  SelectionView.swift
//  SearchImagesOnGoogle
//
//  Created by Konstantin Pimbursky on 13.12.2022.
//

import UIKit

final class SelectionView: UIView {
    
    // MARK: - Constants
    
    private enum Constants {
        static let viewSize = CGSize(width: 24, height: 24)
        static let fillViewSize = CGSize(width: 16, height: 16)
    }
    
    // MARK: - Public Properties
    
    override var intrinsicContentSize: CGSize {
        Constants.viewSize
    }
    
    public var isSelected: Bool = false {
        didSet {
            fillView.isHidden = !isSelected
        }
    }
    
    // MARK: - Private Properties
    
    private let circleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.layer.borderColor = R.color.purple()?.cgColor
        view.layer.borderWidth = 2
        view.layer.cornerCurve = .continuous
        view.layer.cornerRadius = Constants.viewSize.height / 2
        return view
    }()
    
    private let fillView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = R.color.purple()
        view.layer.cornerCurve = .continuous
        view.layer.cornerRadius = Constants.fillViewSize.height / 2
        view.isHidden = true
        return view
    }()
    
    // MARK: - Initializers
    
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        addSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func addSubviews() {
        [circleView, fillView].forEach { addSubview($0) }
    }
    
    private func setConstraints() {
        circleView.stretchFullOn(self)
        NSLayoutConstraint.activate([
            fillView.centerYAnchor.constraint(equalTo: centerYAnchor),
            fillView.centerXAnchor.constraint(equalTo: centerXAnchor),
            fillView.widthAnchor.constraint(equalToConstant: Constants.fillViewSize.width),
            fillView.heightAnchor.constraint(equalToConstant: Constants.fillViewSize.height)
        ])
    }
}
