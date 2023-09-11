//
//  ReadyToPlayView.swift
//  GameStore
//
//  Created by ROHIT MISHRA on 10/09/23.
//

import UIKit

class ReadyToPlayView: UIView {
    enum Constants {
        static let primaryText = "Ready To Play?"
        static let secondaryText = "OSWALD"
        static let walletTitle = "Wallet Amount: "
        static let amount = "60"
        static let selectedAmount = "5/-"
        
        // Constraints
        static let minSpace = 5.0
        static let space = 20.0
        static let leading = 30.0
        static let walletWidth = 130.0
        static let amountWidth = 30.0
        static let stackHeight = 100.0
        
    }
    
    private let primaryLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.primaryText
        label.textAlignment = .center
        label.alpha = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let secondaryLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.secondaryText
        label.textAlignment = .center
        label.alpha = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.alignment = .fill
        view.distribution = .fillEqually
        view.spacing = 16
        view.alpha = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let walletLabel: UILabel = {
      let label = UILabel()
        label.text = Constants.walletTitle
        label.textColor = .black
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14)
        label.alpha = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let amountLabel: UILabel = {
      let label = UILabel()
        label.text = Constants.amount
        label.textColor = .black
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14)
        label.alpha = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let selectedAmount: UILabel = {
        let label = UILabel()
        label.text = Constants.selectedAmount
        label.textColor = .black
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14)
        label.alpha = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        loadAnimation()
    }
    
    // MARK: - UI constraints
    private func setupUIConstraints() {
        NSLayoutConstraint.activate([
            primaryLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            primaryLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            primaryLabel.topAnchor.constraint(equalTo: topAnchor, constant: Constants.space)
        ])
        
        NSLayoutConstraint.activate([
            secondaryLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            secondaryLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            secondaryLabel.topAnchor.constraint(equalTo: primaryLabel.bottomAnchor, constant: Constants.space)
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: secondaryLabel.bottomAnchor,  constant:  Constants.space),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.leading),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.leading),
            stackView.heightAnchor.constraint(equalToConstant: Constants.stackHeight)
        ])
        
        NSLayoutConstraint.activate([
            walletLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.space),
            walletLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 2*Constants.space ),
            walletLabel.widthAnchor.constraint(equalToConstant: Constants.walletWidth)
        ])
        
        NSLayoutConstraint.activate([
            amountLabel.leadingAnchor.constraint(equalTo: walletLabel.trailingAnchor, constant: Constants.minSpace),
            amountLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant:2*Constants.space ),
            amountLabel.widthAnchor.constraint(equalToConstant: Constants.amountWidth)
        ])
        
        NSLayoutConstraint.activate([
            selectedAmount.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.space),
            selectedAmount.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant:2*Constants.space),
            selectedAmount.widthAnchor.constraint(equalToConstant: Constants.amountWidth)
        ])
    }
}

// MARK: - Private methods
extension ReadyToPlayView {
    private func setupUI() {
        backgroundColor = .white
        
        let subview = [primaryLabel, secondaryLabel, stackView, walletLabel, amountLabel, selectedAmount]
        subview.forEach({
            addSubview($0)
        })
        
        setupStackView()
        
        setupUIConstraints()
    }
    
    private func setupStackView() {
        let button1 = createRoundButton(text: "Easy", backgroundColor: .systemGreen)
        let button2 = createRoundButton(text: "Medium", backgroundColor: .gray)
        let button3 = createRoundButton(text: "Hard", backgroundColor: .gray)
        
        let buttons = [button1, button2, button3]
        
        buttons.forEach({
            stackView.addArrangedSubview($0)
        })
    }
    
    private func createRoundButton(text: String, backgroundColor: UIColor) -> UIButton {
        let button = UIButton()
        button.setTitle(text, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = backgroundColor
        button.frame.size = CGSize(width: 100, height: 100)
        button.layer.cornerRadius = button.bounds.size.width * 0.5
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    private func loadAnimation() {
        primaryLabel.transform = CGAffineTransform(scaleX: 0, y: 0)
        secondaryLabel.transform = CGAffineTransform(scaleX: 0, y: 0)
        let originX = self.stackView.frame.origin.x
        self.stackView.frame.origin.x = 5 * originX
        
        let originY = walletLabel.frame.origin.y
        
        walletLabel.frame.origin.y = 2 * originY
        amountLabel.frame.origin.y = 2 * originY
        selectedAmount.frame.origin.y = 2 * originY
        
        UIView.animate(withDuration: 1.0, animations: {
            self.primaryLabel.alpha = 1
            self.primaryLabel.transform = CGAffineTransform(scaleX: 1, y: 1)
    
            self.secondaryLabel.alpha = 1
            self.secondaryLabel.transform = CGAffineTransform(scaleX: 1, y: 1)
    
            self.walletLabel.alpha = 1
            self.walletLabel.frame.origin.y = originY
            self.amountLabel.alpha = 1
            self.amountLabel.frame.origin.y = originY
            self.selectedAmount.alpha = 1
            self.selectedAmount.frame.origin.y = originY
            
            self.stackView.alpha = 1
            self.stackView.frame.origin.x = originX
            
        })
    }
}

