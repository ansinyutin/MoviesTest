//
//  ViewController.swift
//  MoviesTest
//
//  Created by Синютин Андрей on 24.03.17.
//  Copyright © 2017 Синютин Андрей. All rights reserved.
//

import UIKit
import pop

class ColorStripesView: UIView {
    
    override func draw(_ rect: CGRect) {
        //// Draw pattern tile
        let context = UIGraphicsGetCurrentContext()
        
        //// Draw pattern in view
        UIColor(patternImage: UIImage(named:"pattern")!).setFill()
        context!.fill(rect)
    }
}

class ViewController: UIViewController {
    
    let photoView = UIImageView(frame: .zero)
    let bbar = UIView(frame: .zero)
    let bottomSheet = UIView(frame: .zero)
    let scrollView = UIScrollView(frame: .zero)
    
    let scrollViewContent = ColorStripesView(frame: .zero)
    
    // MARK: Life cycle
    
    
    func setupInjection() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(onInjection),
                                               name: Notification.Name("INJECTION_BUNDLE_NOTIFICATION"),
                                               object: nil)
    }
    
    @objc func onInjection() {
        
        print("injected")
        
        refreshLayout()
        speedUpScrollView()
    }

    func speedUpScrollView() {
        
        let animationKey = "scrollViewTopScroll"
        
        let scrollAnimation = POPDecayAnimation(propertyNamed: kPOPScrollViewContentOffset)!
        scrollAnimation.velocity = CGPoint(x: 0, y: 2000)
        
        scrollView.pop_add(scrollAnimation, forKey: animationKey)
    }
    
    func refreshLayout() {
        
        self.view.subviews.forEach { (view) in
            view.removeFromSuperview()
        }
        
        self.setupLayout()
    }
    
    override func loadView() {
        super.loadView()
        
        setupInjection()
        
        setupLayout()
    }
    
    func setupLayout() {
        
        self.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.backgroundColor = .black
        
        photoView.translatesAutoresizingMaskIntoConstraints = false
        photoView.layer.opacity = 0.5
        
        bbar.translatesAutoresizingMaskIntoConstraints = false
        bbar.backgroundColor = .yellow
        bbar.layer.opacity = 0.5
        
        bottomSheet.translatesAutoresizingMaskIntoConstraints = false
        bottomSheet.backgroundColor = .white
        bottomSheet.layer.cornerRadius = 10
        //        bottomSheet.layer.opacity = 0.8
        
        scrollView.contentOffset = CGPoint(x: 0, y: 0)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .lightGray
        
        scrollViewContent.translatesAutoresizingMaskIntoConstraints = false
        
        
        bottomSheet.addSubview(scrollView)
        
        scrollView.addSubview(scrollViewContent)
        
        
        view.addSubview(photoView)
        view.addSubview(bbar)
        view.addSubview(bottomSheet)
        
        addCustomConstraints()
    }
    
    func addCustomConstraints() {
        
        let metrics: [String:Any] = [
            "topBarHeight": 70.0,
            "bottomBarHeight": 70.0
        ]
        
        let views: [String:UIView] = [
            "mainView":self.view,
            "photoView":photoView,
            "bbar":bbar,
            "bottomSheet":bottomSheet,
            "scrollView":scrollView,
            "scrollViewContent":scrollViewContent
        ]
        
        //Horizontal layout
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|-10-[photoView]-10-|",
                                                           options: [],
                                                           metrics: metrics,
                                                           views: views))
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|-10-[bbar]-10-|",
                                                           options: [],
                                                           metrics: metrics,
                                                           views: views))
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|-0-[bottomSheet]-0-|",
                                                           options: [],
                                                           metrics: metrics,
                                                           views: views))
        
        
        //Vertical layout
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[photoView]-10-[bbar(100)]-10-|",
                                                           options: [],
                                                           metrics: metrics,
                                                           views: views))
        
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[bottomSheet(500)]",
                                                           options: [],
                                                           metrics: metrics,
                                                           views: views))
        
        
        view.addConstraint(NSLayoutConstraint(item: bottomSheet,
                                              attribute: .top,
                                              relatedBy: .equal,
                                              toItem: bottomSheet.superview,
                                              attribute: .bottom,
                                              multiplier: 1.0,
                                              constant: -500))
        
        
        //scrollivew
        
        
        
        //Horizontal layout
        
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|-0-[scrollView]-0-|",
                                                           options: [],
                                                           metrics: metrics,
                                                           views: views))
        
        //Vertical layout
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-60-[scrollView]-0-|",
                                                           options: [],
                                                           metrics: metrics,
                                                           views: views))
        
        
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|-100-[scrollViewContent(100)]-100-|",
                                                           options: [],
                                                           metrics: metrics,
                                                           views: views))
        
        //Vertical layout
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[scrollViewContent(3000)]-10-|",
                                                           options: [],
                                                           metrics: metrics,
                                                           views: views))
   
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

