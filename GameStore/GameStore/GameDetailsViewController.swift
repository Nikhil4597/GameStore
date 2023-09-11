//
//  GameDetailsViewController.swift
//  GameStore
//
//  Created by ROHIT MISHRA on 09/09/23.
//

import UIKit

class GameDetailsViewController: UIViewController {
    enum Constants {
        /// Titles
        static let gameName = "CANDY BUST"
        static let descriptionText = "Dive into a world of colorful candies, where you'll find an array of delicious treats waiting to be matched. From mouthwatering gummies to sugary lollipops, the candy variety is endless."
        static let readMoreText = "Read More"
        static let downloadText = "Download \n 30 MB"
        static let playButtonTitle = "Play"
        static let downloadProgressLabel = "10 MB / 30 MB"
        
        /// UICollection constant
        static let numberOfSection = 1
        static let numberOfItemsInSection = 3
        
        /// Constraints constant
        static let cornerRadius = 20.0
        static let imageCornerRadius = 20.0
        static let largeButtonCornerRadius = 20.0
        static let smallButtonCornerRadius = 25.0
        
        static let topSpace = 100.0
        static let space = 10.0
        static let imageHeight = 100.0
        static let imageWidth = 100.0
        static let descriptionLabelHeight = 30.0
        static let labelWidth = 70.0
        static let readMoreButtonHeight = 50.0
        static let downloadButtonHeight = 70.0
        static let downloadButtonWidth = 373.0
        static let cancelButtonHeight = 50.0
        static let cancelButtonWidth = 50.0
        static let cellHeight = 380.0
        static let cellWidth = 200.0
        
    }
    
