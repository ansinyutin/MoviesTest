//
//  ActorDetailsVC.swift
//  MoviesTest
//
//  Created by Синютин Андрей on 29.03.17.
//  Copyright © 2017 Синютин Андрей. All rights reserved.
//

import UIKit
import pop


protocol ActorDetailsVCPanDelegate:class {
    func onActorDetailPanChange(offset:CGPoint)
    func onActorDetailPanEnd(offset:CGPoint, velocity:CGPoint)
    func onActorDetailPanAnimationEnd(velocity:CGPoint)
}

class ActorDetailsVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    weak var panDelegate:ActorDetailsVCPanDelegate? = nil
    
    let header = ActorDetailsHeaderView(frame: .zero)
    
    var list:UICollectionView!
    
    let data:[Dictionary<String,String>] = DataStorage.shared.actorMovies
    
    let reuseIdForMoviesHeader = "ActorDetailsMoviesHeader"
    let reuseIdForMoviesItem = "ActorDetailsMoviesItem"
    
    var actor:Actor = DataStorage.shared.WilliamDafoe
    
    var panRecognizer:UIPanGestureRecognizer!
    
    var initialOffset:CGFloat = 0
    var lastOffset: CGPoint = CGPoint(x: 0, y: 0)
    
    let minOffset:CGFloat = 0
    lazy var maxOffset:CGFloat = {
        return self.list.contentSize.height - self.list.frame.size.height
    }()
    
    struct Metrics {
        static var headerHeightMin:CGFloat = 60.0
        static var headerHeightMax:CGFloat = 80.0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        super.loadView()
        
        setup()
    }
    
    
    //MARK:- Setup
    
    func setup() {
        
        view.round(corners: [.topLeft, .topRight], radius: 10)
        
        setupList()
        setupHeader()
        setupEvents()
       
        refresh()
        
        addCustomConstraints()
    }
    
    func setupList() {
        
        let flowLayout = UICollectionViewFlowLayout()
        //        flowLayout.headerReferenceSize = CGSize(width: 375, height: 200)
        flowLayout.estimatedItemSize = CGSize(width: 100, height: 150)
        flowLayout.minimumLineSpacing = 20
        flowLayout.sectionInset = UIEdgeInsets(top: 20, left: 17, bottom: 20, right: 18)
        
        list = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        list.translatesAutoresizingMaskIntoConstraints = false
        list.backgroundColor = .clear
        
        list.delegate = self
        list.dataSource = self
        
        list.register(ActorDetailCollectionViewCell.self,
                      forCellWithReuseIdentifier: self.reuseIdForMoviesItem)
        
        list.register(ActorDetailsCollectionViewHeader.self,
                      forSupplementaryViewOfKind: UICollectionElementKindSectionHeader,
                      withReuseIdentifier: self.reuseIdForMoviesHeader)
        
        self.view.addSubview(list)
    }
    
    func setupHeader() {
        header.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(header)
    }
    
    func setupEvents() {
//        self.panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(onPan))
//        self.view.addGestureRecognizer(self.panRecognizer)
    }
    
    
    func addCustomConstraints() {
        
        let metrics:[String:Any] = [
            "headerHeight": Metrics.headerHeightMax
        ]
        
        let views: [String:UIView] = [
            "list":list,
            "header": header
        ]
        
        //Horizontal layout
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|-0-[header]-0-|",
                                                           options: [],
                                                           metrics: metrics,
                                                           views: views))
        
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|-0-[list]-0-|",
                                                           options: [],
                                                           metrics: metrics,
                                                           views: views))
        
        //Vertical layout
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[header(headerHeight)]-0-[list]-0-|",
                                                           options: [],
                                                           metrics: metrics,
                                                           views: views))
    }
    
    
    //MARK:- Refresh
    
    func refresh(){
        self.header.setupWith(actor: actor)
    }
    
    
    //MARK:- Scroll handling
    
    func enablePanRecognizer(isEnabled:Bool) {
        print("DETAL RECOGNIZER: \(isEnabled)")
//        self.panRecognizer.isEnabled = isEnabled
    }
    
    func canHandlePan(offset:CGPoint) -> Bool {
        
        if isTopReached() && offset.y < 0 {
            return false
        }
        
        return true
    }
        
    func isTopReached() -> Bool {
        //TODO header measurements
        return self.list.contentOffset.y <= self.minOffset
    }
    
    func isBottomReached() -> Bool {
        return self.list.contentOffset.y >= self.maxOffset
    }
    
