//
//  NoLocationServicesView.swift
//  fasten
//
//  Created by Синютин Андрей on 31.03.17.
//  Copyright © 2017 fasteninc. All rights reserved.
//

import UIKit

class NoLocationServicesView: UIView {
    
    var textLabel: UILabel!
    
    let viewHeight:CGFloat = 50
    
    var statusBarStyleBeforeShow:UIStatusBarStyle!
    
    
    //MARK: - Public
    
    public static func show() {
        
        let view = NoLocationServicesView.findInRootView()
        
        if view == nil {
            let warnView = NoLocationServicesView()
            warnView.addToRootViewAnimated()
        }
    }
    
    public static func hide() {
        
        if let warnView = NoLocationServicesView.findInRootView() {
            warnView.removeFromRootViewAnimated()
        }
    }
    
    
    //MARK: - View lifecycle
    
    init() {
        
        let frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: viewHeight)
        
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.orange
        
        textLabel = UILabel(frame: .zero)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.backgroundColor = UIColor.clear
        textLabel.font = UIFont.boldFontOfSize(11)
        textLabel.textColor = UIColor.white
        textLabel.numberOfLines = 0
        textLabel.textAlignment = .center
        textLabel.text = "no_location_services_view.title".capitalized
        
        self.addSubview(textLabel)
        
        addCustomConstraints()
        
        self.layoutIfNeeded()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addCustomConstraints() {
        let metrics: [String:Any] = [
            "top": 26,
            "bottom": 10
        ]
        
        let views: [String:UIView] = ["textLabel": textLabel]
        
        //Horizontal layout
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|[textLabel]|",
                                                           options: [],
                                                           metrics: metrics,
                                                           views: views))
        
        //Vertical layout
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-top-[textLabel]-bottom-|",
                                                           options: [],
                                                           metrics: metrics,
                                                           views: views))
    }
    
    
    //MARK: - Animation
    
    func removeFromRootViewAnimated() {
        
        let offset = -self.viewHeight
        
        animateRootView(offset: offset, completion: {
            self.removeFromSuperview()            
        })
    }

    func addToRootViewAnimated() {
        
        let offset = self.viewHeight
        
        addOrangeViewToRootView()
        
        animateRootView(offset: offset)
    }
    
    func addOrangeViewToRootView() {
        
        if let rootView = NoLocationServicesView.rootView {
            
            self.frame = CGRect(x: 0, y: -self.viewHeight, width: rootView.frame.size.width, height: self.viewHeight)
            
            rootView.addSubview(self)
        }
    }
    
    func animateRootView(offset:CGFloat, completion: (()->())? = nil) {
        
        self.statusBarStyleBeforeShow = UIApplication.shared.statusBarStyle
        UIApplication.shared.setStatusBarStyle(UIStatusBarStyle.lightContent, animated: true)
        
        if let rootView = NoLocationServicesView.rootView {
            
            rootView.layer.borderColor = UIColor.green.cgColor
            rootView.layer.borderWidth = 2
            
            UIView.animate(withDuration: 1, animations: {
            
                let y = rootView.frame.origin.y + offset
                let height = rootView.frame.size.height - offset
                
                rootView.frame = CGRect(x: 0, y: y, width: rootView.frame.size.width, height: height)
                
                rootView.layoutIfNeeded()
            
            }, completion: { (success:Bool) in
            
                completion?()
            })
        }
    }
  

    //MARK: - Helpers
    
    static var rootView:UIView? {
        return UIApplication.shared.keyWindow?.rootViewController?.view
    }
    
    static func findInRootView() -> NoLocationServicesView? {
        
        var foundView:NoLocationServicesView? = nil
        
        if let rootView = NoLocationServicesView.rootView {
            
            let rootViewSubviews = rootView.subviews
            
            for view in rootViewSubviews {
                
                if view is NoLocationServicesView {
                    foundView = view as? NoLocationServicesView
                    break
                }
            }
        }
        
        return foundView
    }
}
