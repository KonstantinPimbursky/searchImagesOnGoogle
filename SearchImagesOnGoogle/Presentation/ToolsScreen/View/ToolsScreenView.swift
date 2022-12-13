//
//  ToolsScreenView.swift
//  SearchImagesOnGoogle
//
//  Created by Konstantin Pimbursky on 11.12.2022.
//

import UIKit

protocol ToolsScreenViewDelegate: AnyObject {
    func backButtonAction()
    func resetButtonAction()
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
    
    public var currentTitleType: TitleType = .tools
    
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
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var resetButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.alpha = 0
        button.setTitle(R.string.localizable.reset(), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 7, left: 7, bottom: 7, right: 7)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
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
        currentTitleType = type
        UIView.animate(withDuration: 0.3) { [self] in
            titleLabel.text = type.title
            backButton.alpha = type.showBackButton ? 1 : 0
            resetButton.alpha = type.showBackButton ? 1 : 0
        }
    }
    
    // MARK: - Actions
    
    @objc private func buttonAction(_ sender: UIButton) {
        switch sender {
        case backButton:
            delegate?.backButtonAction()
        case resetButton:
            delegate?.resetButtonAction()
        default:
            break
        }    }
    
    // MARK: - Private Methods
    
    private func addSubviews() {
        [
            topBackgroundView,
            backButton,
            titleLabel,
            resetButton,
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
            
            titleLabel.centerYAnchor.constraint(equalTo: topBackgroundView.centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            resetButton.centerYAnchor.constraint(equalTo: topBackgroundView.centerYAnchor),
            resetButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            pageContainer.topAnchor.constraint(equalTo: topBackgroundView.bottomAnchor),
            pageContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            pageContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            pageContainer.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
