// Created by Yusif Aliyev
// February 26, 2018

import UIKit

@IBDesignable
class Custom_Segmented_Control: UIControl {

    var buttons = [UIButton]()
    var selector: UIView!
    var selected_button_idex = 0
    
    @IBInspectable
    var border_width: CGFloat = 0 {
        didSet {
            layer.borderWidth = border_width
        }
    }
    
    @IBInspectable
    var border_color: UIColor = .lightGray {
        didSet {
            layer.borderColor = border_color.cgColor
        }
    }
    
    @IBInspectable
    var button_titles_seperated_by_commas: String = "" {
        didSet {
            update_view()
        }
    }
    
    @IBInspectable
    var button_text_color: UIColor = .lightGray {
        didSet {
            update_view()
        }
    }
    
    @IBInspectable
    var selector_color: UIColor = .lightGray {
        didSet {
            update_view()
        }
    }
    
    @IBInspectable
    var selector_text_color: UIColor = .white {
        didSet {
            update_view()
        }
    }
    
    func update_view() {
        buttons.removeAll()
        subviews.forEach { $0.removeFromSuperview() }
        
        self.layer.masksToBounds = true
        
        let button_titles = button_titles_seperated_by_commas.components(separatedBy: ",")
        
        for button_title in button_titles {
            let button = UIButton(type: .system)
            button.setTitle(button_title, for: .normal)
            button.setTitleColor(button_text_color, for: .normal)
            button.addTarget(self, action: #selector(button_pressed(pressed_button:)), for: .touchUpInside)
            buttons.append(button)
        }
        
        buttons[0].setTitleColor(selector_text_color, for: .normal)
        
        let selector_width = frame.width / CGFloat(buttons.count)
        selector = UIView(frame: CGRect(x: 0, y: 0, width: selector_width, height: frame.height))
        selector.layer.cornerRadius = frame.height / 2
        selector.backgroundColor = selector_color
        addSubview(selector)
        
        let stack_view = UIStackView(arrangedSubviews: buttons)
        
        stack_view.axis = .horizontal
        stack_view.alignment = .fill
        stack_view.distribution = .fillEqually
        
        addSubview(stack_view)
        
        stack_view.translatesAutoresizingMaskIntoConstraints = false
        
        stack_view.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stack_view.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        stack_view.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        stack_view.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        
    }
    
    override func draw(_ rect: CGRect) {
        layer.cornerRadius = frame.height / 2
    }
    
    @objc func button_pressed(pressed_button: UIButton) {
        for (button_index, button) in buttons.enumerated() {
            button.setTitleColor(button_text_color, for: .normal)
            
            if button == pressed_button {
                selected_button_idex = button_index
                
                let selector_start_position_x = frame.width / CGFloat(buttons.count) * CGFloat(button_index)
                
                UIView.animate(withDuration: 0.3, animations: {
                    self.selector.frame.origin.x = selector_start_position_x
                })
                
                button.setTitleColor(selector_text_color, for: .normal)
                

            }
        }
        
        sendActions(for: .valueChanged)
    }

}