    private let gameThumbnailView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .systemYellow
        view.layer.cornerRadius = Constants.imageCornerRadius
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let gameTitleLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.gameName
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 17)
        label.textColor = .black
        label.alpha = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let cancelButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "xmark")
        button.setImage(image, for: .normal)
        button.backgroundColor = .white
        button.alpha = 0
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.descriptionText
        label.textColor = .systemGray
        label.numberOfLines = 2
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 13)
        label.alpha = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let readMoreButtton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.readMoreText, for: .normal)
        button.setTitleColor(.systemGreen, for: .normal)
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.alpha = 0
        return button
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: Constants.cellWidth, height: Constants.cellHeight)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(GameImagesView.self, forCellWithReuseIdentifier: GameImagesView.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.alpha = 0
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private let downloadButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = Constants.largeButtonCornerRadius
        button.backgroundColor = .systemGreen
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let downloadLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.downloadText
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = .white
        label.textAlignment = .center
        label.layer.cornerRadius = Constants.largeButtonCornerRadius
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let cancelDownloadButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "xmark")
        button.setImage(image, for: .normal)
        button.backgroundColor = .systemYellow
        button.layer.cornerRadius = Constants.smallButtonCornerRadius
        button.clipsToBounds = true
        button.alpha = 0
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let playButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.playButtonTitle, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = Constants.largeButtonCornerRadius
        button.clipsToBounds = true
        button.alpha = 0
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let downloadProgressLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.downloadProgressLabel
        label.textColor = .white
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.layer.cornerRadius = Constants.largeButtonCornerRadius
        label.clipsToBounds = true
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var progressLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.strokeColor = UIColor.systemGreen.cgColor
        layer.fillColor = UIColor.clear.cgColor
        layer.lineWidth = 5
        layer.lineCap = .round
        return layer
    }()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadDataAnimated()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - UI constraints
    private func setupUIContrainsts() {
        /// Game Thumbnail image constants
        NSLayoutConstraint.activate([
            gameThumbnailView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.space),
            gameThumbnailView.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.topSpace),
            gameThumbnailView.heightAnchor.constraint(equalToConstant: Constants.imageHeight),
            gameThumbnailView.widthAnchor.constraint(equalToConstant: Constants.imageWidth)
        ])
        
        /// Title name constraints
        NSLayoutConstraint.activate([
            gameTitleLabel.leadingAnchor.constraint(equalTo: gameThumbnailView.trailingAnchor, constant: Constants.space),
            gameTitleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.topSpace),
            gameTitleLabel.widthAnchor.constraint(equalToConstant: Constants.labelWidth)
        ])
        
        /// Cancel button constraints
        NSLayoutConstraint.activate([
            cancelButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.space),
            cancelButton.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.topSpace),
            cancelButton.heightAnchor.constraint(equalToConstant: Constants.cancelButtonHeight),
            cancelButton.widthAnchor.constraint(equalToConstant: Constants.cancelButtonWidth)
        ])
        
        /// Title name constraints
        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.space),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.space),
            descriptionLabel.topAnchor.constraint(equalTo: gameThumbnailView.bottomAnchor, constant: Constants.space),
        ])
        
        /// Read more constraints
        NSLayoutConstraint.activate([
            readMoreButtton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.space),
            readMoreButtton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.space),
            readMoreButtton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: Constants.space),
            readMoreButtton.heightAnchor.constraint(equalToConstant: Constants.readMoreButtonHeight)
        ])
        
        /// Downlaod button constraints
        NSLayoutConstraint.activate([
            downloadButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.space),
            downloadButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.space),
            downloadButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constants.space),
            downloadButton.heightAnchor.constraint(equalToConstant: Constants.downloadButtonHeight)
        ])
        
        /// Download label constraints
        NSLayoutConstraint.activate([
            downloadLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.space),
            downloadLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.space),
            downloadLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constants.space),
            downloadLabel.heightAnchor.constraint(equalToConstant: Constants.downloadButtonHeight)
        ])
        
        /// Download button label constraints
        NSLayoutConstraint.activate([
            downloadProgressLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.space),
            downloadProgressLabel.trailingAnchor.constraint(equalTo: cancelDownloadButton.leadingAnchor, constant: -Constants.space),
            downloadProgressLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constants.space),
            downloadProgressLabel.heightAnchor.constraint(equalToConstant: Constants.downloadButtonHeight)
        ])
        
        /// Cancel download button constraints
        NSLayoutConstraint.activate([
            cancelDownloadButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.space),
            cancelDownloadButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -(Constants.space + 6)),
            cancelDownloadButton.heightAnchor.constraint(equalToConstant: Constants.cancelButtonHeight),
            cancelDownloadButton.widthAnchor.constraint(equalToConstant: Constants.cancelButtonWidth)
        ])
        
        /// Play button constraints
        NSLayoutConstraint.activate([
            playButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.space),
            playButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.space),
            playButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constants.space),
            playButton.heightAnchor.constraint(equalToConstant: Constants.downloadButtonHeight)
        ])
        
        /// Images collection constraints
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.space),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.space),
            collectionView.topAnchor.constraint(equalTo: readMoreButtton.bottomAnchor, constant: Constants.space),
            collectionView.bottomAnchor.constraint(equalTo: downloadButton.topAnchor, constant: -Constants.space)
        ])
    }
    
}

