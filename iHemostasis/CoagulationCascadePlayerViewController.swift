//
//  CoagulationCascadeVideoPlayerViewController.swift
//  iHemostasis
//
//  Created by Zo Rajaonarivony on 16/12/2015.
//  Copyright © 2015 Diagnostica Stago S.A.S. All rights reserved.
//

import UIKit
import SpriteKit

class CoagulationCascadePlayerViewController: UIViewController, ParentSceneDelegate,UITableViewDataSource, UITableViewDelegate {
    // UI Logic
    @IBOutlet weak var videoSlider : UISlider?
    @IBOutlet weak var sceneView : UIView?
    @IBOutlet weak var containerView : UIView?
    @IBOutlet weak var playPauseButton : UIButton?
    @IBOutlet weak var infoSequenceButton : UIButton?
    @IBOutlet weak var infoSequenceView : UIView?
    @IBOutlet weak var infoNodeSequenceView : UIView?
    @IBOutlet weak var infoNodeSequenceLabel : UILabel?
    @IBOutlet weak var phaseListView : UIView?
    @IBOutlet weak var phaseListTableView : UITableView?
    @IBOutlet weak var phaseTitleLabel: UILabel?
    @IBOutlet weak var phaseDescLabel: UILabel?
    @IBOutlet weak var phaseDescScrollView: UIScrollView?
    @IBOutlet weak var videoSliderView : UIView?
    @IBOutlet var superView: UIView!
    let textCellIdentifier = "textCellIdentifier"
    var phaseListButtonView: UIView?
    var phaseButtonLabel: UILabel?
    var downImageView: UIImageView?
    
    // Business Logic
    var scene = ParentScene()
    var sceneTimer = Timer()
    var sceneFileName = String()
    var isPlaying : Bool = false
    var animationIndex: Int = 0
    var currentTimeline: Float = 0.0
    var currentZoom: CGFloat = 1.0
    var currentDeZoom: CGFloat = 2.0
    var previousZoom: CGFloat = 1.0
    var pic: CGFloat = 1.0
    var previousZoomScale: CGFloat = 0.0
    var isSliderChangedManually = false
    
    
    var currentSceneData = CoagulationCascadeSceneModel()
    func reloadloadRightButton(){
//        phaseListButtonView?.frame = CGRect(0 , 0, UIScreen.main.bounds.width/3, 59)
//        phaseListButtonView?.backgroundColor = UIColor.red
//        phaseButtonLabel?.frame =  CGRect(-190  , -2, UIScreen.main.bounds.width/3, 49)
//        downImageView?.frame = CGRect((phaseButtonLabel!.frame.width-18) , 20, 8, 7)
    }
    
