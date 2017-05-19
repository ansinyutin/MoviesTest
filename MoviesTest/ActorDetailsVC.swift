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
    func onActorDetailPanChange(offset:CGPoint, updateInitialDetailOffset: Bool)
    func onActorDetailPanEnd(offset:CGPoint, velocity:CGPoint)
    func onActorDetailPanAnimationEnd(velocity:CGPoint)
}

class ActorDetailsVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    weak var panDelegate:ActorDetailsVCPanDelegate? = nil
    
    let header = ActorDetailsHeaderView(frame: .zero)
    
    var list:UICollectionView!
    var listHeader:UICollectionReusableView? = nil
    
    let listItemSize = CGSize(width: 100, height: 150)
    
    let data:[Dictionary<String,String>] = DataStorage.shared.actorMovies
    
    let reuseIdForMoviesHeader = "ActorDetailsMoviesHeader"
    let reuseIdForMoviesItem = "ActorDetailsMoviesItem"
    
    var actor:Actor = DataStorage.shared.WilliamDafoe
    
    var panRecognizer:UIPanGestureRecognizer!
    
    var constHeaderHeight = NSLayoutConstraint()
    
    var initialOffset:CGFloat = 0
    var lastOffset: CGPoint = CGPoint(x: 0, y: 0)
    
    let minOffset:CGFloat = 0
    lazy var maxOffset:CGFloat = {
        return self.list.contentSize.height - self.list.frame.size.height
    }()
    
    var prevTopOffset:CGFloat = 0
    var topOffset:CGFloat = 0
    
    var openProgress:CGFloat = 0 // 0.0 - 1.0

    var isOpened:Bool {
        return self.openProgress == 1.0
    }
    
    let headerShrinkHeight:CGFloat = 20
    
    struct Metrics {
        static var headerHeight:CGFloat = 80.0
        
        static var closedBgColor = UIColor(rgba: "#202020")
        static var openedBgColor = UIColor.moviesBlack5
    }
    
    var isTopReached:Bool {
        return self.list.contentOffset.y <= self.minOffset
    }
    
    var isBottomReached:Bool {
        return self.list.contentOffset.y >= self.maxOffset
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
       
        refresh()
        
        addCustomConstraints()
        
        view.backgroundColor = .red
    }
    
    func setupList() {
        
        let flowLayout = UICollectionViewFlowLayout()
        //        flowLayout.headerReferenceSize = CGSize(width: 375, height: 200)
        flowLayout.estimatedItemSize = CGSize(width: 100, height: 150)
        flowLayout.minimumLineSpacing = 20
        flowLayout.sectionInset = UIEdgeInsets(top: 20, left: 17, bottom: 20, right: 18)
        
        list = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        list.translatesAutoresizingMaskIntoConstraints = false
        list.backgroundColor = .white
        
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
        header.backgroundColor = getBgColor()
        header.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(header)
    }
    
    func addCustomConstraints() {
        
        let metrics:[String:Any] = [
            "headerHeight": Metrics.headerHeight
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
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[header]-0-[list]-0-|",
                                                           options: [],
                                                           metrics: metrics,
                                                           views: views))
        
        
        self.constHeaderHeight = NSLayoutConstraint(item: header,
                                                    attribute: .height,
                                                    relatedBy: .equal,
                                                    toItem: nil,
                                                    attribute: .notAnAttribute,
                                                    multiplier: 1.0,
                                                    constant: Metrics.headerHeight)
        
        view.addConstraint(self.constHeaderHeight)
    }
    
    
    //MARK:- Refresh
    
    func refresh(){
        self.header.setupWith(actor: actor)
        updateAnimatableViews()
    }
    
    
    //MARK:- Scroll handling
    
    func update(withTopOffset offset: CGFloat, openProgress progress: CGFloat) {
        
        prevTopOffset = topOffset
        topOffset = offset
        openProgress = progress
        
        updateAnimatableViews()
    }
    
    func updateAnimatableViews() {
        
        if prevTopOffset >= 0 || topOffset >= 0 {
            shrinkHeader()
            updateListOffset()
        }
        
        if topOffset == 0 {
            updateOpenProgress()
        }
        
    }
    
    func shrinkHeader() {
        shrinkHeaderHeight()
        shrinkHeaderArrow()
        shrinkHeaderTitle()
        shrinkHeaderBBorder()
    }
    
    let headerHeightShrinkFrames:[KeyFrame] = [
        KeyFrame(time: 0, value: 80),
        KeyFrame(time: 20, value: 60),
    ]
    
    func shrinkHeaderHeight() {
        let headerHeight = Animation.getValue(frames: headerHeightShrinkFrames, time: fabs(topOffset))
        self.constHeaderHeight.constant = headerHeight
    }
    
    func shrinkHeaderArrow() {
        shrinkHeaderArrowOpacity()
        shrinkHeaderArrowPosition()
    }
    
    let headerArrowOpacityShrinkFrames:[KeyFrame] = [
        KeyFrame(time: 0, value: 1),
        KeyFrame(time: 20, value: 0),
    ]
    
    func shrinkHeaderArrowOpacity() {
        let opacity = Animation.getValue(frames: headerArrowOpacityShrinkFrames, time: fabs(topOffset))
        
        print("shrink opacity: \(opacity)")
        self.header.arrowImageView.layer.opacity = Float(opacity)
    }
    
    let headerArrowPositionShrinkFrames:[KeyFrame] = [
        KeyFrame(time: 0, value: 15),
        KeyFrame(time: 20, value: 5),
    ]

    func shrinkHeaderArrowPosition() {
        let offset = Animation.getValue(frames: headerArrowPositionShrinkFrames, time: fabs(topOffset))
        self.header.constArrowTop.constant = offset
    }
    
    let headerTitlePositionShrinkFrames:[KeyFrame] = [
        KeyFrame(time: 0, value: 34),
        KeyFrame(time: 20, value: 18),
    ]
    
    func shrinkHeaderTitle() {
        let offset = Animation.getValue(frames: headerTitlePositionShrinkFrames, time: fabs(topOffset))
        self.header.constNameTop.constant = offset
    }
    
    func shrinkHeaderBBorder() {
        
        self.header.showBBorder = topOffset > headerShrinkHeight
    }
    
    func updateListOffset() {

        let listOffset = getOffsetForList()
        self.list.contentOffset = CGPoint(x: 0, y: listOffset)
    }
    
    func getOffsetForList() -> CGFloat {
        
        var offset = topOffset
        
        if offset > headerShrinkHeight {
            offset -= headerShrinkHeight
        } else {
            offset = 0
        }
        
        return offset
    }
    
    func updateOpenProgress() {
        
        updateBackgroundColor()
        updateHeader()
    }
    
    func updateBackgroundColor() {
        let color = getBgColor()
        
        header.backgroundColor = color
        listHeader?.backgroundColor = color
    }
    
    func updateHeader() {
        
        updateHeaderArrowOpacity()
        updateHeaderArrowRotation()
        
        updateHeaderDotsOpacity()
        
        updateHeaderTitlePosition()
        updateHeaderTitleOpacity()
    }
    
    var headerTitlePositionFrames:[KeyFrame] = [
        KeyFrame(time: 0, value: 44),
        KeyFrame(time: 0.6, value: 44),
        KeyFrame(time: 0.9, value: 34),
        KeyFrame(time: 1, value: 34),
    ]
    
    func updateHeaderTitlePosition() {
        let offset = Animation.getValue(frames: headerTitlePositionFrames, time: openProgress)
        self.header.constNameTop.constant = offset
    }
    
    var headerTitleOpacityFrames:[KeyFrame] = [
        KeyFrame(time: 0, value: 0),
        KeyFrame(time: 0.6, value: 0),
        KeyFrame(time: 0.85, value: 1),
        KeyFrame(time: 1, value: 1),
    ]
    
    func updateHeaderTitleOpacity() {
        
        let titleOpacity = Animation.getValue(frames: headerTitleOpacityFrames, time: openProgress)
        self.header.nameLabel.layer.opacity = Float(titleOpacity)
        self.header.profLabel.layer.opacity = Float(titleOpacity)
    }
    
    func updateHeaderArrowRotation() {
        
        var degrees:CGFloat = 0
        
        if openProgress <= 0.4 {
            degrees = 180
        } else {
            degrees = 0
        }
        
        let angle = CGAffineTransform(rotationAngle: degrees * CGFloat.pi/180.0)
        
        self.header.arrowImageView.transform = angle
    }
    
    var arrowOpacityFrames:[KeyFrame] = [
        KeyFrame(time: 0, value: 0.2),
        KeyFrame(time: 0.4, value: 0),
        KeyFrame(time: 0.6, value: 0),
        KeyFrame(time: 1, value: 1),
    ]
    
    func updateHeaderArrowOpacity() {
        
        let arrowOpacity = Animation.getValue(frames: arrowOpacityFrames, time: openProgress)
        print("arrow opacity: \(arrowOpacity)")
        self.header.arrowImageView.layer.opacity = Float(arrowOpacity)
    }
    
    var headerDotsOpacityFrames:[KeyFrame] = [
        KeyFrame(time: 0, value: 0),
        KeyFrame(time: 0.9, value: 0),
        KeyFrame(time: 1, value: 1),
    ]
    
    func updateHeaderDotsOpacity() {
        
        let dotsOpacity = Animation.getValue(frames: headerDotsOpacityFrames, time: openProgress)
        
        self.header.dotsImageView.layer.opacity = Float(dotsOpacity)
    }
    
    func updateHeaderTitle() {
        
    }
    
    var bgOpacityFrames:[KeyFrame] = [
        KeyFrame(time: 0, value: 0.13),
        KeyFrame(time: 0.3, value: 0.13),
        KeyFrame(time: 0.9, value: 0.95),
        KeyFrame(time: 1, value: 0.95),
    ]
    
    func getBgColor() -> UIColor {
        
        let curAlpha = Animation.getValue(frames: bgOpacityFrames, time: openProgress)
        return UIColor.init(white: curAlpha, alpha: 1)
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
        
        cell.setupWith(image: image, imageSize: listItemSize)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return listItemSize
    }
   
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        var reusableView : UICollectionReusableView? = nil
        

        if (kind == UICollectionElementKindSectionHeader) {

            let headerView =
                collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: self.reuseIdForMoviesHeader,
                    for: indexPath) as! ActorDetailsCollectionViewHeader
            
            headerView.backgroundColor = getBgColor()
            headerView.setupWith(actor: self.actor)
            
            reusableView = headerView
            
            listHeader = headerView
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
