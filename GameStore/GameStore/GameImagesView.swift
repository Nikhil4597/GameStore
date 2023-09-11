//
//  GameImagesView.swift
//  GameStore
//
//  Created by ROHIT MISHRA on 09/09/23.
//

import UIKit

class GameImagesView: UICollectionViewCell {
    static let identifier = "GameImagesView"
    
    private let gameImageView: UIImageView = {
       let view = UIImageView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(gameImageView)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func didAddSubview(_ subview: UIView) {
        gameImageView.frame = contentView.bounds
    }
}
