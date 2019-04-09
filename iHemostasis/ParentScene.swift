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
    var sceneTimer = Timer()
    var timelineIncrementTimer = Timer()
    var nodeAnimationTimer = Timer()
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
                view.isHidden = true;
            }
        }
    }
    
    private func addNodeWithTheCorrectAnimation(nodeView: UIView, nodeInfo: CoagulationCascadeNodeModel) {
        switch nodeInfo.animationType {
        case .normal:
            UIView.animate(withDuration: 1.0, animations: {
                if nodeView.isHidden == true {
                    nodeView.alpha = 0.0
                }
                
                nodeView.isHidden = false
                nodeView.alpha = 1.0
            })
        case .translation:
            if nodeView.isHidden == true {
                nodeView.isHidden = false
                nodeView.frame.origin = nodeInfo.originPos!
                UIView.animate(withDuration: 1.0, animations: {
                    nodeView.frame.origin = nodeInfo.destPos!
                })
            }
        case .translationAndDisappear:
            if nodeView.isHidden == true {
                nodeView.isHidden = false
                nodeView.frame.origin = nodeInfo.originPos!
                UIView.animate(withDuration: 1.0, animations: {
                    nodeView.frame.origin = nodeInfo.destPos!
                })
                
                DispatchQueue.main.asyncAfter(deadline: .now() + (Double(nodeInfo.disappearTime - currentTimeline))) {
                    () -> Void in
                    self.disappearViewNode(v: nodeView)
                }
            }
        case .blink:
            if nodeView.isHidden == true {
                DispatchQueue.main.asyncAfter(deadline: .now() + (Double(nodeInfo.blinkTime - currentTimeline))) {
                    () -> Void in
                    self.disappearViewNode(v: nodeView)
                }
            }
            UIView.animate(withDuration: 1.0, animations: {
                if nodeView.isHidden == true {
                    nodeView.alpha = 0.0
                }
                
                nodeView.isHidden = false
                nodeView.alpha = 1.0
            })
        case .disappear:
            if nodeView.isHidden == true {
                nodeView.isHidden = false
                DispatchQueue.main.asyncAfter(deadline: .now() + (Double(nodeInfo.disappearTime - currentTimeline))) {
                    () -> Void in
                    self.disappearViewNode(v: nodeView)
                }
            }
        }
    }
    
    public func blinkViewNode(v: UIView) {
        v.alpha = 0.0
        UIView.animate(withDuration: 1.0, animations: {
            v.alpha = 1.0
        })
    }
    
    public func disappearViewNode(v: UIView) {
        v.alpha = 1.0
        UIView.animate(withDuration: 1.0, animations: {
            v.alpha = 0.0
        })
        
    }
    
    @objc public func incTimeline() {
        currentTimeline += 1
    }
    
    
    // Public methods
    @objc public func addNode() {
        for i in 0..<sceneData.nodeList.count {
            let n = sceneData.nodeList[i]
            if n.timeline <= currentTimeline {
                for view in sceneView!.subviews {
                    if view.tag == n.nodeTag {
                        addNodeWithTheCorrectAnimation(nodeView: view, nodeInfo: n)
                    }
                }
            }
            else {
                for view in sceneView!.subviews {
                    if view.tag == n.nodeTag {
                        view.isHidden = true
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
        sceneTimer = Timer.scheduledTimer(timeInterval: 1.0,target: self, selector:#selector(addNode), userInfo: nil, repeats: true)
        RunLoop.current.add(sceneTimer, forMode: RunLoop.Mode.common)
        sceneTimer.fire()
        
        // Timeline timer setting
        timelineIncrementTimer = Timer.scheduledTimer(timeInterval: 1.0,target: self, selector:#selector(incTimeline), userInfo: nil, repeats: true)
        RunLoop.current.add(timelineIncrementTimer, forMode: RunLoop.Mode.common)
        timelineIncrementTimer.fire()
        
    }
    
    public func pauseScene() {
        sceneTimer.invalidate()
        timelineIncrementTimer.invalidate()
    }
    
    public func showNodeHighlight() {
        for i in 0..<sceneData.nodeList.count {
            let n = sceneData.nodeList[i]
            if currentTimeline <= 0 {
                if n.nodeDescription != "" {
                    let nodeView:UIView = self.sceneView!.viewWithTag(n.nodeTag)!
                    if nodeView.isHidden == false {
                        let highlightButton:UIButton = self.sceneView!.viewWithTag(n.nodeTag * kCoeffTagForHighlight) as! UIButton
                        highlightButton.isHidden = false
                    }
                }
            }
            else {
                if n.timeline <= currentTimeline && !n.nodeDescription.isEmpty {
                    // Look if the respective node is visible
                    let nodeView:UIView = self.sceneView!.viewWithTag(n.nodeTag)!
                    if nodeView.isHidden == false {
                        let highlightButton:UIButton = self.sceneView!.viewWithTag(n.nodeTag * kCoeffTagForHighlight) as! UIButton
                        highlightButton.isHidden = false
                    }
                }
            }
        }
    }
    
    public func hideNodeHighlight() {
        for i in 0..<sceneData.nodeList.count  {
            let n = sceneData.nodeList[i]
            if !n.nodeDescription.isEmpty {
                let currentTag = n.nodeTag * kCoeffTagForHighlight
                print(n.nodeTag)
                let highlightButton:UIButton = self.sceneView!.viewWithTag(currentTag) as! UIButton
                highlightButton.isHidden = true
            }
        }
    }
    
    @IBAction func showNodeDetail(sender: UIButton) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let nodeTag = sender.tag / kCoeffTagForHighlight
        if let dataCount = appDelegate.gScene?.sceneData.nodeList.count{
            for i in 0..<dataCount {
                let n = appDelegate.gScene?.sceneData.nodeList[i]
                if n!.nodeTag == nodeTag {
                    appDelegate.gScene!.sceneDelegate!.onItemSelection(name: n!)
                }
            }
        }
    }
}
