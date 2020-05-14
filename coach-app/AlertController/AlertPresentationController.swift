//
//  AlertPresentationController.swift
//  Lagree
//
//  Created by Arsen Leontijevic on 10/2/19.
//  Copyright © 2019 Arsen Leontijevic. All rights reserved.
//

import UIKit

class AlertPresentationController: UIPresentationController {

    public var height = 140
    public var position:pos = .MIDDLE
    var gesture:UITapGestureRecognizer? = nil
    override var frameOfPresentedViewInContainerView: CGRect {
        var origin = CGPoint()
        let bounds = presentingViewController.view.bounds
        let width = UIScreen.main.bounds.size.width - 10
        let size = CGSize(width: Int(width), height: self.height)
        if position ==  .BOTTOM{
            origin = CGPoint(x: bounds.midX - size.width / 2, y: bounds.maxY - size.height)
        }else{
            origin = CGPoint(x: bounds.midX - size.width / 2, y: bounds.midY - size.height/2)
        }
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

        gesture = UITapGestureRecognizer(target: self, action: #selector(dismissController))
        gesture!.numberOfTapsRequired = 1
        gesture!.cancelsTouchesInView = false
        containerView!.isUserInteractionEnabled = true
        containerView!.addGestureRecognizer(gesture!)
        
        presentingViewController.transitionCoordinator?.animate(alongsideTransition: { _ in
            self.dimmingView.alpha = 0.95
        }, completion: nil)
    }
    
    override func dismissalTransitionWillBegin() {
        super.dismissalTransitionWillBegin()
        containerView!.removeGestureRecognizer(self.gesture!)
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
    
    @objc func dismissController(sender: UITapGestureRecognizer){
        print("clicked")
        let touchPoint = sender.location(in: containerView)
        if !presentedView!.frame.contains(touchPoint) {
            presentingViewController.dismiss(animated: true, completion: nil)
        }
    }
}
