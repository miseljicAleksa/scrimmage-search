//
//  File.swift
//  ChoicePopup
//
//  Created by Arsen Leontijevic on 9/18/19.
//  Copyright © 2019 Ralf Ebert. All rights reserved.
//
import UIKit
import Foundation
class TransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {
    public var height = 300
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let pc = PresentationController(presentedViewController: presented, presenting: presenting)
        pc.height = self.height
        return pc
    }
}
