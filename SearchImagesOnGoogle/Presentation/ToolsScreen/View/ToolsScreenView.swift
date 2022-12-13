//
//  ToolsScreenView.swift
//  SearchImagesOnGoogle
//
//  Created by Konstantin Pimbursky on 11.12.2022.
//

import UIKit

protocol ToolsScreenViewDelegate: AnyObject {
    func backButtonAction()
}

final class ToolsScreenView: UIView {
    
    // MARK: - Types
    
    enum TitleType {
        case tools
        case size
        case country
        case language
        
        var title: String {
            switch self {
            case .tools:
                return R.string.localizable.tools()
            case .size:
                return R.string.localizable.size()
            case .country:
                return R.string.localizable.country()
            case .language:
                return R.string.localizable.language()
            }
        }
        
        var showBackButton: Bool {
            switch self {
            case .tools:
                return false
            case .language, .country, .size:
                return true
            }
        }
    }
    
    // MARK: - Public Properties
    
    public let pageContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Private Properties
    
    private weak var delegate: ToolsScreenViewDelegate?
    
    private let topBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = R.color.buttonColor()
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .white
        label.text = R.string.localizable.tools()
        return label
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(R.image.chevronLeft(), for: .normal)
        button.alpha = 0
        button.imageEdgeInsets = UIEdgeInsets(top: 7, left: 7, bottom: 7, right: 7)
        button.addTarget(self, action: #selector(backButtonAction), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Initializers
    
    init(delegate: ToolsScreenViewDelegate?) {
        self.delegate = delegate
        super.init(frame: .zero)
        backgroundColor = R.color.backgroundColor()
        addSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    public func changeTitle(type: TitleType) {
        UIView.animate(withDuration: 0.3) { [self] in
            titleLabel.text = type.title
            backButton.alpha = type.showBackButton ? 1 : 0
        }
    }
    
    // MARK: - Actions
    
    @objc private func backButtonAction() {
        delegate?.backButtonAction()
    }
    
    // MARK: - Private Methods
    
    private func addSubviews() {
        [
            topBackgroundView,
            backButton,
            titleLabel,
            pageContainer
        ].forEach { addSubview($0) }
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            topBackgroundView.topAnchor.constraint(equalTo: topAnchor),
            topBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            topBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            topBackgroundView.heightAnchor.constraint(equalToConstant: 44),
            
            backButton.centerYAnchor.constraint(equalTo: topBackgroundView.centerYAnchor),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            backButton.widthAnchor.constraint(equalToConstant: 30),
            backButton.heightAnchor.constraint(equalToConstant: 30),
            
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            pageContainer.topAnchor.constraint(equalTo: topBackgroundView.bottomAnchor),
            pageContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            pageContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            pageContainer.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
