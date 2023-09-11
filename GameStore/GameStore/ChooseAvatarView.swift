//
//  ChooseAvatarView.swift
//  GameStore
//
//  Created by ROHIT MISHRA on 10/09/23.
//

import UIKit

class ChooseAvatarView: UIView {
    enum Constants {
        // titles
        static let playerName = "AloneWolf"
        static let avatarName1 = "Wolf \nMan"
        static let avatarName2 = "Lion \nGirl"
        
        // Constraints
        static let minSpace = 3.0
        static let space = 20.0
        static let imageHeight = 150.0
        static let imageWidth = 150.0
        static let cornerRadius = imageWidth / 2
        static let leadingConstraint = 30.0
        static let lableWidth = 150.0
    }
    
    private let playerLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.playerName
        label.textAlignment = .center
        label.textColor = .black
        label.alpha = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let avatarImage1: UIImageView = {
       let view = UIImageView()
        view.backgroundColor = .gray
        view.layer.cornerRadius = Constants.cornerRadius
        view.clipsToBounds = true
        view.alpha = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let avatarImage2: UIImageView = {
       let view = UIImageView()
        view.backgroundColor = .gray
        view.layer.cornerRadius = Constants.cornerRadius
        view.clipsToBounds = true
        view.alpha = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let avatarName1: UILabel = {
        let label = UILabel()
        label.text = Constants.avatarName1
        label.textAlignment = .center
        label.textColor = .black
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15, weight: .light)
        label.alpha = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let avatarName2: UILabel = {
        let label = UILabel()
        label.text = Constants.avatarName2
        label.textAlignment = .center
        label.textColor = .black
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15, weight: .light)
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
    
    // MARK: - UI Constraints
    private func setupUIConstraints() {
        NSLayoutConstraint.activate([
            playerLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            playerLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            playerLabel.topAnchor.constraint(equalTo: topAnchor, constant: Constants.space)
        ])
        
        NSLayoutConstraint.activate([
            avatarImage1.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.leadingConstraint),
            avatarImage1.topAnchor.constraint(equalTo: playerLabel.bottomAnchor, constant: Constants.space),
            avatarImage1.heightAnchor.constraint(equalToConstant: Constants.imageHeight),
            avatarImage1.widthAnchor.constraint(equalToConstant: Constants.imageWidth)
        ])

        NSLayoutConstraint.activate([
            avatarName1.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.leadingConstraint),
            avatarName1.topAnchor.constraint(equalTo: avatarImage1.bottomAnchor, constant:  Constants.minSpace),
            avatarName1.widthAnchor.constraint(equalToConstant: Constants.lableWidth)
        ])

        NSLayoutConstraint.activate([
            avatarImage2.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.leadingConstraint),
            avatarImage2.topAnchor.constraint(equalTo: playerLabel.bottomAnchor, constant: Constants.space),
            avatarImage2.heightAnchor.constraint(equalToConstant: Constants.imageHeight),
            avatarImage2.widthAnchor.constraint(equalToConstant: Constants.imageWidth)
        ])

        NSLayoutConstraint.activate([
            avatarName2.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.leadingConstraint),
            avatarName2.topAnchor.constraint(equalTo: avatarImage2.bottomAnchor, constant:  Constants.minSpace),
            avatarName2.widthAnchor.constraint(equalToConstant: Constants.lableWidth)
        ])
    }
}

// MARK: - Private methods
extension ChooseAvatarView {
    private func setupUI() {
        backgroundColor = .white
        
        let subviews = [playerLabel, avatarImage1, avatarName1, avatarImage2, avatarName2]
        
        subviews.forEach({
            addSubview($0)
        })
        
        setupUIConstraints()
    }
    
    private func loadAnimation() {
        playerLabel.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
        let avatarImage1ScaleX = avatarImage1.frame.origin.x
        avatarImage1.frame.origin.x = 3 * avatarImage1ScaleX
        
        let avatarName1ScaleX = avatarName1.frame.origin.x
        avatarName1.frame.origin.x = 3 * avatarName1ScaleX
        
        
        let avatarImage2ScaleX = avatarImage2.frame.origin.x
        avatarImage2.frame.origin.x = 3 * avatarImage1ScaleX
        
        let avatarName2ScaleX = avatarName2.frame.origin.x
        avatarName2.frame.origin.x = 3 * avatarName1ScaleX
        
        UIView.animate(withDuration: 1.0) {
            self.playerLabel.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            self.playerLabel.alpha = 1
            
            self.avatarImage1.alpha = 1
            self.avatarImage1.frame.origin.x = avatarImage1ScaleX
            
            self.avatarName1.alpha = 1
            self.avatarName1.frame.origin.x = avatarName1ScaleX
            
            self.avatarImage2.alpha = 1
            self.avatarImage2.frame.origin.x = avatarImage2ScaleX
            
            self.avatarName2.alpha = 1
            self.avatarName2.frame.origin.x = avatarName2ScaleX
        }
    }
}
