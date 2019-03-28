//
//  CoagulationCascadePrimaryHaemostasisScene.swift
//  iHemostasis
//
//  Created by Zo Rajaonarivony on 18/02/2016.
//  Copyright © 2016 Diagnostica Stago S.A.S. All rights reserved.
//

import UIKit

class CoagulationCascadePrimaryHaemostasisScene: ParentScene {
    let kPhaseOneStartTime: Int = 0
    let kPhaseTwoStartTime: Int = 19
    let kPhaseThreeStartTime: Int = 52
    let kPhaseFourStartTime: Int = 60

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        sceneView = NSBundle.mainBundle().loadNibNamed("CoagulationCascadePrimaryHaemostasis", owner: self, options: nil)![0] as? UIView
        self.addSubview(sceneView!);
        
        // Hide node that should be hidden at the beginining of the animation
        for var i = 0;i < sceneData.nodeList.count; i++ {
            let n = sceneData.nodeList[i]
            if n.hiddenAtStart == true {
                let imageView = self.sceneView!.viewWithTag(n.nodeTag) as! UIImageView
                imageView.hidden = true
            }
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func initData() {
        super.initData()
        sceneData.phaseList = ["Platelet Adhesion", "Platelet Activation and Amplification", "Platelet Aggregation", "Platelet inhibitors"]
        // Phase List - Description
        sceneData.phaseDescription.insert(NSLocalizedString("platelet-adhesion-detail", tableName: "PrimaryHaemostasisPhase", comment: "comment"), atIndex: 0)
        sceneData.phaseDescription.insert(NSLocalizedString("platelet-activation-and-amplification-detail", tableName: "PrimaryHaemostasisPhase", comment: "comment"), atIndex: 1)
        sceneData.phaseDescription.insert(NSLocalizedString("platelet-agregation-detail", tableName: "PrimaryHaemostasisPhase", comment: "comment"), atIndex: 2)
        sceneData.phaseDescription.insert(NSLocalizedString("platelet-inhibitors-detail", tableName: "PrimaryHaemostasisPhase", comment: "comment"), atIndex: 3)
        // Phase List - Duration
        sceneData.phaseTimelineList.insert(18.0, atIndex: 0)
        sceneData.phaseTimelineList.insert(51.0, atIndex: 1)
        sceneData.phaseTimelineList.insert(59.0, atIndex: 2)
        sceneData.phaseTimelineList.insert(74.0, atIndex: 3)
        
        sceneData.totalDuration = 78.0
        
        // ***************************** PHASE ONE - PLATELET ADHESION *****************************
        var n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseOneStartTime, time: 2, nodeTag: 12)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseOneStartTime, time: 2, nodeTag: 23)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseOneStartTime, time: 2, nodeTag: 40)
        n.nodeDescription = "P2Y12:\n\nPredominant receptor involved in ADP-stimulated platelet activation\nInhibited by antiplatelet drugs:PLAVIX®, EFIENT®, BRILIQUE®\nMeasure: VASP assay"
        sceneData.nodeList.append(n)

        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseOneStartTime, time: 2, nodeTag: 31)
        n.nodeDescription = "P2Y1:\n\nADP receptor induces platelet shape change and weak transient platelet aggregation"
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseOneStartTime, time: 2, nodeTag: 29)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseOneStartTime, time: 2, nodeTag: 58)
        n.nodeDescription = "TXA or TXA2R:\n\nThromboxane A2 receptor, also called TP\nStimulation of TXA results in activation of various signalling cascades"
        sceneData.nodeList.append(n)

        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseOneStartTime, time: 2, nodeTag: 57)
        n.nodeDescription = "GPIIb/IIIa:\n\nPlatelet Fibrinogen receptor\nFibrinogen cross-linking, platelets aggregation\nImpaired in Glanzmann thrombasthenia\nInhibition: REOPRO®, AGRASTAT®, INTEGRELIN®"
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseOneStartTime, time: 2, nodeTag: 56)
        n.nodeDescription = "GPVI:\n\nPlatelet collagen receptor\nAssociated with FcRγ-chain in platelet membrane\nGPVI/FcRγ chain-mediated signalling crucial for collagen platelet adhesion"
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseOneStartTime, time: 2, nodeTag: 55)
        n.nodeDescription = "GPIa/IIa:\n\nAlso called α2β1, VLA-2, CD49b/CD29\nAn integrin with high affinity for specific collagen sequence\nPlays role in platelet adhesion to collagen"
        sceneData.nodeList.append(n)

        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseOneStartTime, time: 3, nodeTag: 15)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseOneStartTime, time: 5, nodeTag: 13)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseOneStartTime, time: 6, nodeTag: 35)
        n.animationType = Utils.AnimationType.blink
        n.blinkTime = 7
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseOneStartTime, time: 6, nodeTag: 59)
        n.animationType = Utils.AnimationType.blink
        n.blinkTime = 7
        sceneData.nodeList.append(n)
        

        // First Animation Trajectory
        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseOneStartTime, time: 9, nodeTag: 1101)
        n.animationType = Utils.AnimationType.translationAndDisappear
        n.originPos = CGPointMake(855, 198)
        n.destPos = CGPointMake(542, 237)
        n.hiddenAtStart = true
        n.disappearTime = 10
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseOneStartTime, time: 10, nodeTag: 1111)
        n.animationType = Utils.AnimationType.translationAndDisappear
        n.hiddenAtStart = true
        n.originPos = CGPointMake(830, 152)
        n.destPos = CGPointMake(542, 237)
        n.disappearTime = 11
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseOneStartTime, time: 10, nodeTag: 1121)
        n.animationType = Utils.AnimationType.translationAndDisappear
        n.hiddenAtStart = true
        n.originPos = CGPointMake(844, 172)
        n.destPos = CGPointMake(542, 237)
        n.disappearTime = 11
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseOneStartTime, time: 10, nodeTag: 1131)
        n.animationType = Utils.AnimationType.translationAndDisappear
        n.hiddenAtStart = true
        n.originPos = CGPointMake(900, 207)
        n.destPos = CGPointMake(542, 237)
        n.disappearTime = 11
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseOneStartTime, time: 11, nodeTag: 1141)
        n.animationType = Utils.AnimationType.translationAndDisappear
        n.hiddenAtStart = true
        n.originPos = CGPointMake(925, 212)
        n.destPos = CGPointMake(542, 237)
        n.disappearTime = 12
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseOneStartTime, time: 11, nodeTag: 1151)
        n.animationType = Utils.AnimationType.translationAndDisappear
        n.hiddenAtStart = true
        n.originPos = CGPointMake(888, 176)
        n.destPos = CGPointMake(542, 237)
        n.disappearTime = 12
        sceneData.nodeList.append(n)
        
        // Second animation trajectory
        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseOneStartTime, time: 10, nodeTag: 110)
        n.animationType = Utils.AnimationType.translation
        n.originPos = CGPointMake(542, 237)
        n.destPos = CGPointMake(373, 231)
        n.hiddenAtStart = true
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseOneStartTime, time: 11, nodeTag: 111)
        n.animationType = Utils.AnimationType.translation
        n.hiddenAtStart = true
        n.originPos = CGPointMake(542, 237)
        n.destPos = CGPointMake(376, 200)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseOneStartTime, time: 11, nodeTag: 112)
        n.animationType = Utils.AnimationType.translation
        n.hiddenAtStart = true
        n.originPos = CGPointMake(542, 237)
        n.destPos = CGPointMake(367, 172)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseOneStartTime, time: 12, nodeTag: 113)
        n.animationType = Utils.AnimationType.translation
        n.hiddenAtStart = true
        n.originPos = CGPointMake(542, 237)
        n.destPos = CGPointMake(377, 149)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseOneStartTime, time: 12, nodeTag: 114)
        n.animationType = Utils.AnimationType.translation
        n.hiddenAtStart = true
        n.originPos = CGPointMake(542, 237)
        n.destPos = CGPointMake(434, 185)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseOneStartTime, time: 12, nodeTag: 115)
        n.animationType = Utils.AnimationType.translation
        n.hiddenAtStart = true
        n.originPos = CGPointMake(542, 237)
        n.destPos = CGPointMake(422, 219)
        sceneData.nodeList.append(n)
        //---
        
        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseOneStartTime, time: 9, nodeTag: 14)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseOneStartTime, time: 10, nodeTag: 43)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseOneStartTime, time: 13, nodeTag: 1)
        sceneData.nodeList.append(n)

        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseOneStartTime, time: 14, nodeTag: 70)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseOneStartTime, time: 15, nodeTag: 71)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseOneStartTime, time: 16, nodeTag: 6)
        n.nodeDescription = "TXA2:\n\nThromboxane A2\nProduced by stimulated platelets, binds to TXA\nActivates platelets to shape change, aggregation, secretion, promote thrombus formation"
        sceneData.nodeList.append(n)
        
        // ***************************** PHASE TWO - PLATELET ACTIVATION AND AMPLIFICATION *****************************
        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseTwoStartTime, time: 1, nodeTag: 4)
        n.nodeDescription = "GPIIb/IIIa:\n\nPlatelet Fibrinogen receptor\nFibrinogen cross-linking, platelets aggregation\nImpaired in Glanzmann thrombasthenia\nInhibition: REOPRO®, AGRASTAT®, INTEGRELIN"
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseTwoStartTime, time: 2, nodeTag: 5)
        n.nodeDescription = "GMP140/P-selectin:\n\nOn platelet surface after activation, secretion.\nMediates interactions between activated plateletss, WBCs, immune cells, endothelial cells"
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseTwoStartTime, time: 3, nodeTag: 49)
        n.nodeDescription = "PAR1:\n\nProtease Activated Receptor 1\nG protein-coupled transmembrane receptor, binds thrombin activating platelets\nTarget of PAR1 inhibitors atopaxar, vorapaxar"
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseTwoStartTime, time: 4, nodeTag: 2)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseTwoStartTime, time: 4, nodeTag: 41)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseTwoStartTime, time: 5, nodeTag: 522)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseTwoStartTime, time: 6, nodeTag: 52)
        n.nodeDescription = "ADP:\n\nAdenosine diphosphate\nReleased from platelet dense granules, provides second feedback amplification signal by binding to P2Y1 and P2Y12receptor coupled to Gq and Gi respectively"
        sceneData.nodeList.append(n)

        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseTwoStartTime, time: 7, nodeTag: 60)
        n.animationType = Utils.AnimationType.blink
        n.blinkTime = kPhaseTwoStartTime + 8
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseTwoStartTime, time: 7, nodeTag: 73)
        n.animationType = Utils.AnimationType.blink
        n.blinkTime = kPhaseTwoStartTime + 8
        n.nodeDescription = "ADP:\n\nAdenosine diphosphate\nReleased from platelet dense granules, provides second feedback amplification signal by binding to P2Y1 and P2Y12receptor coupled to Gq and Gi respectively"
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseTwoStartTime, time: 7, nodeTag: 74)
        n.nodeDescription = "ADP:\n\nAdenosine diphosphate\nReleased from platelet dense granules, provides second feedback amplification signal by binding to P2Y1 and P2Y12receptor coupled to Gq and Gi respectively"
        n.animationType = Utils.AnimationType.blink
        n.blinkTime = kPhaseTwoStartTime + 8
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseTwoStartTime, time: 9, nodeTag: 179)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseTwoStartTime, time: 10, nodeTag: 65)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseTwoStartTime, time: 11, nodeTag: 18)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseTwoStartTime, time: 13, nodeTag: 19)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseTwoStartTime, time: 14, nodeTag: 20)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseTwoStartTime, time: 15, nodeTag: 64)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseTwoStartTime, time: 17, nodeTag: 22)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseTwoStartTime, time: 18, nodeTag: 37)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseTwoStartTime, time: 20, nodeTag: 34)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseTwoStartTime, time: 21, nodeTag: 36)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseTwoStartTime, time: 22, nodeTag: 11)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseTwoStartTime, time: 23, nodeTag: 48)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseTwoStartTime, time: 24, nodeTag: 47)
        sceneData.nodeList.append(n)

        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseTwoStartTime, time: 25, nodeTag: 77)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseTwoStartTime, time: 26, nodeTag: 50)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseTwoStartTime, time: 27, nodeTag: 51)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseTwoStartTime, time: 29, nodeTag: 78)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseTwoStartTime, time: 30, nodeTag: 178)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseTwoStartTime, time: 31, nodeTag: 79)
        sceneData.nodeList.append(n)
        
        // ***************************** PHASE THREE - PLATELET AGGREGATION *****************************
        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseThreeStartTime, time: 1, nodeTag: 46)
        sceneData.nodeList.append(n)

        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseThreeStartTime, time: 1, nodeTag: 9)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseThreeStartTime, time: 1, nodeTag: 8)
        sceneData.nodeList.append(n)

        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseThreeStartTime, time: 1, nodeTag: 7)
        n.timeline = 53
        n.nodeTag = 7
        n.nodeDescription = "TXA2:\n\nThromboxane A2\nProduced by stimulated platelets, binds to TXA\nActivates platelets to shape change, aggregation, secretion, promote thrombus formation"
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseThreeStartTime, time: 1, nodeTag: 80)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseThreeStartTime, time: 1, nodeTag: 44)
        //n.nodeDescription = "TXA2:\n\nThromboxane A2\nProduced by stimulated platelets, binds to TXA\nActivates platelets to shape change, aggregation, secretion, promote thrombus formation"
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseThreeStartTime, time: 2, nodeTag: 10)
        n.nodeDescription = "Microparticles:\n\nVesicles made of cytoplasmic components, phospholipids\nSize: <1µm; carry surface membrane antigens from cell origin (Platelet, RBC orWBC)"
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseThreeStartTime, time: 3, nodeTag: 83)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseThreeStartTime, time: 4, nodeTag: 84)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseThreeStartTime, time: 5, nodeTag: 85)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseThreeStartTime, time: 6, nodeTag: 24)
        sceneData.nodeList.append(n)
        
        // ***************************** PHASE FOUR - PLATELET INHIBITORS *****************************
        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseFourStartTime, time: 1, nodeTag: 86)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseFourStartTime, time: 2, nodeTag: 87)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseFourStartTime, time: 3, nodeTag: 88)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseFourStartTime, time: 4, nodeTag: 89)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseFourStartTime, time: 5, nodeTag: 92)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseFourStartTime, time: 6, nodeTag: 90)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseFourStartTime, time: 7, nodeTag: 91)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseFourStartTime, time: 8, nodeTag: 93)
        sceneData.nodeList.append(n)

        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseFourStartTime, time: 9, nodeTag: 94)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseFourStartTime, time: 9, nodeTag: 96)
        sceneData.nodeList.append(n)
        
        //n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseFourStartTime, time: 9, nodeTag: 85)
        //sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseFourStartTime, time: 10, nodeTag: 95)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseFourStartTime, time: 10, nodeTag: 3)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseFourStartTime, time: 11, nodeTag: 61)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseFourStartTime, time: 12, nodeTag: 25)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseFourStartTime, time: 13, nodeTag: 72)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseFourStartTime, time: 14, nodeTag: 75)
        sceneData.nodeList.append(n)

        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseFourStartTime, time: 14, nodeTag: 76)
        sceneData.nodeList.append(n)
        
        
        
        
        
        
        /*
        
        
        
        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseFourStartTime, time: 2, nodeTag: 64)
        sceneData.nodeList.append(n)
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        

        
        n = CoagulationCascadeNodeModel(phaseStartTime:0, time: 0, nodeTag: 54)
        sceneData.nodeList.append(n)
        
        
        n = CoagulationCascadeNodeModel(phaseStartTime:0, time: 0, nodeTag: 2)
        sceneData.nodeList.append(n)
        
        // T16
        
        // T17
        n = CoagulationCascadeNodeModel(phaseStartTime:0, time: 0, nodeTag: 60)
        n.nodeDescription = "ADP:\n\nAdenosine diphosphate\nReleased from platelet dense granules, provides second feedback amplification signal by binding to P2Y1 and P2Y12receptor coupled to Gq and Gi respectively"
        //n.animationType = Utils.AnimationType.blink
        //n.blinkTime = 18
        sceneData.nodeList.append(n)
        
        
        
        // T32
        n = CoagulationCascadeNodeModel(phaseStartTime:0, time: 0, nodeTag: 49) //Need to split image
        sceneData.nodeList.append(n)
        
        // T33
        
        // T34
        
        
        // T35
        // NONE
        
        // T36
        /*
        n = CoagulationCascadeNodeModel(phaseStartTime:0,)
        n.timeline = 36
        n.nodeTag =
        n.nodeDescription = ""
        sceneData.nodeList.append(n)
        */
        
        // T37
        /*
        n = CoagulationCascadeNodeModel(phaseStartTime:0,)
        n.timeline = 37
        n.nodeTag =
        n.nodeDescription = ""
        sceneData.nodeList.append(n)
        */
        
        // T38
        // NONE
        // T39
        
        // T40
        
        // T41
        
        // T42
        n = CoagulationCascadeNodeModel(phaseStartTime:0, time: 0, nodeTag: 63)
        sceneData.nodeList.append(n)
        
        // T50
        n = CoagulationCascadeNodeModel(phaseStartTime:0, time: 0, nodeTag: 3)
        sceneData.nodeList.append(n)
        
        // T51
        n = CoagulationCascadeNodeModel(phaseStartTime:0, time: 0, nodeTag: 62)
        sceneData.nodeList.append(n)
        
        */
    }
    
}
