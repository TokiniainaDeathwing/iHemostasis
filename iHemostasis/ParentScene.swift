//
//  ParentScene.swift
//  iHemostasis
//
//  Created by Zo Rajaonarivony on 17/02/2016.
//  Copyright © 2016 Diagnostica Stago S.A.S. All rights reserved.
//

import UIKit

protocol ParentSceneDelegate {
    func onItemSelection(name: CoagulationCascadeNodeModel)
}

public class ParentScene: UIView {
    let kCoeffTagForHighlight = 100
    
    var sceneDelegate: ParentSceneDelegate?
    var sceneTimer = NSTimer()
    var timelineIncrementTimer = NSTimer()
    var nodeAnimationTimer = NSTimer()
    let sceneData = CoagulationCascadeSceneModel()
    var currentTimeline = 0
    var currentZoom = 1.0
    var sceneView: UIView?

    // Initialization Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initData()
    }

    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    public func initData() {
        
    }
    
    // Private methods
    private func removeAllNode() {
        for view in sceneView!.subviews {
            if view.tag != 0 {
                view.hidden = true;
            }
        }
    }
    
    private func addNodeWithTheCorrectAnimation(nodeView: UIView, nodeInfo: CoagulationCascadeNodeModel) {
        switch nodeInfo.animationType {
        case .normal:
            UIView.animateWithDuration(1.0, animations: {
                if nodeView.hidden == true {
                    nodeView.alpha = 0.0
                }
                
                nodeView.hidden = false
                nodeView.alpha = 1.0
            })
        case .translation:
            if nodeView.hidden == true {
                nodeView.hidden = false
                nodeView.frame.origin = nodeInfo.originPos!
                UIView.animateWithDuration(1.0, animations: {
                    nodeView.frame.origin = nodeInfo.destPos!
                })
            }
        case .translationAndDisappear:
            if nodeView.hidden == true {
                nodeView.hidden = false
                nodeView.frame.origin = nodeInfo.originPos!
                UIView.animateWithDuration(1.0, animations: {
                    nodeView.frame.origin = nodeInfo.destPos!
                })
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(Double(nodeInfo.disappearTime - currentTimeline) * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) { () -> Void in
                    self.disappearViewNode(nodeView)
                }
            }
        case .blink:
            if nodeView.hidden == true {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(Double(nodeInfo.blinkTime - currentTimeline) * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) { () -> Void in
                    self.blinkViewNode(nodeView)
                }
            }
            UIView.animateWithDuration(1.0, animations: {
                if nodeView.hidden == true {
                    nodeView.alpha = 0.0
                }
                
                nodeView.hidden = false
                nodeView.alpha = 1.0
            })
        case .disappear:
            if nodeView.hidden == true {
                nodeView.hidden = false
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(Double(nodeInfo.disappearTime - currentTimeline) * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) { () -> Void in
                    self.disappearViewNode(nodeView)
                }
            }
        }
    }
    
    public func blinkViewNode(v: UIView) {
        v.alpha = 0.0
        UIView.animateWithDuration(1.0, animations: {
            v.alpha = 1.0
        })
    }
    
    public func disappearViewNode(v: UIView) {
        v.alpha = 1.0
        UIView.animateWithDuration(1.0, animations: {
            v.alpha = 0.0
        })
        
    }
    
    public func incTimeline() {
        currentTimeline += 1
    }
    
    
    // Public methods
    public func addNode() {
        for var i = 0;i < sceneData.nodeList.count; i++ {
            let n = sceneData.nodeList[i]
            if n.timeline <= currentTimeline {
                for view in sceneView!.subviews {
                    if view.tag == n.nodeTag {
                        addNodeWithTheCorrectAnimation(view, nodeInfo: n)
                    }
                }
            }
            else {
                for view in sceneView!.subviews {
                    if view.tag == n.nodeTag {
                        view.hidden = true
                    }
                }
            }
        }
    }
    
    // Public methods
    public func playSceneAt(time: Float) {
        sceneTimer.invalidate()
        timelineIncrementTimer.invalidate()
        
        //if time <= 0.0 {
            //self.removeAllNode()
        //}
        
        currentTimeline = Int(time)
        
        
        // Node timer setting
        sceneTimer = NSTimer.scheduledTimerWithTimeInterval(1.0,target: self, selector:"addNode", userInfo: nil, repeats: true)
        NSRunLoop.currentRunLoop().addTimer(sceneTimer, forMode: NSRunLoopCommonModes)
        sceneTimer.fire()
        
        // Timeline timer setting
        timelineIncrementTimer = NSTimer.scheduledTimerWithTimeInterval(1.0,target: self, selector:"incTimeline", userInfo: nil, repeats: true)
        NSRunLoop.currentRunLoop().addTimer(timelineIncrementTimer, forMode: NSRunLoopCommonModes)
        timelineIncrementTimer.fire()
        
    }
    
    public func pauseScene() {
        sceneTimer.invalidate()
        timelineIncrementTimer.invalidate()
    }
    
    public func showNodeHighlight() {
        for var i = 0;i < sceneData.nodeList.count; i++ {
            let n = sceneData.nodeList[i]
            if currentTimeline <= 0 {
                if n.nodeDescription != "" {
                    let nodeView:UIView = self.sceneView!.viewWithTag(n.nodeTag)!
                    if nodeView.hidden == false {
                        let highlightButton:UIButton = self.sceneView!.viewWithTag(n.nodeTag * kCoeffTagForHighlight) as! UIButton
                        highlightButton.hidden = false
                    }
                }
            }
            else {
                if n.timeline <= currentTimeline && !n.nodeDescription.isEmpty {
                    // Look if the respective node is visible
                    let nodeView:UIView = self.sceneView!.viewWithTag(n.nodeTag)!
                    if nodeView.hidden == false {
                        let highlightButton:UIButton = self.sceneView!.viewWithTag(n.nodeTag * kCoeffTagForHighlight) as! UIButton
                        highlightButton.hidden = false
                    }
                }
            }
        }
    }
    
    public func hideNodeHighlight() {
        for var i = 0;i < sceneData.nodeList.count; i++ {
            let n = sceneData.nodeList[i]
            if !n.nodeDescription.isEmpty {
                let currentTag = n.nodeTag * kCoeffTagForHighlight
                print(n.nodeTag)
                let highlightButton:UIButton = self.sceneView!.viewWithTag(currentTag) as! UIButton
                highlightButton.hidden = true
            }
        }
    }
    
    @IBAction func showNodeDetail(sender: UIButton) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let nodeTag = sender.tag / kCoeffTagForHighlight
        
        for var i = 0;i < appDelegate.gScene?.sceneData.nodeList.count; i++ {
            let n = appDelegate.gScene?.sceneData.nodeList[i]
            if n!.nodeTag == nodeTag {
                appDelegate.gScene!.sceneDelegate!.onItemSelection(n!)
            }
        }
    }
}
