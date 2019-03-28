//
//  CoagulationCascadeVideoPlayerViewController.swift
//  iHemostasis
//
//  Created by Zo Rajaonarivony on 16/12/2015.
//  Copyright © 2015 Diagnostica Stago S.A.S. All rights reserved.
//

import UIKit
import SpriteKit

class CoagulationCascadePlayerViewController: UIViewController, ParentSceneDelegate {
    // UI Logic
    @IBOutlet weak var videoSlider : UISlider?
    @IBOutlet weak var sceneView : UIView?
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
    let textCellIdentifier = "textCellIdentifier"
    var phaseButtonLabel: UILabel?
    var downImageView: UIImageView?
    
    // Business Logic
    var scene = ParentScene()
    var sceneTimer = NSTimer()
    var sceneFileName = String()
    var isPlaying : Bool = false
    var animationIndex: Int = 0
    var currentTimeline: Float = 0.0
    var currentZoom: CGFloat = 1.0
    var isSliderChangedManually = false
    
    var currentSceneData = CoagulationCascadeSceneModel()
    
    
    // MARK: Override bloc
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Set the orientation to always landscape
        let orient = UIApplication.sharedApplication().statusBarOrientation
        switch orient {
        case .LandscapeLeft:
            break
        case .LandscapeRight:
            break
        default:
            let value = UIInterfaceOrientation.LandscapeLeft.rawValue
            UIDevice.currentDevice().setValue(value, forKey: "orientation")
        }
        
        // Left menu: Phase list
        //let backButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "Back-ArrowRED"), style: .Plain, target: self, action: "backButtonAction")
        //backButton.setTitleTextAttributes([NSFontAttributeName : UIFont(name: Utils.SCREEN_TITLE_FONT_NAME, size: Utils.SCREEN_TITLE_FONT_SIZE)!,
         //   NSForegroundColorAttributeName : Utils.colorWithHexString(Utils.RED_COLOR)], forState: UIControlState.Normal)
        
        
        // BackButton View Container
        let backButtonView: UIView? = UIView(frame: CGRectMake(0, 0, 500, 59))
        backButtonView?.backgroundColor = UIColor.clearColor()
        
        // BackButton Button
        let backbuttonImage: UIImage? = UIImage(named: "Back-ArrowRED")
        let backButton:UIButton = UIButton(type: UIButtonType.Custom) as UIButton
        backButton.frame = CGRectMake(0, 15, 32, 32)
        backButton.addTarget(self, action: "backButtonAction", forControlEvents: UIControlEvents.TouchUpInside)
        backButton.setTitle("", forState: UIControlState.Normal)
        backButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        backButtonView?.addSubview(backButton)
        // BackButton Label
        let backButtonLabel: UILabel? = UILabel(frame: CGRectMake(50, 0, 400, 59))
        backButtonView?.addSubview(backButtonLabel!)
        backButtonLabel?.font  = UIFont(name: Utils.SCREEN_TITLE_FONT_NAME, size: Utils.SCREEN_TITLE_FONT_SIZE)
        backButtonLabel?.textColor = Utils.colorWithHexString(Utils.RED_COLOR)
        backButtonLabel?.textAlignment = .Left
        
        let myCustomBackButtonItem:UIBarButtonItem = UIBarButtonItem(customView: backButtonView!)
        self.navigationItem.leftBarButtonItem  = myCustomBackButtonItem
        backButton.setBackgroundImage(backbuttonImage, forState: .Normal)
        
        
        // Right menu: Phase list
        // Phase View Container
        let phaseListButtonView: UIView? = UIView(frame: CGRectMake(0, 0, 500, 59))
        phaseListButtonView?.backgroundColor = UIColor.clearColor()
        
        // Down Button image
        downImageView = UIImageView(frame:CGRectMake(470, 25, 13, 12));
        downImageView!.image = UIImage(named:"down-arrowRED")
        phaseListButtonView?.addSubview(downImageView!)
        
        let downButton:UIButton = UIButton(type: UIButtonType.Custom) as UIButton
        downButton.frame = CGRectMake(0, 0, 500, 59)
        downButton.addTarget(self, action: "showPhaseList", forControlEvents: UIControlEvents.TouchUpInside)
        downButton.setTitle("", forState: UIControlState.Normal)
        downButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        downButton.backgroundColor = UIColor.clearColor()
        phaseListButtonView?.addSubview(downButton)
        
