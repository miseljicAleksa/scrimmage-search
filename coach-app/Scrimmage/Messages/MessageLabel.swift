//
//  RegViewLabel.swift
//  LepshaStudio
//
//  Created by Arsen Leontijevic on 31/03/2020.
//  Copyright © 2020 Software Engineering Institute. All rights reserved.
//

import UIKit

//@IBDesignable
class MessageLabel: UILabel {
    
    var topInset: CGFloat = 20.0
    var bottomInset: CGFloat = 20.0
    var leftInset: CGFloat = 20.0
    var rightInset: CGFloat = 20.0
    
   
    override func drawText(in rect: CGRect) {
       let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
        self.layer.cornerRadius = 28
        self.layer.masksToBounds = true
    }

    override var intrinsicContentSize: CGSize {
       get {
          var contentSize = super.intrinsicContentSize
          contentSize.height += topInset + bottomInset
          contentSize.width += leftInset + rightInset
          return contentSize
       }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //setup()
    }

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        //setupConstraints()
    }
    
    func setup() {
    }
    
    func setupConstraints()
    {
        //Constraints
        if(self.superview != nil){
            let margins = self.superview!
            
            //Apply constraints imedietly
            layoutIfNeeded()
        }
    }
    
    
}
