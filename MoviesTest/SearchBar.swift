//
//  SearchBar.swift
//  MoviesTest
//
//  Created by Синютин Андрей on 28.03.17.
//  Copyright © 2017 Синютин Андрей. All rights reserved.
//

import UIKit


@objc protocol SearchBarDelegate {
    func searchBarDidChageText(text:String)
    func searchBarDidTapCancelButton()
}


class SearchBar: UIView, UITextFieldDelegate {
    
    let seachIconImageView = UIImageView(frame: .zero)
    
    let textField = TextField(frame: .zero)
    let cancelButton = UIButton(frame: .zero)
    
    var showBBorder = true
    
    weak var delegate:SearchBarDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        setupSubviews()
        setupEvents()
        addCustomConstraints()
    }
    
    func setupSubviews() {
        
        self.backgroundColor = .white
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.cornerRadius = 15.0
        textField.insets = UIEdgeInsets(top: 2, left: 28, bottom: 0, right: 10)
        
        textField.font = UIFont.regularFontOfSize(17)
        textField.backgroundColor = UIColor.moviesWhiteTwo
        textField.textColor = UIColor.black
        
        textField.delegate = self
        
        self.addSubview(textField)
        
        
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(UIColor.moviesGreyishBrown, for: .normal)
        cancelButton.titleLabel?.font = UIFont.regularFontOfSize(17)
        
        self.addSubview(cancelButton)
        
        
        seachIconImageView.translatesAutoresizingMaskIntoConstraints = false
        seachIconImageView.contentMode = .scaleAspectFit
        seachIconImageView.image = UIImage(named: "Search")!
        
        self.addSubview(seachIconImageView)
    }
    
    func setupEvents() {
        self.cancelButton.addTarget(self, action: #selector(onTapCancelButton), for: .touchUpInside)
    }
    
    func addCustomConstraints() {
        
        let metrics: [String:Any] = [
            
            "iconTop": 8,
            "iconBottom": 8.5,
            "iconLeft": 7.5,
            
            "fieldHeight": 30,
            
            "fieldTop": 39.5,
            "fieldBottom": 17.5,
            "fieldLeft": 8,
            "fieldRight": 9.5,
            
            "buttonRight": 9.5
        ]
        
        let views: [String:UIView] = [
            "mainView":self,
            "icon":seachIconImageView,
            "field":textField,
            "button":cancelButton,
        ]
        
        //Horizontal layout
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|-fieldLeft-[field]-fieldRight-[button]-buttonRight-|",
                                                                       options: [],
                                                                       metrics: metrics,
                                                                       views: views))
        
        
        //Vertical layout
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-fieldTop-[field(fieldHeight)]-fieldBottom-|",
                                                                       options: [],
                                                                       metrics: metrics,
                                                                       views: views))
        
        
        self.addConstraint(NSLayoutConstraint(item: seachIconImageView,
                                              attribute: .left,
                                              relatedBy: .equal,
                                              toItem: textField,
                                              attribute: .left,
                                              multiplier: 1.0,
                                              constant: 7.5))
        
        self.addConstraint(NSLayoutConstraint(item: cancelButton,
                                              attribute: .centerY,
                                              relatedBy: .equal,
                                              toItem: textField,
                                              attribute: .centerY,
                                              multiplier: 1.0,
                                              constant: 0))
        
        self.addConstraint(NSLayoutConstraint(item: seachIconImageView,
                                              attribute: .centerY,
                                              relatedBy: .equal,
                                              toItem: textField,
                                              attribute: .centerY,
                                              multiplier: 1.0,
                                              constant: 0))
        
    }
    
    //MARK: - Events
    
    func onTapCancelButton() {
        self.delegate?.searchBarDidTapCancelButton()
    }
    
    func textField(_ tf: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        self.delegate?.searchBarDidChageText(text: string)
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        self.delegate?.searchBarDidChageText(text: textField.text ?? "")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        if showBBorder {
            let rectanglePath = UIBezierPath(rect: CGRect(x: 0, y: rect.size.height - 0.5, width: rect.size.width, height: 0.5))
            
            UIColor.moviesSeparator.setFill()
            rectanglePath.fill()
        }
    }
    
}

