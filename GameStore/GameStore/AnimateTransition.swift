//
//  CustomTransition.swift
//  GameStore
//
//  Created by ROHIT MISHRA on 09/09/23.
//

import UIKit

class AnimateTransition: NSObject {
    private let duration: Double
    
    init(duration: Double) {
        self.duration = duration
    }
}

// MARK: - Private methods
extension AnimateTransition {
    private func present(with transitionContext: UIViewControllerContextTransitioning, viewToAnimate: UIView) {
        viewToAnimate.clipsToBounds = true
        viewToAnimate.transform = CGAffineTransform(scaleX: 0.8, y: 0.3)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: .curveEaseIn) {
            viewToAnimate.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        } completion: { _ in
            transitionContext.completeTransition(true)
        }
    }
}

// MARK: - UIViewControllerAnimatedTransitioning
extension AnimateTransition: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return TimeInterval(exactly: duration) ?? 0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toViewController = transitionContext.viewController(forKey: .to) else {
            transitionContext.completeTransition(false)
            return
        }
        
        transitionContext.containerView.addSubview(toViewController.view)
        present(with: transitionContext, viewToAnimate: toViewController.view)
    }
}


