//
//  PresentationController.swift
//  ChoicePopup
//
//  Created by Alk Msljc on 9/11
//  Copyright © 2019 Ralf Ebert. All rights reserved.
//
import UIKit

class PresentationController: UIPresentationController {
    
    public var height = 300
    
    override var frameOfPresentedViewInContainerView: CGRect {
        let bounds = presentingViewController.view.bounds
        let width = UIScreen.main.bounds.size.width - 20
        let size = CGSize(width: Int(width), height: self.height)
        let origin = CGPoint(x: bounds.midX - size.width / 2, y: bounds.midY - size.height / 2)
        return CGRect(origin: origin, size: size)
    }
    
    let dimmingView: UIView = {
        let dimmingView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        dimmingView.translatesAutoresizingMaskIntoConstraints = false
        return dimmingView
    }()
    
    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        
        let superview = presentingViewController.view!
        superview.addSubview(dimmingView)
        NSLayoutConstraint.activate([
            dimmingView.leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            dimmingView.trailingAnchor.constraint(equalTo: superview.trailingAnchor),
            dimmingView.bottomAnchor.constraint(equalTo: superview.bottomAnchor),
            dimmingView.topAnchor.constraint(equalTo: superview.topAnchor)
            ])
        
        dimmingView.alpha = 0
        presentingViewController.transitionCoordinator?.animate(alongsideTransition: { _ in
            self.dimmingView.alpha = 1
        }, completion: nil)
    }
    
    override func dismissalTransitionWillBegin() {
        super.dismissalTransitionWillBegin()
        
        presentingViewController.transitionCoordinator?.animate(alongsideTransition: { _ in
            self.dimmingView.alpha = 0
        }, completion: { _ in
            self.dimmingView.removeFromSuperview()
        })
    }
    
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        
        presentedView?.autoresizingMask = [
            .flexibleTopMargin,
            .flexibleBottomMargin,
            .flexibleLeftMargin,
            .flexibleRightMargin
        ]
        
        presentedView?.translatesAutoresizingMaskIntoConstraints = true
    }
}
