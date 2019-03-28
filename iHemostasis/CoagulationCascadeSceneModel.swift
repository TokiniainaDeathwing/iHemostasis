//
//  CoagulationCascadeSceneData.swift
//  iHemostasis
//
//  Created by Zo Rajaonarivony on 03/02/2016.
//  Copyright © 2016 Diagnostica Stago S.A.S. All rights reserved.
//

import Foundation

class CoagulationCascadeSceneModel {
    // Should be stored in a Dictionary
    var phaseList: [String] = []
    var phaseDescription: [String] = []
    var phaseTimelineList: [Float] = []
    var nodeList: [CoagulationCascadeNodeModel] = []
    var totalDuration: Float = 0
}