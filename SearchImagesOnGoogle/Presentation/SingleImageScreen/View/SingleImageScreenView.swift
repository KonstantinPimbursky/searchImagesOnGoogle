//
//  SingleImageScreenView.swift
//  SearchImagesOnGoogle
//
//  Created by Konstantin Pimbursky on 09.12.2022.
//

import UIKit

protocol SingleImageScreenViewDelegate: AnyObject {
    func previousButtonAction()
    func nextButtonAction()
    func openSourcePageButtonAction()
}

final class SingleImageScreenView: UIView {
    
    // MARK: - Types
    
    private enum ButtonType {
        case previous
        case next
        case openSourcePage
        
        var icon: UIImage? {
            switch self {
            case .previous:
                return UIImage(systemName: "chevron.left")
            case .next:
                return UIImage(systemName: "chevron.right")
            case .openSourcePage:
                return nil
            }
        }
        
        var title: String? {
            switch self {
            case .openSourcePage:
                return R.string.localizable.openSourcePage()
            default:
                return nil
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
    
    private weak var delegate: SingleImageScreenViewDelegate?
    
    private lazy var previousButton = createButton(type: .previous)
    
    private lazy var nextButton = createButton(type: .next)
    
    private lazy var openSourcePageButton: UIButton = {
        let button = createButton(type: .openSourcePage)
        button.backgroundColor = R.color.buttonColor()
        button.layer.cornerCurve = .continuous
        button.layer.cornerRadius = 20
        button.layer.borderColor = UIColor.white.withAlphaComponent(0.16).cgColor
        button.layer.borderWidth = 2
        return button
    }()
    
    // MARK: - Initializers
    
    init(delegate: SingleImageScreenViewDelegate?) {
        self.delegate = delegate
        super.init(frame: .zero)
        backgroundColor = R.color.backgroundColor()
        addSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Properties
    
    public func previousButton(isActive: Bool) {
        previousButton.isEnabled = isActive
    }
    
    public func nextButton(isActive: Bool) {
        nextButton.isEnabled = isActive
    }
    
    // MARK: - Actions
    
    @objc private func buttonAction(_ sender: UIButton) {
        switch sender {
        case previousButton:
            delegate?.previousButtonAction()
        case nextButton:
            delegate?.nextButtonAction()
        case openSourcePageButton:
            delegate?.openSourcePageButtonAction()
        default:
            break
        }
    }
    
    // MARK: - Private Methods
    
    private func createButton(type: ButtonType) -> UIButton {
        let button = type == .openSourcePage ? UIButton(type: .system) : UIButton()
        button.setImage(type.icon, for: .normal)
        button.setTitle(type.title, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return button
    }
    
    private func addSubviews() {
        [
            pageContainer,
            previousButton,
            nextButton,
            openSourcePageButton
        ].forEach { addSubview($0) }
    }
    
    private func setConstraints() {
        pageContainer.stretchFullOn(self)
        NSLayoutConstraint.activate([
            previousButton.topAnchor.constraint(equalTo: topAnchor),
            previousButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            previousButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            previousButton.widthAnchor.constraint(equalToConstant: 48),
            
            nextButton.topAnchor.constraint(equalTo: topAnchor),
            nextButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            nextButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            nextButton.widthAnchor.constraint(equalToConstant: 48),
            
            openSourcePageButton.bottomAnchor.constraint(
                equalTo: safeAreaLayoutGuide.bottomAnchor,
                constant: -16
            ),
            openSourcePageButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 48),
            openSourcePageButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -48),
            openSourcePageButton.heightAnchor.constraint(equalToConstant: 56)
        ])
    }
}