//    func onPan(recognizer:UIPanGestureRecognizer) {
//        
//        let offset:CGPoint = recognizer.translation(in: self.view)
//        let velocity = recognizer.velocity(in: self.view)
//        
//        switch recognizer.state {
//        case .began:
//            
//            self.onPanBegin(offset: offset)
//            
//        case .changed:
//            
//            let newListOffsetY =  self.initialOffset + offset.y;
//            let newListOffset = CGPoint(x: 0, y: newListOffsetY)
//            
//            self.onPanChange(offset: newListOffset)
//            
//        case .cancelled:
//            print("\nFailed\n")
//        case .failed:
//            print("\nFailed\n")
//        case .ended:
//            
//            self.onPanEnd(offset: offset, velocity: velocity)
//            
//        default: break
//        }
//        
//    }
    
    func onPanBegin(offset: CGPoint) {
        refreshInitialOffset()
        self.list.pop_removeAllAnimations()
        
        print("detail pan BEGIN ini: \(self.initialOffset)")
    }
    
    func onPanChange(offset:CGPoint, isSkipTopCheck: Bool = false) {
        
        let newListOffset = self.initialOffset - offset.y
        let isTopEdgeReached = newListOffset < minOffset
        
        print(
            "DETAIL PAN ini: \(self.initialOffset) " +
            "off: \(offset.y) " +
            "new: \(newListOffset) " +
            "topReached: \(isTopEdgeReached)")
        
        if isTopEdgeReached {
            
            let outerOffsetY = newListOffset - minOffset
            let outerOffset = CGPoint(x:0, y:outerOffsetY)
            
            panDelegate?.onActorDetailPanChange(offset: outerOffset)
            
            //TODO start head deformation
            
            self.list.contentOffset = CGPoint(x:0, y: minOffset)
            
        } else {
            
            self.list.contentOffset = CGPoint(x:0, y: newListOffset)
        }
        
    }
    
    func onPanEnd(offset:CGPoint, velocity:CGPoint) {
        
        let newListOffset = self.initialOffset - offset.y;
        
        let velocityY = velocity.y
        
        print("DETAIL PAN END: cur: \(newListOffset), max: \(maxOffset) vel: \(velocityY)")
        if newListOffset < minOffset {
            
            let outerOffsetY = newListOffset - minOffset
            let outerOffset = CGPoint(x:0, y:outerOffsetY)
            
            refreshInitialOffset()
            panDelegate?.onActorDetailPanEnd(offset: outerOffset, velocity: velocity)
            //TODO start head deformation
        } else {
            self.scrollList(withVelocity: -velocityY)
        }
        
        print("detail pan END")
        
    }
    
    func refreshInitialOffset() {
        self.initialOffset = self.list.contentOffset.y
//        self.lastOffset = offset
    }
    
    func scrollList(withVelocity velocity:CGFloat) {
        
        print("Detail Scroll Animate START - velocity: \(velocity)")
        
        let minOffset:CGFloat = 0
        let maxOffset:CGFloat = list.contentSize.height - list.frame.size.height
        
        let listScrollAnimation = POPDecayAnimation(propertyNamed: kPOPCollectionViewContentOffset)!
        listScrollAnimation.velocity = CGPoint(x:0, y:velocity)
        listScrollAnimation.animationDidApplyBlock = { [weak self] (animation:POPAnimation?) in
            
            guard let strongSelf = self else {
                return
            }
            
            let currentOffsetPoint = animation!.value(forKey: "currentValue") as! CGPoint
            let currentOffset = currentOffsetPoint.y
            let scrollAnimationVelocity = animation!.value(forKey: "velocity") as! CGPoint
            
            if ( currentOffset >= maxOffset ) {
                
//                print("DETAIL MAX REACHED: \(currentOffset)")
                
//                strongSelf.list.contentOffset = CGPoint(x: 0, y: maxOffset)
                strongSelf.list.pop_removeAllAnimations()
                
                print("Detail Scroll Animate END MAX exceeded")
                
                strongSelf.addEdgeBounceAnimationToList(toValue: maxOffset, velocity: scrollAnimationVelocity)
            }
            
            if ( currentOffset < minOffset ) {
                
//                print("DETAIL MIN REACHED: \(currentOffset)")
                
                strongSelf.list.contentOffset = CGPoint(x: 0, y: minOffset)
                strongSelf.list.pop_removeAllAnimations()
                
                print("Detail Scroll Animate END MIN exceeded")
                
                strongSelf.panDelegate?.onActorDetailPanAnimationEnd(velocity: scrollAnimationVelocity)
            }
            
//            print("DETAIL CURRENT OFFSET: \(currentOffset)")
            
            strongSelf.refreshInitialOffset()
            
        }
        
//        print("DETAIL ANIM START")

        list.pop_add(listScrollAnimation, forKey: "detailListScrollAnimation")
    }
    
    
    func addEdgeBounceAnimationToList(toValue: CGFloat, velocity: CGPoint) {
        
        print("Detail Edge Bounce Animation START")
        
        let listScrollAnimation = POPSpringAnimation(propertyNamed: kPOPCollectionViewContentOffset)!
        listScrollAnimation.velocity = velocity
        listScrollAnimation.toValue = CGPoint(x:0, y: toValue)
        listScrollAnimation.animationDidApplyBlock = { [weak self] (springAnimation:POPAnimation?) in
            let currentOffsetPointForSpringAnimation = springAnimation!.value(forKey: "currentValue") as! CGPoint
            self?.initialOffset = currentOffsetPointForSpringAnimation.y
            
        }
        
        listScrollAnimation.completionBlock = { (anim:POPAnimation?, completion:Bool) in
            print("Detail Edge Bounce Animation END")
        }
        
        self.list.pop_add(listScrollAnimation, forKey: "detailListScrollEndAnimation")
    }
    
    //MARK:- CollectionView Delegate
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let dataItem = self.data[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.reuseIdForMoviesItem, for: indexPath) as! ActorDetailCollectionViewCell
        
        let imageName = dataItem["image"]!
        let image = UIImage(named:imageName)!
        
        cell.setupWith(image: image)
        
        return cell
    }
   
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        var reusableView : UICollectionReusableView? = nil
        
        // Create header
        if (kind == UICollectionElementKindSectionHeader) {
            // Create Header
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: self.reuseIdForMoviesHeader, for: indexPath) as! ActorDetailsCollectionViewHeader
            
            headerView.backgroundColor = UIColor.moviesBlack5
 
            headerView.setupWith(actor: self.actor)
            
            reusableView = headerView
        }
        return reusableView!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let dataItem = self.data[indexPath.row]
        
        print("actor detail list items selected \(dataItem)")
    }
    
}

extension ActorDetailsVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        let height = ActorDetailsCollectionViewHeader.heightForActor(self.actor, parentView: self.list)
        
        print("height: \(height)")
  
        return CGSize(width: collectionView.frame.size.width, height: height)
    }
    
    
}