        // DownButton Label
        phaseButtonLabel = UILabel(frame: CGRectMake(50, 0, 400, 59))
        phaseButtonLabel?.font  = UIFont(name: Utils.SCREEN_TITLE_FONT_NAME, size: Utils.SCREEN_TITLE_FONT_SIZE)
        phaseButtonLabel?.textColor = Utils.colorWithHexString(Utils.RED_COLOR)
        phaseButtonLabel?.textAlignment = .Right
        phaseButtonLabel?.backgroundColor = UIColor.clearColor()
        phaseButtonLabel?.adjustsFontSizeToFitWidth = true
        phaseListButtonView?.addSubview(phaseButtonLabel!)
        
        
        let downButtonItem:UIBarButtonItem = UIBarButtonItem(customView: phaseListButtonView!)
        self.navigationItem.setRightBarButtonItem(downButtonItem, animated: true)
        
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
        scene.sceneDelegate = self
        currentSceneData = scene.sceneData
        
        //phaseButtonLabel!.text = currentSceneData.phaseList[0]
        
        infoSequenceView?.hidden = true
        infoNodeSequenceView?.hidden = true
        
        // Setup animation slider
        self.setupTimelineSlider()
        
        self.sceneView!.frame = CGRectMake(0, 0, 1024, 648)
        scene.frame = CGRect(x: 0, y: 0, width: 1024, height: 648)
        sceneView!.addSubview(scene)
        scene.userInteractionEnabled = true
        scene.exclusiveTouch = true
        sceneView!.userInteractionEnabled = true
        sceneView!.exclusiveTouch = true
        
        phaseButtonLabel!.text = ""
        downImageView!.hidden = true
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.gScene = scene
        
        // Setup Zoom Feature
        // Pinching
        let pinchRecognizer = UIPinchGestureRecognizer(target:self, action:"pinchAction:")
        self.sceneView!.addGestureRecognizer(pinchRecognizer)
        
        // Simple tapping
        let simpleTap = UITapGestureRecognizer(target:self, action:"simpleTappedAction:")
        simpleTap.numberOfTapsRequired = 1
        self.sceneView!.addGestureRecognizer(simpleTap)
        
        // Double tapping
        let doubleTap = UITapGestureRecognizer(target:self, action:"doubleTappedAction:")
        doubleTap.numberOfTapsRequired = 2
        self.sceneView!.addGestureRecognizer(doubleTap)
        
