//
//  GameTile.swift
//  GameStore
//
//  Created by ROHIT MISHRA on 09/09/23.
//

import UIKit

class GameTile: UITableViewCell {
    static let identifier = "GameTile"
    
    enum Constant {
        static let cornerRadius = 20.0
        static let imageCornerRadius = 20.0
        static let buttonCornerRadius = 20.0
        
        // UI constraints
        static let space = 20.0
        static let topSpace = 40.0
        static let imageHeight = 100.0
        static let imageWidth = 100.0
        static let buttonHeight = 50.0
    }
    
    private let tileView: UIView = {
       let view = UIView()
        view.backgroundColor = .systemOrange
        view.layer.cornerRadius = Constant.imageCornerRadius
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let thumbnailView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .systemYellow
        view.layer.cornerRadius = Constant.imageCornerRadius
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let downloadButton: UIButton = {
       let button = UIButton()
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = Constant.buttonCornerRadius
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - UI constraints
    private func setupUIConstrainsts() {
        
        /// Tile View constraints
        NSLayoutConstraint.activate([
            tileView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constant.space),
            tileView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constant.space),
            tileView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constant.space),
            tileView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constant.space),
        ])
        
        
        /// Thumbnail image constraints
        NSLayoutConstraint.activate([
            thumbnailView.leadingAnchor.constraint(equalTo: tileView.leadingAnchor, constant: Constant.space),
            thumbnailView.topAnchor.constraint(equalTo: tileView.topAnchor, constant: Constant.topSpace),
            thumbnailView.heightAnchor.constraint(equalToConstant: Constant.imageHeight),
            thumbnailView.widthAnchor.constraint(equalToConstant: Constant.imageWidth)
        ])
        
        /// Download button constaints
        NSLayoutConstraint.activate([
            downloadButton.leadingAnchor.constraint(equalTo: tileView.leadingAnchor, constant: Constant.space),
            downloadButton.trailingAnchor.constraint(equalTo: tileView.trailingAnchor, constant: -Constant.space),
            downloadButton.bottomAnchor.constraint(equalTo: tileView.bottomAnchor, constant: -Constant.space),
            downloadButton.heightAnchor.constraint(equalToConstant: Constant.buttonHeight)
        ])
    }
}


// MARK: - Private methods
extension GameTile {
    private func setupUI() {
        contentView.backgroundColor = .white
        contentView.addSubview(tileView)

        tileView.addSubview(thumbnailView)
        tileView.addSubview(downloadButton)
        setupUIConstrainsts()
    }
}
