//
//  MainListVC.swift
//  MoviesTest
//
//  Created by Синютин Андрей on 28.03.17.
//  Copyright © 2017 Синютин Андрей. All rights reserved.
//

import UIKit

class MainListVC: UIViewController {
    
    let listReuseId = "mainListCell"
    
    var searchBar: SearchBar!
    var navBar: NavBar!
    
    var moviesVC = MoviesListVC()
    var actorsVC = ActorsListVC()
    
    let moviesButton = NavBarButton(title: "Movies")
    let actorsButton = NavBarButton(title: "Persons")
    
    var filter:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "test"
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func loadView() {
        super.loadView()
        
        setup()
    }
    
    func setup() {
        
        setupSubviews()
        setupEvents()
        
        addCustomConstraints()
        
        showMovies()
    }
    
    func setupSubviews() {
        
        searchBar = SearchBar(frame: .zero)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(searchBar)
    
        
        navBar = NavBar(buttons: [moviesButton, actorsButton])
        navBar.translatesAutoresizingMaskIntoConstraints = false
        navBar.backgroundColor = UIColor.black.withAlphaComponent(0.02)
        self.view.addSubview(navBar)
        
       
        self.addChildViewController(moviesVC)
        moviesVC.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(moviesVC.view)
        moviesVC.didMove(toParentViewController: self)
        
        
        self.addChildViewController(actorsVC)
        actorsVC.delegate = self
        actorsVC.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(actorsVC.view)
        actorsVC.didMove(toParentViewController: self)
    }
    
    func setupEvents() {
        moviesButton.addTarget(self, action: #selector(onTapMoviesButton), for: .touchUpInside)
        actorsButton.addTarget(self, action: #selector(onTapActorsButton), for: .touchUpInside)
    }
    
    func addCustomConstraints() {
        
        let metrics:[String:Any] = [
            "listHeight": 295,
            "navHeight": 40
        ]
        
        let views: [String:UIView] = [
            "search": searchBar,
            "nav": navBar,
            "movies": moviesVC.view,
            "actors": actorsVC.view,
        ]
        
        //Horizontal layout
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|-0-[search]-0-|",
                                                           options: [],
                                                           metrics: metrics,
                                                           views: views))
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|-0-[nav]-0-|",
                                                           options: [],
                                                           metrics: metrics,
                                                           views: views))

        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|-0-[movies]-0-|",
                                                           options: [],
                                                           metrics: metrics,
                                                           views: views))
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|-0-[actors]-0-|",
                                                           options: [],
                                                           metrics: metrics,
                                                           views: views))
        
        //Vertical layout
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[search]-0-[nav]",
                                                           options: [],
                                                           metrics: metrics,
                                                           views: views))
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[actors(listHeight)]",
                                                           options: [],
                                                           metrics: metrics,
                                                           views: views))
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[movies(listHeight)]",
                                                           options: [],
                                                           metrics: metrics,
                                                           views: views))
        
        view.addConstraint(NSLayoutConstraint(item: moviesVC.view,
                                              attribute: .top,
                                              relatedBy: .equal,
                                              toItem: navBar,
                                              attribute: .bottom,
                                              multiplier: 1.0,
                                              constant: 0))
        
        view.addConstraint(NSLayoutConstraint(item: actorsVC.view,
                                              attribute: .top,
                                              relatedBy: .equal,
                                              toItem: navBar,
                                              attribute: .bottom,
                                              multiplier: 1.0,
                                              constant: 0))
    }
    
    
    //MARK: - Actions
    
    func showMovies() {
        moviesVC.view.isHidden = false
        actorsVC.view.isHidden = true
        
        actorsButton.isSelected = false
        moviesButton.isSelected = true
    }
    
    func showActors() {
        moviesVC.view.isHidden = true
        actorsVC.view.isHidden = false
        
        actorsButton.isSelected = true
        moviesButton.isSelected = false
    }
    
    func showActorDetail() {
        let vc = ActorVC()
        vc.setupWithActor(name: "Willem Dafoe",
                          professions: ["Actor", "Director"],
                          moviesWatched: 178,
                          allMovies: 298,
                          fans: 89,
                          rate: 7.3)
        
        vc.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.present(vc, animated: false, completion: nil)
    }
    
    //MARK: - Events
    
    func onTapMoviesButton() {
        showMovies()
    }
    
    func onTapActorsButton() {
        showActors()
    }
}

extension MainListVC: ActorsListVCDelegate {
    
    func actorSelected(index: Int) {
        showActorDetail()
    }
}