        simpleTap.requireGestureRecognizerToFail(doubleTap)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("Memory warning detected")
    }
    
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.LandscapeLeft
    }
    
    // MARK: Private methods
    func countUp() {
        UIView.animateWithDuration(2.0, animations: {
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
            playPauseButton?.setImage(imageButton, forState: .Normal)
            phaseButtonLabel!.text = ""
            downImageView!.hidden = true
            
            // Hack !!
            if isSliderChangedManually == true {
                self.videoSlider?.setValue(currentSceneData.totalDuration + 3, animated: true)
                isSliderChangedManually = false
            }
        }
    }

    func attributedText(text: String)->NSAttributedString {
        let attributedString = NSMutableAttributedString(string: text as String, attributes: [NSFontAttributeName:UIFont.systemFontOfSize(14.0)])
        let boldFontAttribute = [NSFontAttributeName: UIFont.boldSystemFontOfSize(14.0)]
        
        let textArr = text.characters.split{$0 == ":"}.map(String.init)
        
        attributedString.addAttributes(boldFontAttribute, range: NSRange(location: 0, length: textArr[0].characters.count))
        
        return attributedString
    }
    
    func showNodeInformation(node: String) {
        infoNodeSequenceView?.hidden = false
        
        infoNodeSequenceLabel?.text = node
        infoNodeSequenceLabel?.attributedText = attributedText(node)
    }
    
    func onItemSelection(node: CoagulationCascadeNodeModel) {
        sceneTimer.invalidate()
        let imageButton = UIImage(named: "CoagCascadePlayerPlay") as UIImage?
        playPauseButton?.setImage(imageButton, forState: .Normal)
        
        showNodeInformation(node.nodeDescription)
    }
    
    func pinchAction(pinchRecognizer: UIPinchGestureRecognizer) {
        var scale: CGFloat = pinchRecognizer.scale;
        if (scale > 2.0) {
            scale = CGFloat(2.0)
            self.currentZoom = 2.0
        }
        else if (scale < 1.0) {
            scale = CGFloat(1.0)
            self.currentZoom = 1.0
        }
        
        self.sceneView!.transform = CGAffineTransformScale(CGAffineTransformIdentity, scale, scale);

        if(pinchRecognizer.state == UIGestureRecognizerState.Began) {
            UIView.animateWithDuration(0.2, animations: {
                self.sceneView!.transform = CGAffineTransformScale(CGAffineTransformIdentity, self.currentZoom, self.currentZoom);
                if self.currentZoom <= 1.0 {
                    //self.sceneView!.center = CGPoint(,)
                    self.sceneView!.frame = CGRectMake(0, 0, 1024, 648)
                }
                
            })
        }
    }
    
    func doubleTappedAction(recognizer: UITapGestureRecognizer) {
        if self.currentZoom <= 1.0 {
            self.currentZoom = CGFloat(2.0)
        }
        else {
            self.currentZoom = CGFloat(1.0)
            
        }
        
        if(recognizer.state == UIGestureRecognizerState.Ended) {
            UIView.animateWithDuration(1.0, animations: {
                self.sceneView!.transform = CGAffineTransformScale(CGAffineTransformIdentity, self.currentZoom, self.currentZoom);
                if self.currentZoom <= 1.0 {
                    //self.sceneView!.center = CGPoint(,)
                    self.sceneView!.frame = CGRectMake(0, 0, 1024, 648)
                }
                
            })
        }
    }
    
    func simpleTappedAction(recognizer: UITapGestureRecognizer) {
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
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentSceneData.phaseList.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(textCellIdentifier, forIndexPath: indexPath) 
        let row = indexPath.row
        cell.textLabel?.text = currentSceneData.phaseList[row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.dequeueReusableCellWithIdentifier(textCellIdentifier, forIndexPath: indexPath)
        let row = indexPath.row
        
        hidePhaseList()
        
        var previousPhaseTimeline:Float = 0.0
        if indexPath.row > 0 {
            previousPhaseTimeline = currentSceneData.phaseTimelineList[indexPath.row - 1]
        }
        
        self.currentTimeline = previousPhaseTimeline
        self.playScene()
        
        phaseButtonLabel!.text = currentSceneData.phaseList[indexPath.row]
        
        // Update the timeline slider
        self.videoSlider?.setValue(self.currentTimeline, animated: false)
    }
    
    // Private Methods
    private func playScene() {
        isPlaying = true
        sceneTimer.invalidate()
        sceneTimer = NSTimer.scheduledTimerWithTimeInterval(1.0,target: self, selector:"countUp", userInfo: nil, repeats: true)
        NSRunLoop.currentRunLoop().addTimer(sceneTimer, forMode: NSRunLoopCommonModes)
        sceneTimer.fire()
        scene.playSceneAt(currentTimeline)
        
        // Update Button Status
        let imageButton = UIImage(named: "CoagCascadePlayerPause") as UIImage?
        playPauseButton?.setImage(imageButton, forState: .Normal)
        scene.hideNodeHighlight()
    }
    
    private func pauseScene() {
        isPlaying = false
        sceneTimer.invalidate()
        scene.pauseScene()
        
        // Update Button Status
        let imageButton = UIImage(named: "CoagCascadePlayerPlay") as UIImage?
        playPauseButton?.setImage(imageButton, forState: .Normal)
        scene.showNodeHighlight()
    }
    
    func setupTimelineSlider() {
        videoSlider?.continuous = true
        videoSlider?.minimumValue = 0.0
        videoSlider?.maximumValue = currentSceneData.totalDuration
    }
    
    func showPhaseList() {
        if currentTimeline <= currentSceneData.totalDuration {
            if phaseListView?.hidden == true {
                phaseListView?.hidden = false
                reloadPhaseInfos()
            }
            else {
                phaseListView?.hidden = true
            }
        }
    }
    
    func hidePhaseList() {
        phaseListView?.hidden = true
    }
    
    func reloadPhaseInfos() {
        for i:Int in 0 ..< currentSceneData.phaseTimelineList.count {
            if currentTimeline <= currentSceneData.phaseTimelineList[0] {
                phaseTitleLabel?.text = currentSceneData.phaseList[0]
                phaseDescLabel?.text = currentSceneData.phaseDescription[0]
                phaseButtonLabel!.text = currentSceneData.phaseList[0]
            }
            else if (currentTimeline >= currentSceneData.phaseTimelineList.last) {
                phaseTitleLabel?.text = currentSceneData.phaseList.last
                phaseDescLabel?.text = currentSceneData.phaseDescription.last
                phaseButtonLabel!.text = currentSceneData.phaseList.last
            }
            else if currentTimeline >= currentSceneData.phaseTimelineList[i] && currentTimeline <= currentSceneData.phaseTimelineList[i + 1] {
                phaseTitleLabel?.text = currentSceneData.phaseList[i + 1]
                phaseDescLabel?.text = currentSceneData.phaseDescription[i + 1]
                phaseButtonLabel!.text = currentSceneData.phaseList[i + 1]
            }
            /*
            else if (currentTimeline >= currentSceneData.totalDuration) {
                phaseButtonLabel!.text = ""
            }
            */
        }
        if (currentTimeline >= currentSceneData.totalDuration) {
            phaseButtonLabel!.text = ""
        }
        
        phaseDescLabel?.sizeToFit()
        phaseDescScrollView?.contentSize = CGSize(width: 0, height: (phaseDescLabel?.frame.height)! + 20.0)
        downImageView?.hidden = phaseButtonLabel!.text!.isEmpty
    }
    
    func backButtonAction() {
        if let navController = self.navigationController {
            navController.popViewControllerAnimated(true)
        }
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
        for var i:Int = 0; i < currentSceneData.phaseTimelineList.count; i++ {
            if currentTimeline <= currentSceneData.phaseTimelineList[0] {
                currentTimeline = 0
                break
                // First phase, nothing todo
            }
            else if (currentTimeline >= currentSceneData.phaseTimelineList.last) {
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
        for var i:Int = 0; i < currentSceneData.phaseTimelineList.count; i++ {
            if currentTimeline <= currentSceneData.phaseTimelineList[0] {
                currentTimeline = currentSceneData.phaseTimelineList[1]
                break
            }
            else if (currentTimeline >= currentSceneData.phaseTimelineList.last) {
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
        if currentTimeline > 0.0 && currentTimeline < currentSceneData.totalDuration {
            if infoSequenceView?.hidden == false {
                infoSequenceView?.hidden = true
            }
            else {
                infoSequenceView?.hidden = false
            }
        }
        if isPlaying {
            self.pauseScene()
        }
        else {
            self.playScene()
        }
    }
    
    @IBAction func infoNodeSequenceButton(sender: UIButton) {
        if infoNodeSequenceView?.hidden == false {
            infoNodeSequenceView?.hidden = true
        }
        else {
            infoNodeSequenceView?.hidden = false
        }
    }
    
    @IBAction func handlePan(recognizer:UIPanGestureRecognizer) {
        var _x: CGFloat
        var _y: CGFloat
        if currentZoom >= 2.0 {
            let translation = recognizer.translationInView(self.view)
            if let view = recognizer.view {
                if view.frame.origin.x >= 0 {
                    _x = -1.0
                }
                else {
                    _x = translation.x
                }
                
                if view.frame.origin.x <= -1023.0 {
                    _x = 1.0
                }
                
                if view.frame.origin.y >= 0 {
                    _y = -1.0
                }
                else {
                    _y = translation.y
                }
                
                if view.frame.origin.y <= -570.0 {
                    _y = 1.0
                    
                }
                
                
                view.center = CGPoint(x:view.center.x + _x,
                    y:view.center.y + _y)
            }
            recognizer.setTranslation(CGPointZero, inView: self.sceneView)
        }
    }
}