    func loadRightButton(){
        // Right menu: Phase list
        // Phase View Container
 
        if(UIDevice.current.userInterfaceIdiom == .phone){
            phaseListButtonView = UIView(frame: CGRect(UIScreen.main.bounds.width-UIScreen.main.bounds.width/4, 0, UIScreen.main.bounds.width/4, 59))
        }else{
            phaseListButtonView =  UIView(frame: CGRect(0, 0, 500, 59))
        }
        phaseListButtonView?.backgroundColor = UIColor.clear
        
        // Down Button image
        if(UIDevice.current.userInterfaceIdiom == .phone){
            downImageView = UIImageView(frame:CGRect(0, 20, 8, 7));
        }else{
            downImageView = UIImageView(frame:CGRect(470, 25, 13, 12));
        }
        
        downImageView!.image = UIImage(named:"down-arrowRED")
       
        phaseListButtonView?.addSubview(downImageView!)
        
        let downButton:UIButton = UIButton(type: UIButton.ButtonType.custom) as UIButton
        downButton.frame = CGRect(0, 0, 500, 59)
        if(UIDevice.current.userInterfaceIdiom == .phone){
            downButton.frame = CGRect(0, 0, UIScreen.main.bounds.width/3, 49)
            //downButton.semanticContentAttribute = .forceRightToLeft
        }else{
            downButton.frame = CGRect(0, 0, 500, 59)
        }
        downButton.addTarget(self, action: #selector(showPhaseList), for: UIControl.Event.touchUpInside)
        downButton.setTitle("", for: UIControl.State.normal)
        downButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        downButton.backgroundColor = UIColor.clear
        phaseListButtonView?.addSubview(downButton)
//        phaseListButtonView?.backgroundColor = UIColor.blue
        
        // DownButton Label

        if(UIDevice.current.userInterfaceIdiom == .phone){
            phaseButtonLabel = UILabel(frame: CGRect(-75, -2, UIScreen.main.bounds.width/3, 49))
        }else{
            phaseButtonLabel = UILabel(frame: CGRect(50, 0, 400, 59))
        }
        phaseButtonLabel?.font  = UIFont(name: Utils.SCREEN_TITLE_FONT_NAME, size: Utils.SCREEN_TITLE_FONT_SIZE)
        if(UIDevice.current.userInterfaceIdiom == .phone){
            phaseButtonLabel?.font  = UIFont(name: Utils.SCREEN_TITLE_FONT_NAME, size: Utils.SCREEN_TITLE_FONT_SIZE_IPHONE)
        }
        phaseButtonLabel?.textColor = Utils.colorWithHexString(hex: Utils.RED_COLOR)
        phaseButtonLabel?.textAlignment = .right
        if(UIDevice.current.userInterfaceIdiom == .phone){
            phaseButtonLabel?.textAlignment = .right
            print("frame phaseButton",phaseButtonLabel?.frame.width)
            downImageView?.frame = CGRect(phaseButtonLabel!.frame.width-65 , 20, 8, 7)
        }
        phaseButtonLabel?.backgroundColor = UIColor.clear
        phaseButtonLabel?.adjustsFontSizeToFitWidth = true
        
        phaseListButtonView?.addSubview(phaseButtonLabel!)
        
        
        if(UIDevice.current.userInterfaceIdiom == .phone){
            let gesture = UITapGestureRecognizer(target: self, action:   #selector(showPhaseList))
            phaseListButtonView!.addGestureRecognizer(gesture)
            superView.addSubview(phaseListButtonView!)
            let downButtonItem:UIBarButtonItem = UIBarButtonItem(customView: phaseListButtonView!)
            
            self.navigationItem.setRightBarButton(downButtonItem, animated: true)
        }else{
            let downButtonItem:UIBarButtonItem = UIBarButtonItem(customView: phaseListButtonView!)
            
            self.navigationItem.setRightBarButton(downButtonItem, animated: true)
           }
        }
    func loadLeftButton(){
        let backButtonView: UIView? = UIView(frame: CGRect(0, 0, 500, 59))
        if(UIDevice.current.userInterfaceIdiom == .phone){
            backButtonView?.frame = CGRect(0, 0, UIScreen.main.bounds.width/2, 59)
        }else{
            
        }
        backButtonView?.backgroundColor = UIColor.clear
//        backButtonView?.backgroundColor = UIColor.red
       
        // BackButton Button
        let backbuttonImage: UIImage? = UIImage(named: "Back-ArrowRED")
        let backButton:UIButton = UIButton(type: UIButton.ButtonType.custom) as UIButton
        backButton.frame = CGRect(0, 15, 32, 32)
        if(UIDevice.current.userInterfaceIdiom == .phone){
            backButton.frame = CGRect(0, 12, 20, 20)
        }
        if(UIDevice.current.userInterfaceIdiom == .pad){
            backButton.addTarget(self, action: #selector(backButtonAction), for: UIControl.Event.touchUpInside)
        }else{
            backButton.addTarget(self, action: #selector(backButtonAction), for: UIControl.Event.touchUpInside)
            let gesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(backButtonAction))
            gesture.numberOfTapsRequired = 1
            backButtonView?.addGestureRecognizer(gesture)
        }
        backButton.setTitle("", for: UIControl.State.normal)
        backButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        backButtonView?.addSubview(backButton)
        // BackButton Label
        let backButtonLabel: UILabel? = UILabel(frame: CGRect(50, 0, 400, 59))
        backButtonView?.addSubview(backButtonLabel!)
        backButtonLabel?.font  = UIFont(name: Utils.SCREEN_TITLE_FONT_NAME, size: Utils.SCREEN_TITLE_FONT_SIZE)
        if(UIDevice.current.userInterfaceIdiom == .phone){
            backButtonLabel?.font  = UIFont(name: Utils.SCREEN_TITLE_FONT_NAME, size: Utils.SCREEN_TITLE_FONT_SIZE_IPHONE)
            backButtonLabel?.frame=CGRect(50, 0, 400, 49)
        }
        backButtonLabel?.textColor = Utils.colorWithHexString(hex: Utils.RED_COLOR)
        backButtonLabel?.textAlignment = .left
        
        let myCustomBackButtonItem:UIBarButtonItem = UIBarButtonItem(customView: backButtonView!)
        self.navigationItem.leftBarButtonItem  = myCustomBackButtonItem
      
        backButton.setBackgroundImage(backbuttonImage, for: UIControl.State.normal)
        switch animationIndex {
            
        case 0:
            scene = CoagulationCascadeCoagulationCascadeScene()
            backButtonLabel?.text = "Coagulation Cascade"
        case 1:
            scene = CoagulationCascadePrimaryHaemostasisScene()
            backButtonLabel?.text = "Primary Haemostasis"
        case 2:
            scene = CoagulationCascadeFibrinFormationScene()
            backButtonLabel?.text = "Fibrin Formation & Fibrinolysis"
            //Exceptionnaly - Some titles are too long
            //phaseButtonLabel?.font  = UIFont(name: Utils.SCREEN_TITLE_FONT_NAME, size: Utils.SCREEN_TITLE_FONT_SIZE - 10)
        case 3:
            scene = CoagulationCascadeInhibitorsOfCoagulationScene()
            backButtonLabel?.text = "Inhibitors of Coagulation"
        case 4:
            scene = CoagulationCascadeAnticoagulantsScene()
            backButtonLabel?.text = "Anticoagulants"
        default:
            scene = CoagulationCascadeCoagulationCascadeScene()
            backButtonLabel?.text = "Coagulation Cascade"
        }
    }
//
    // MARK: Override bloc
    override func viewDidAppear(_ animated: Bool) {
    print("viewDidAppear",UIScreen.main.bounds.width)
      super.viewDidAppear(animated)
        let value = UIInterfaceOrientation.landscapeLeft.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        UIView.setAnimationsEnabled(true)
        reloadloadRightButton()
//        loadRightButton()
//        phaseButtonLabel?.frame =  CGRect(-210, -2, UIScreen.main.bounds.width/3, 49)
//        downImageView?.frame = CGRect(phaseButtonLabel!.frame.width-198 , 20, 8, 7)
    
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("viewDidLoad")
        // Set the orientation to always landscape
//        let orient = UIApplication.shared.statusBarOrientation
//        switch orient {
//        case .landscapeLeft:
//            break
//        case .landscapeRight:
//            break
//        default:
//            let value = UIInterfaceOrientation.landscapeLeft.rawValue
//            UIDevice.current.setValue(value, forKey: "orientation")
//        }
        let value = UIInterfaceOrientation.landscapeLeft.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        
        // Left menu: Phase list
        //let backButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "Back-ArrowRED"), style: .Plain, target: self, action: "backButtonAction")
        //backButton.setTitleTextAttributes([NSFontAttributeName : UIFont(name: Utils.SCREEN_TITLE_FONT_NAME, size: Utils.SCREEN_TITLE_FONT_SIZE)!,
         //   NSForegroundColorAttributeName : Utils.colorWithHexString(Utils.RED_COLOR)], forState: UIControlState.Normal)
        
        
        // BackButton View Container
      
        loadLeftButton()
        loadRightButton()
        // Right menu: Phase list
        // Phase View Container
//        let phaseListButtonView: UIView?
//        if(UIDevice.current.userInterfaceIdiom == .phone){
//            phaseListButtonView = UIView(frame: CGRect(0, 0, UIScreen.main.bounds.width/5, 59))
//        }else{
//            phaseListButtonView =  UIView(frame: CGRect(0, 0, 500, 59))
//        }
//        phaseListButtonView?.backgroundColor = UIColor.clear
//
//        // Down Button image
//        if(UIDevice.current.userInterfaceIdiom == .phone){
//            downImageView = UIImageView(frame:CGRect(130, 22, 8, 7));
//        }else{
//            downImageView = UIImageView(frame:CGRect(470, 25, 13, 12));
//        }
//
//        downImageView!.image = UIImage(named:"down-arrowRED")
//
//        phaseListButtonView?.addSubview(downImageView!)
//
//        let downButton:UIButton = UIButton(type: UIButton.ButtonType.custom) as UIButton
//        downButton.frame = CGRect(0, 0, 500, 59)
//        if(UIDevice.current.userInterfaceIdiom == .phone){
//            downButton.frame = CGRect(0, 0, UIScreen.main.bounds.width/3, 49)
//            //downButton.semanticContentAttribute = .forceRightToLeft
//        }else{
//            downButton.frame = CGRect(0, 0, 500, 59)
//        }
//        downButton.addTarget(self, action: #selector(showPhaseList), for: UIControl.Event.touchUpInside)
//        downButton.setTitle("", for: UIControl.State.normal)
//        downButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
//        downButton.backgroundColor = UIColor.clear
//        phaseListButtonView?.addSubview(downButton)
//
//        // DownButton Label
//
//        if(UIDevice.current.userInterfaceIdiom == .phone){
//            phaseButtonLabel = UILabel(frame: CGRect(-110, -2, UIScreen.main.bounds.width/3, 49))
//        }else{
//            phaseButtonLabel = UILabel(frame: CGRect(50, 0, 400, 59))
//        }
//        phaseButtonLabel?.font  = UIFont(name: Utils.SCREEN_TITLE_FONT_NAME, size: Utils.SCREEN_TITLE_FONT_SIZE)
//        if(UIDevice.current.userInterfaceIdiom == .phone){
//            phaseButtonLabel?.font  = UIFont(name: Utils.SCREEN_TITLE_FONT_NAME, size: Utils.SCREEN_TITLE_FONT_SIZE_IPHONE)
//        }
//        phaseButtonLabel?.textColor = Utils.colorWithHexString(hex: Utils.RED_COLOR)
//        phaseButtonLabel?.textAlignment = .right
//        if(UIDevice.current.userInterfaceIdiom == .phone){
//            phaseButtonLabel?.textAlignment = .right
//            print("frame phaseButton",phaseButtonLabel?.frame.width)
//            downImageView?.frame = CGRect(phaseButtonLabel!.frame.width-98 , 20, 8, 7)
//        }
//        phaseButtonLabel?.backgroundColor = UIColor.clear
//        phaseButtonLabel?.adjustsFontSizeToFitWidth = true
//
//        phaseListButtonView?.addSubview(phaseButtonLabel!)
//
//
//        let downButtonItem:UIBarButtonItem = UIBarButtonItem(customView: phaseListButtonView!)
//        self.navigationItem.setRightBarButton(downButtonItem, animated: true)
        
       
        scene.sceneDelegate = self
        currentSceneData = scene.sceneData
        
        //phaseButtonLabel!.text = currentSceneData.phaseList[0]
        
        infoSequenceView?.isHidden = true
        infoNodeSequenceView?.isHidden = true
        
        // Setup animation slider
        self.setupTimelineSlider()
//        var sW = CGFloat(1024)
//        var h = CGFloat(648)
//        if(sW < UIScreen.main.bounds.width){
//            h = h + UIScreen.main.bounds.width - sW
//            sW = UIScreen.main.bounds.width
//        }
//        
//        self.sceneView!.frame = CGRect(0 ,0 , sW, h)
//        scene.frame = CGRect(0 ,0 , sW, h)
        //self.sceneView!.frame = CGRect(0, 0, 1024, 648)
        //scene.frame = CGRect(x: 0, y: 0, width: 1024, height: 648)
        sceneView!.addSubview(scene)
        if(UIDevice.current.userInterfaceIdiom == .pad){
            scene.frame = sceneView!.frame
            scene.subviews[0].frame = sceneView!.frame
        }else{
            let sW = CGFloat(UIScreen.main.bounds.width)
            let h = CGFloat(364*UIScreen.main.bounds.height/414)
            let frame = CGRect(0 ,0 , sW, h)
            scene.frame = frame
            scene.subviews[0].frame = frame
        }
      
        
//        print("sceneFrame",sceneView!.frame)
//        print("sceneFrame2",scene.subviews[0].frame)
//        print("screenWidth",UIScreen.main.bounds)
        scene.isUserInteractionEnabled = true
        scene.isExclusiveTouch = true
        sceneView!.isUserInteractionEnabled = true
        sceneView!.isExclusiveTouch = true
        phaseButtonLabel!.text = ""
        downImageView!.isHidden = true
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.gScene = scene
        
        // Setup Zoom Feature
        // Pinching
        let pinchRecognizer = UIPinchGestureRecognizer(target:self, action:#selector(pinchAction))
        self.sceneView!.addGestureRecognizer(pinchRecognizer)
        
        // Simple tapping
        let simpleTap = UITapGestureRecognizer(target:self, action:#selector(simpleTappedAction))
        simpleTap.numberOfTapsRequired = 1
        if(UIDevice.current.userInterfaceIdiom == .pad){
            self.sceneView!.addGestureRecognizer(simpleTap)
        }
        
        // Double tapping
        let doubleTap = UITapGestureRecognizer(target:self, action:#selector(doubleTappedAction))
        doubleTap.numberOfTapsRequired = 2
        self.sceneView!.addGestureRecognizer(doubleTap)
        
        simpleTap.require(toFail: doubleTap)
        
        if(UIDevice.current.userInterfaceIdiom == .phone){
            self.goToEnd()
        }
    }
  
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("Memory warning detected")
    }
    
    
    override var shouldAutorotate: Bool {
        return true    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.landscapeLeft
    }
    
    // MARK: Private methods
    @objc func countUp() {
        if(UIDevice.current.userInterfaceIdiom == .pad){
            UIView.animate(withDuration: 2.0, animations: {
                self.videoSlider?.setValue(self.currentTimeline, animated: true)
            })
            currentTimeline += 1
            reloadPhaseInfos()
            
            // Detect if it is the end of the animation
            if currentTimeline > currentSceneData.totalDuration {
                scene.showNodeHighlight()
                sceneTimer.invalidate()
                scene.pauseScene()
                let imageButton = UIImage(named: "CoagCascadePlayerPlay") as UIImage?
                playPauseButton?.setImage(imageButton, for: .normal)
                phaseButtonLabel!.text = ""
                downImageView!.isHidden = true
                
                
                // Hack !!
                if isSliderChangedManually == true {
                    self.videoSlider?.setValue(currentSceneData.totalDuration + 3, animated: true)
                    isSliderChangedManually = false
                }
            }
        }
    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if(UIDevice.current.userInterfaceIdiom == .phone){
            UIView.setAnimationsEnabled(false)
            UIDevice.current.setValue(UIInterfaceOrientation.landscapeLeft.rawValue, forKey: "orientation")
           // UIView.setAnimationsEnabled(true)
            print("viewDidTransition")
            reloadloadRightButton()
        }
    }
    func attributedText(text: String)->NSAttributedString {
        let attributedString = NSMutableAttributedString(string: text as String, attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 14.0)])
        let boldFontAttribute = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14.0)]
        
        let textArr = text.characters.split{$0 == ":"}.map(String.init)
        
        attributedString.addAttributes(boldFontAttribute, range: NSRange(location: 0, length: textArr[0].characters.count))
        
        return attributedString
    }
    
    func showNodeInformation(node: String) {
        print("Show node2")
        infoNodeSequenceView?.isHidden = false
        
        infoNodeSequenceLabel?.text = node
        infoNodeSequenceLabel?.attributedText = attributedText(text: node)
    }
    
    func onItemSelection(name node: CoagulationCascadeNodeModel) {
        
        print("Show node")
        if(UIDevice.current.userInterfaceIdiom == .pad){
            sceneTimer.invalidate()
            let imageButton = UIImage(named: "CoagCascadePlayerPlay") as UIImage?
            playPauseButton?.setImage(imageButton, for: .normal)
        }
        
        showNodeInformation(node: node.nodeDescription)
    }
    
    @objc func pinchAction(pinchRecognizer: UIPinchGestureRecognizer) {
        var scale: CGFloat = pinchRecognizer.scale;
//        self.currentZoom = scale
        let h = UIScreen.main.bounds.height;
        let w = UIScreen.main.bounds.width;
        print("zoom:\(scale) | pic:\(self.pic) ")
        if (scale > 2.0) {
            scale = CGFloat(2.0)
            self.currentZoom = 2.0
            self.pic = 2
            
        }
        else if (scale < 1.0) {
            
//            let diff:CGFloat = 1.0 - scale;
//            scale = CGFloat(1.0)
//
//            self.currentDeZoom = self.currentDeZoom - 0.01
//            if(self.currentDeZoom <= 1.0){
//                self.currentZoom = 1.0
//
//                self.sceneView!.transform = CGAffineTransform.identity.scaledBy(x: 1.0, y: 1.0);
//                self.sceneView!.center = CGPoint(333.5*w/667,167*h/375)
//                print("tonga")
//
//            }else{
//                print("mihena ",self.currentDeZoom)
//                self.sceneView!.transform = CGAffineTransform.identity.scaledBy(x: self.currentDeZoom ,y: self.currentDeZoom)
//            }
           
                
            
         
           
        }else{
            self.currentDeZoom = self.currentZoom
        }
        self.previousZoom = self.currentZoom
      
       
//
//        print("pic:",self.pic)
        if(pic == 2){
    //            if(self.previousZoom>=self.currentZoom){
    //                self.sceneView!.transform = CGAffineTransform.identity.scaledBy(x: scale, y: scale)
    //            }
            
        }
        else if(self.pic<scale){
           
            self.pic = scale
            self.sceneView!.transform = CGAffineTransform.identity.scaledBy(x: scale ,y: scale)
            
        }else{
         
            if(self.previousZoom<self.currentZoom){
                print("eto nigga")
                self.sceneView!.transform = CGAffineTransform.identity.scaledBy(x: scale, y: scale)
            }
        }
        
        
        
        
        self.previousZoomScale = scale
//        if(pinchRecognizer.state == UIGestureRecognizer.State.began) {
//            if(self.previousZoom != self.currentZoom){
//                if self.currentZoom <= 1.0 {
//                    print("nihena lery ")
//    //                    self.sceneView!.center = CGPoint(333.5*w/1334,167*h/666)
//                    UIView.animate(withDuration: 7, animations: {
////                        self.sceneView!.transform = CGAffineTransform.identity.scaledBy(x: self.currentZoom, y: self.currentZoom);
//                        self.sceneView!.transform = CGAffineTransform.identity.scaledBy(x: 1.0, y: 1.0);
//                        self.sceneView!.center = CGPoint(333.5*w/667,167*h/375)
//                    })
//
//
//                }
//
//            }
//
//
//        }
    }
    
    @objc func doubleTappedAction(recognizer: UITapGestureRecognizer) {
//        print ("double tap ",self.currentZoom)
        if self.currentZoom < 2.0 {
            self.currentZoom = CGFloat(2.0)
        }
        else   {
            self.currentZoom = CGFloat(1.0)
            
        }
//        var h:CGFloat = self.sceneView!.frame.size.height
//        var w:CGFloat = self.sceneView!.frame.size.width
        
            let h = UIScreen.main.bounds.height;
            let w = UIScreen.main.bounds.width;
//        var hc:CGFloat = self.containerView!.frame.size.height
//        var wc:CGFloat = self.containerView!.frame.size.width
       print("width: \(w) ")
       print("height: \(h)")
        // w=1334 h=666
        if(recognizer.state == UIGestureRecognizer.State.ended) {
            UIView.animate(withDuration: 1.0, animations: {
                self.sceneView!.transform = CGAffineTransform.identity.scaledBy(x: self.currentZoom, y: self.currentZoom);
                var k:CGFloat = 296
                if(UIDevice.current.userInterfaceIdiom == .pad){
                    k = 280
                }
                
                if self.currentZoom <= 1.0 {
                    self.sceneView!.center = CGPoint(667*w/1334,k*h/666)
                    self.sceneView!.transform = CGAffineTransform.identity.scaledBy(x: 1.0, y: 1.0);
                    self.pic = 1.0
                    
                }
                
            },completion: {(finished : Bool) in
//                h = self.sceneView!.frame.size.height
//                w = self.sceneView!.frame.size.width
//                hc = self.containerView!.frame.size.height
//                wc = self.containerView!.frame.size.width
//                print("widthVita: \(w) vs \(wc)")
//                print("heightVita: \(h) vs \(hc)")
            })
        }
    }
    
    @objc func simpleTappedAction(recognizer: UITapGestureRecognizer) {
        // Detect if it is the end of the animation
        if currentTimeline > currentSceneData.totalDuration {
            currentTimeline = 0
            self.playScene()
        }
        else {
            if isPlaying {
                self.pauseScene()
            }
            else {
                self.playScene()
            }
        }
    }
    
    // MARK: TableView Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentSceneData.phaseList.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: textCellIdentifier, for: indexPath as IndexPath)
        let row = indexPath.row
        cell.textLabel?.text = currentSceneData.phaseList[row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //_ = tableView.dequeueReusableCell(withIdentifier: textCellIdentifier, for: indexPath as IndexPath)
        //_ = indexPath.row
        
        hidePhaseList()
        if(UIDevice.current.userInterfaceIdiom == .pad){
            var previousPhaseTimeline:Float = 0.0
            if indexPath.row > 0 {
                previousPhaseTimeline = currentSceneData.phaseTimelineList[indexPath.row - 1]
            }
            
            self.currentTimeline = previousPhaseTimeline
            self.playScene()

                
            
            phaseButtonLabel!.text = currentSceneData.phaseList[indexPath.row]
        }
        if(UIDevice.current.userInterfaceIdiom == .phone){
            scene.hideNodeHighlight()
            var previousPhaseTimeline:Float = 0.0
            if(indexPath.row == currentSceneData.phaseTimelineList.count-1){
                previousPhaseTimeline = currentSceneData.totalDuration
            }
            else  {
                previousPhaseTimeline = currentSceneData.phaseTimelineList[indexPath.row]
            }
            
            self.currentTimeline = previousPhaseTimeline
            self.playScene()
            //scene.showNodeHighlight()
            self.pauseScene()
            phaseButtonLabel!.text = currentSceneData.phaseList[indexPath.row]
        }
        
        // Update the timeline slider
        self.videoSlider?.setValue(self.currentTimeline, animated: false)
    }
    
    // Private Methods
    private func playScene() {
        isPlaying = true
        sceneTimer.invalidate()
        sceneTimer = Timer.scheduledTimer(timeInterval: 1.0,target: self, selector: #selector(countUp), userInfo: nil, repeats: true)
        RunLoop.current.add(sceneTimer, forMode: RunLoop.Mode.common)
        sceneTimer.fire()
        scene.playSceneAt(time: currentTimeline)
        
        // Update Button Status
        let imageButton = UIImage(named: "CoagCascadePlayerPause") as UIImage?
        playPauseButton?.setImage(imageButton, for: .normal)
        scene.hideNodeHighlight()
    }
    
    private func pauseScene() {
        isPlaying = false
        sceneTimer.invalidate()
        scene.pauseScene()
        
        // Update Button Status
        let imageButton = UIImage(named: "CoagCascadePlayerPlay") as UIImage?
        playPauseButton?.setImage(imageButton, for: .normal)
        scene.showNodeHighlight()
    }
    
    func setupTimelineSlider() {
        videoSlider?.isContinuous = true
        videoSlider?.minimumValue = 0.0
        videoSlider?.maximumValue = currentSceneData.totalDuration
    }
    
    @objc func showPhaseList() {
        if currentTimeline <= currentSceneData.totalDuration {
            if phaseListView?.isHidden == true {
                phaseListView?.isHidden = false
               
                    reloadPhaseInfos()
                
            }
            else {
                phaseListView?.isHidden = true
            }
        }
    }
    
    func hidePhaseList() {
        phaseListView?.isHidden = true
    }
    func changePhaseInfos(){
        print("change phase info",phaseButtonLabel!.text);
        for i:Int in 0 ..< currentSceneData.phaseList.count {
            if(phaseButtonLabel?.text == currentSceneData.phaseList[i]){
                phaseDescLabel?.text = currentSceneData.phaseDescription[i]
                phaseTitleLabel?.text = currentSceneData.phaseList[i]
                print("return ",phaseButtonLabel!.text);
                return
            }
            /*
            else if (currentTimeline >= currentSceneData.totalDuration) {
                phaseButtonLabel!.text = ""
            }
            */
        }
//        if (currentTimeline >= currentSceneData.totalDuration) {
//            phaseButtonLabel!.text = ""
//            if(UIDevice.current.userInterfaceIdiom == .phone){
//                phaseTitleLabel?.text = currentSceneData.phaseList.last
//                phaseDescLabel?.text = currentSceneData.phaseDescription.last
//                phaseButtonLabel!.text = currentSceneData.phaseList.last
//            }
//        }
    }
    
    func reloadPhaseInfos() {
        
        print("reload");
        
        
        for i:Int in 0 ..< currentSceneData.phaseTimelineList.count {
            if currentTimeline <= currentSceneData.phaseTimelineList[0] {
                phaseTitleLabel?.text = currentSceneData.phaseList[0]
                phaseDescLabel?.text = currentSceneData.phaseDescription[0]
                phaseButtonLabel!.text = currentSceneData.phaseList[0]
            }
            else if (currentTimeline >= currentSceneData.phaseTimelineList.last!) {
                phaseTitleLabel?.text = currentSceneData.phaseList.last
                phaseDescLabel?.text = currentSceneData.phaseDescription.last
                phaseButtonLabel!.text = currentSceneData.phaseList.last
            }
            else if currentTimeline >= currentSceneData.phaseTimelineList[i] && currentTimeline <= currentSceneData.phaseTimelineList[i + 1] {
                if(UIDevice.current.userInterfaceIdiom == .pad){
                    phaseTitleLabel?.text = currentSceneData.phaseList[i + 1]
                    phaseDescLabel?.text = currentSceneData.phaseDescription[i + 1]
                        phaseButtonLabel!.text = currentSceneData.phaseList[i + 1]
                    
                }
                if(UIDevice.current.userInterfaceIdiom == .phone){
                    phaseTitleLabel?.text = currentSceneData.phaseList[i]
                    phaseDescLabel?.text = currentSceneData.phaseDescription[i]
                        phaseButtonLabel!.text = currentSceneData.phaseList[i]
                    
                    
                }
            }
            /*
            else if (currentTimeline >= currentSceneData.totalDuration) {
                phaseButtonLabel!.text = ""
            }
            */
        }
        if (currentTimeline >= currentSceneData.totalDuration) {
            phaseButtonLabel!.text = ""
            if(UIDevice.current.userInterfaceIdiom == .phone){
                phaseTitleLabel?.text = currentSceneData.phaseList.last
                phaseDescLabel?.text = currentSceneData.phaseDescription.last
                phaseButtonLabel!.text = currentSceneData.phaseList.last
            }
        }
        if(UIDevice.current.userInterfaceIdiom == .phone){
            infoSequenceView?.isHidden = true
        }
//        phaseDescLabel?.text = "Test nigga"
        phaseDescLabel?.sizeToFit()
        phaseDescScrollView?.contentSize = CGSize(width: 0, height: (phaseDescLabel?.frame.height)! + 20.0)
        downImageView?.isHidden = phaseButtonLabel!.text!.isEmpty
    }
    
    @objc func backButtonAction() {
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
    }
    private func goToEnd()
    {
        currentTimeline = currentSceneData.totalDuration
        scene.playSceneAt(time: currentTimeline)
        scene.showNodeHighlight()
        videoSliderView?.isHidden = true
        reloadPhaseInfos();
    }
    // MARK: User Action
    @IBAction func videoSliderOnChangeAction(sender: UISlider) {
        isSliderChangedManually = true
        let videoSliderCurrentValue = sender.value
        currentTimeline = videoSliderCurrentValue
        
        if isPlaying {
            self.pauseScene()
        }
        
        self.playScene()
        self.pauseScene()
        reloadPhaseInfos()
        print("timeline:" + String(currentTimeline))
    }
    @IBAction func playPauseButtonAction(sender: UIButton) {
        // Detect if it is the end of the animation
        if currentTimeline > currentSceneData.totalDuration {
            currentTimeline = 0
            self.playScene()
        }
        else {
            if isPlaying {
                self.pauseScene()
            }
            else {
                self.playScene()
            }
        }
    }
    
    
    @IBAction func rewindButtonAction(sender: UIButton) {
        for i in 0..<currentSceneData.phaseTimelineList.count {
            if currentTimeline <= currentSceneData.phaseTimelineList[0] {
                currentTimeline = 0
                break
                // First phase, nothing todo
            }
            else if (currentTimeline >= currentSceneData.phaseTimelineList.last!) {
                currentTimeline = currentSceneData.phaseTimelineList[currentSceneData.phaseTimelineList.count - 1]
                break
            }
            else if currentTimeline >= currentSceneData.phaseTimelineList[i] && currentTimeline <= currentSceneData.phaseTimelineList[i + 1] {
                if i == 0 {
                    currentTimeline = 0
                }
                else {
                    currentTimeline = currentSceneData.phaseTimelineList[i - 1]
                }
                break
            }
        }
        
        self.playScene()
    }
    
    @IBAction func forwardButtonAction(sender: UIButton) {
        for i in 0..<currentSceneData.phaseTimelineList.count{
            if currentTimeline <= currentSceneData.phaseTimelineList[0] {
                currentTimeline = currentSceneData.phaseTimelineList[1]
                break
            }
            else if (currentTimeline >= currentSceneData.phaseTimelineList.last!) {
                break
            }
            else if currentTimeline >= currentSceneData.phaseTimelineList[i] && currentTimeline < currentSceneData.phaseTimelineList[i + 1] {
                currentTimeline = currentSceneData.phaseTimelineList[i + 1]
                break
            }
        }
        
        self.playScene()
    }
    
    @IBAction func infoSequenceButton(sender: UIButton) {
       
        if(UIDevice.current.userInterfaceIdiom == .phone){
            self.changePhaseInfos();
        }
        if currentTimeline > 0.0 && currentTimeline <= currentSceneData.totalDuration {
            if infoSequenceView?.isHidden == false {
                infoSequenceView?.isHidden = true
            }
            else {
                infoSequenceView?.isHidden = false
            }
        }
//        if(UIDevice.current.userInterfaceIdiom == .phone){
//            if infoSequenceView?.isHidden == false {
//                infoSequenceView?.isHidden = true
//            }
//            else {
//                infoSequenceView?.isHidden = false
//            }
//        }
        if isPlaying {
            self.pauseScene()
        }
        else {
            self.playScene()
        }
    }
    
    @IBAction func infoNodeSequenceButton(sender: UIButton) {
        if infoNodeSequenceView?.isHidden == false {
            infoNodeSequenceView?.isHidden = true
        }
        else {
            infoNodeSequenceView?.isHidden = false
        }
    }
    
    @IBAction func handlePan(_ recognizer: UIPanGestureRecognizer) {
        
        var _x: CGFloat = 0.0
        var _y: CGFloat
        let h = UIScreen.main.bounds.height;
        let w = UIScreen.main.bounds.width;
//        print("width: \(w) ")
//        print("height: \(h) ")
        if currentZoom >= 2.0 {
            let translation = recognizer.translation(in: self.view)
            if let view = recognizer.view {
                if view.frame.origin.x >= -10 {
                    _x = -3.0
                }
                else {
                    _x = translation.x
                }
                
                if view.frame.origin.x <= -650 * w / 667 {
                    _x = 3.0
                }
                
                if view.frame.origin.y >= 0 {
                    _y = -1.0
                }
                else {
                    _y = translation.y + 1
                }
                
                if view.frame.origin.y <= -570.0 * h / 375 {
                    _y = 1.0
                    
                }
                
                if view.frame.origin.y <= -325 * h / 375 {
                    _y = 3.0
                }
                print("pan  frame:",view.frame.origin.x)
                view.center = CGPoint(x:view.center.x + _x,
                                      y:view.center.y + _y)
            }
            recognizer.setTranslation(CGPoint(0,0), in: self.sceneView)
        }
    }
}
