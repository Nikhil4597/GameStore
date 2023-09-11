//
//  ChooseAavtarViewController.swift
//  GameStore
//
//  Created by ROHIT MISHRA on 10/09/23.
//

import UIKit

enum SelectiveView {
    case chooseAvatar
    case addMoney
    case readyToPlay
}

class BottomSheetViewController: UIViewController {
    enum Constants {
        // Titles
        static let nextButtonTitle = "Next"
        
        // Constraints
        static let largeButtonCornerRadius = 20.0
        static let maxDimmedAlpha = 0.6
        static let nextButtonHeight = 70.0
        static let space = 10.0
    }

    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var dimmedView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = Constants.maxDimmedAlpha
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.nextButtonTitle, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = Constants.largeButtonCornerRadius
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var selectiveView: SelectiveView {
        didSet {
            decideNextView()
        }
    }
    
    init(selectiveView: SelectiveView) {
        self.selectiveView = selectiveView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        decideNextView()
    }
    
    // MARK: - UI Constraints
    private func setupUIConstraints() {
        /// Dimmed view constraints
        NSLayoutConstraint.activate([
           dimmedView.topAnchor.constraint(equalTo: view.topAnchor),
           dimmedView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
           dimmedView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
           dimmedView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
       ])
        
        /// Container view constraints
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            containerView.heightAnchor.constraint(equalToConstant: view.bounds.height / 2)
        ])
        
        /// Play button constraints
        NSLayoutConstraint.activate([
            nextButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Constants.space),
            nextButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Constants.space),
            nextButton.bottomAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.bottomAnchor, constant: -Constants.space),
            nextButton.heightAnchor.constraint(equalToConstant: Constants.nextButtonHeight)
        ])
    }
    
    // MARK: - Selected view constraints
    private func selectedViewConstraints(selectedView: UIView) {
        NSLayoutConstraint.activate([
            selectedView.topAnchor.constraint(equalTo: containerView.topAnchor),
            selectedView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            selectedView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            selectedView.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -Constants.space)
        ])
    }
}

// MARK: - Private methods
extension BottomSheetViewController {
    private func setupView() {
        view.backgroundColor = .clear

        /// Base View
        view.addSubview(dimmedView)
        view.addSubview(containerView)
        containerView.addSubview(nextButton)
        nextButton.addTarget(self, action: #selector(nextButtonClicked), for: .touchUpInside)
        setupUIConstraints()
    }
    
    private func decideNextView() {
        switch selectiveView {
        case .chooseAvatar:
            let selectedView = ChooseAvatarView(frame: .zero)
            selectedView.translatesAutoresizingMaskIntoConstraints = false
            containerView.addSubview(selectedView)
            selectedViewConstraints(selectedView: selectedView)
        case .addMoney:
            let selectedView = AddMoneyView(frame: .zero)
            selectedView.translatesAutoresizingMaskIntoConstraints = false
            containerView.addSubview(selectedView)
            selectedViewConstraints(selectedView: selectedView)
        case .readyToPlay:
            let selectedView = ReadyToPlayView(frame: .zero)
            selectedView.translatesAutoresizingMaskIntoConstraints = false
            containerView.addSubview(selectedView)
            selectedViewConstraints(selectedView: selectedView)
        }
    }
    
    @objc private func nextButtonClicked() {
        switch selectiveView {
        case .chooseAvatar:
            selectiveView = .addMoney
        case .addMoney:
            selectiveView = .readyToPlay
            nextButton.setTitle("Confirm", for: .normal)
            nextButton.backgroundColor = .black
        case .readyToPlay:
            self.dismiss(animated: true)
        }
    }
}
