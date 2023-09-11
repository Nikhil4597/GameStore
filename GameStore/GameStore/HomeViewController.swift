//
//  ViewController.swift
//  GameStore
//
//  Created by ROHIT MISHRA on 09/09/23.
//

import UIKit

class HomeViewController: UIViewController {
    enum Constants {
        static let title = "PLAY"
        static let numberOfSection = 1
        static let numberOfRowsInSection = 3
        static let leadingSpace = 10.0
        static let space = 20.0
        static let cellHeight = 500.0
    }
    
    lazy private var tableView: UITableView = {
       let view = UITableView()
        view.register(GameTile.self, forCellReuseIdentifier: GameTile.identifier)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - UI constraints
    private func setupUIConstrainsts() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leadingSpace),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.leadingSpace),
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.space),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constants.space)
        ])
    }
}

// MARK: - Private methods
extension HomeViewController {
    private func setupUI() {
        view.backgroundColor = .white
        title = Constants.title
        
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        
        setupUIConstrainsts()
    }
}

// MARK: - UITableView
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        Constants.numberOfSection
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Constants.cellHeight
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Constants.numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GameTile.identifier) as? GameTile else {
            return UITableViewCell()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     let detailsViewController = GameDetailsViewController()
        detailsViewController.transitioningDelegate = self
        detailsViewController.modalPresentationStyle = .fullScreen
        present(detailsViewController, animated: true)
    }
}


extension HomeViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return AnimateTransition(duration: 1.0)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        nil
    }
}
