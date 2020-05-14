import UIKit
import Foundation

enum pos: String {
    case MIDDLE
    case BOTTOM
}

class AlertTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {
    
    
    public var height = 140
    public var position:pos = .MIDDLE
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let pc = AlertPresentationController(presentedViewController: presented, presenting: presenting)
        pc.height = self.height
        pc.position = self.position
        return pc
    }
}
