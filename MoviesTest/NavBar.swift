//
//  NavBar.swift
//  MoviesTest
//
//  Created by Синютин Андрей on 28.03.17.
//  Copyright © 2017 Синютин Андрей. All rights reserved.
//

import UIKit

class NavBar: UIView {
    
    var buttons:[NavBarButton]!
    
    init(buttons: [NavBarButton] ) {
        super.init(frame: .zero)
        
        self.buttons = buttons
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        for button in buttons {            
            self.addSubview(button)
        }
        
        addCustomConstraints()
    }
    
    
    func addCustomConstraints() {
        
        
        let buttonInsets = UIEdgeInsets.zero
        
        //Horizontal layout
        
        var prevView:UIView = self
        
        if let firstButton = buttons.first {
            self.addConstraint(NSLayoutConstraint(item: firstButton,
                                                  attribute: .left,
                                                  relatedBy: .equal,
                                                  toItem: firstButton.superview,
                                                  attribute: .left,
                                                  multiplier: 1.0,
                                                  constant: buttonInsets.left))
            prevView = firstButton
        }
        
        for i in (1..<buttons.count) {
            
            let button = buttons[i]
            
            self.addConstraint(NSLayoutConstraint(item: button,
                                                  attribute: .left,
                                                  relatedBy: .equal,
                                                  toItem: prevView,
                                                  attribute: .right,
                                                  multiplier: 1.0,
                                                  constant: buttonInsets.right))
            
        }

        
        //Vertical layout
        
        for button in buttons {
            
            self.addConstraint(NSLayoutConstraint(item: button,
                                                  attribute: .top,
                                                  relatedBy: .equal,
                                                  toItem: button.superview,
                                                  attribute: .top,
                                                  multiplier: 1.0,
                                                  constant: buttonInsets.top))
            
            self.addConstraint(NSLayoutConstraint(item: button,
                                                  attribute: .bottom,
                                                  relatedBy: .equal,
                                                  toItem: button.superview,
                                                  attribute: .bottom,
                                                  multiplier: 1.0,
                                                  constant: buttonInsets.bottom))
        }

        
        
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let rectanglePath = UIBezierPath(rect: CGRect(x: 0, y: rect.size.height - 1, width: rect.size.width, height: 1))
        
        UIColor.moviesSeparator.setFill()
        rectanglePath.fill()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
