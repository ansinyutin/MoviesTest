//
//  NavBarButton.swift
//  MoviesTest
//
//  Created by Синютин Андрей on 28.03.17.
//  Copyright © 2017 Синютин Андрей. All rights reserved.
//

import UIKit

class NavBarButton: UIButton {

    var title: String = ""
    
    let bottomLine = UIView(frame: .zero)
    
    //MARK: - Lifecycle
    
    init(title: String) {
        super.init(frame: .zero)
        
        self.title = title
       
        setup()
    }
    
    func setup() {
        
        self.isExclusiveTouch = true
        
        self.backgroundColor = UIColor.clear
        
        self.contentEdgeInsets = UIEdgeInsets(top: 13, left: 21, bottom: 12, right: 21)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let font = UIFont.regularFontOfSize(13)
        
        let titleAttributes = [NSFontAttributeName: font,
                               NSForegroundColorAttributeName: UIColor.moviesWarmGrey]
        let titleAttributedString = NSAttributedString(string: title,
                                                       attributes: titleAttributes)
        self.setAttributedTitle(titleAttributedString, for: .normal)
        
        
        let titleAttributesSelected = [NSFontAttributeName: font,
                                       NSForegroundColorAttributeName: UIColor.black]
        let titleAttributedStringDisabled = NSAttributedString(string: title,
                                                               attributes: titleAttributesSelected)
        self.setAttributedTitle(titleAttributedStringDisabled, for: .selected)
        
        self.contentHorizontalAlignment = .center
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        if self.isSelected {
            let rectanglePath = UIBezierPath(rect: CGRect(x: 0, y: rect.size.height - 1, width: rect.size.width, height: 1))
            
            self.titleLabel?.textColor.setFill()
            rectanglePath.fill()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
