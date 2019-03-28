//
//  CoagulationCascadeNodeModel.swift
//  iHemostasis
//
//  Created by Zo Rajaonarivony on 03/02/2016.
//  Copyright © 2016 Diagnostica Stago S.A.S. All rights reserved.
//

import Foundation

class CoagulationCascadeNodeModel {
    var nodeName: String?
    var nodeTag: Int = 0
    var timeline: Int = 0
    var imageName: String?
    var nodeDescription: String = ""
    var originPos: CGPoint?
    var destPos: CGPoint?
    var animationType = Utils.AnimationType.normal
    var blinkTime: Int = 0
    var disappearTime: Int = 0
    var hiddenAtStart = false
    
    
    init(phaseStartTime: Int, time: Int, nodeTag: Int) {
        self.timeline = time + phaseStartTime
        self.nodeTag = nodeTag
    }
}