// MARK: - Private methods
extension GameDetailsViewController {
    private func setupUI() {
        view.backgroundColor = .white
        
        let subviews = [gameThumbnailView, gameTitleLabel, cancelButton, descriptionLabel, readMoreButtton, cancelDownloadButton, downloadButton, downloadProgressLabel, playButton]
        
        subviews.forEach({
            view.addSubview($0)
        })
        
        cancelButton.addTarget(self, action: #selector(cancelButtonClicked), for: .touchUpInside)
        readMoreButtton.addTarget(self, action: #selector(readMoreButtonClicked), for: .touchUpInside)
        downloadButton.addTarget(self, action: #selector(downloadButtonTapped), for: .touchUpInside)
        playButton.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
        
        view.addSubview(collectionView)
        collectionView.dataSource  = self
        collectionView.delegate = self
        
        downloadButton.addSubview(downloadLabel)
        downloadLabel.layer.addSublayer(progressLayer)
        progressLayer.frame = downloadLabel.bounds
        
        setupUIContrainsts()
    }
    
    /**
     * Start animation while rending UI elements.
     */
    private func loadDataAnimated() {
        collectionView.frame.origin.x  = Constants.cellWidth
        
        let gameNameOriginX = gameTitleLabel.frame.origin.x
        gameTitleLabel.frame.origin.x = 2*gameNameOriginX
        
        UIView.animate(withDuration: 0.5) {
            self.gameTitleLabel.alpha = 1
            self.descriptionLabel.alpha = 1
            self.readMoreButtton.alpha = 1
            self.cancelButton.alpha = 1
            self.gameThumbnailView.alpha = 1
            self.collectionView.alpha = 1
            self.collectionView.frame.origin.x = Constants.space
            self.gameTitleLabel.frame.origin.x = gameNameOriginX
            self.view.layoutIfNeeded()
        }
    }
    
    /**
     * Animating Download button rendering.
     *
     * - Parameter : originX - Represent the original x constraints of download label.
     */
    private func animateDownloadButton(doneWithOriginX originX: CGFloat) {
        let fillColor = UIColor.systemGreen
        let animationDuration: TimeInterval = 2.0

        let finalWidth: CGFloat = downloadProgressLabel.frame.width
        let colorAnimation = CABasicAnimation(keyPath: "backgroundColor")
        colorAnimation.fromValue = UIColor.clear.cgColor
        colorAnimation.toValue = fillColor.cgColor
        colorAnimation.duration = animationDuration
        
        let widthAnimation = CABasicAnimation(keyPath: "bounds.size.width")
        widthAnimation.fromValue = 0.0
        widthAnimation.toValue = finalWidth
        widthAnimation.duration = animationDuration
        
        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [colorAnimation, widthAnimation]
        groupAnimation.duration = animationDuration
        groupAnimation.fillMode = .forwards
        groupAnimation.isRemovedOnCompletion = false
        DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
            self.cancelDownloadButton.setImage(UIImage(systemName: "checkmark"), for: .normal)
            self.downloadButton.isHidden = true
            self.downloadProgressLabel.frame.origin.x = originX
            self.downloadProgressLabel.alpha = 0
            self.showPlayButton()
            }
       
        downloadProgressLabel.layer.add(groupAnimation, forKey: "downloadAnimation")
    }
    
    /**
     * Animatiing play button rendering.
     */
    
    private func showPlayButton() {
        let originY = playButton.frame.origin.y
        let downScale = 20.0
        playButton.frame.origin.y = originY + downScale
        
        UIView.animate(withDuration: 1) {
            self.view.layoutIfNeeded()
            self.playButton.alpha = 1
            self.playButton.frame.origin.y = originY
        }
    }
    
    // MARK: - Button actions
    /**
     * Dismiss presented view
     */
    @objc private func cancelButtonClicked() {
        dismiss(animated: true)
    }
    
    /**
     * Perform read more button action.
     */
    @objc private func readMoreButtonClicked() {
        if descriptionLabel.numberOfLines == 0 {
            descriptionLabel.numberOfLines = 2
        } else {
            descriptionLabel.numberOfLines = 0
        }
    }
    
    /**
     * Perform download button action.
     */
    @objc private func downloadButtonTapped() {
        let originX = downloadButton.frame.origin.x
        
        UIView.animate(withDuration: 0.5, animations: {
            self.downloadButton.transform = CGAffineTransform(scaleX: 0.85, y: 1)
            self.downloadButton.frame.origin.x = originX
            
            self.cancelDownloadButton.alpha = 1
            self.view.layoutIfNeeded()
        } , completion: { _ in
            self.downloadButton.alpha = 0.2
            self.downloadLabel.isHidden = true
            self.downloadProgressLabel.isHidden = false
            self.animateDownloadButton(doneWithOriginX: originX)
        })
    }
    
    /*
     * Peroform play button action.
     */
    @objc private func playButtonTapped() {
        let chooseAvatar = BottomSheetViewController(selectiveView: .chooseAvatar)
        chooseAvatar.modalPresentationStyle = .overCurrentContext
        present(chooseAvatar, animated: true)
    }
}


// MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension GameDetailsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        Constants.numberOfSection
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        Constants.numberOfItemsInSection
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GameImagesView.identifier, for: indexPath) as? GameImagesView else {
            return UICollectionViewCell()
        }
        return cell
    }
}
