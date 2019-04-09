//
//  CoagulationCascadeFibrinFormationScene.swift
//  iHemostasis
//
//  Created by Zo Rajaonarivony on 18/02/2016.
//  Copyright © 2016 Diagnostica Stago S.A.S. All rights reserved.
//

import UIKit

class CoagulationCascadeFibrinFormationScene: ParentScene {
    let kPhaseOneStartTime: Int = 1
    let kPhaseTwoStartTime: Int = 27
    let kPhaseThreeStartTime: Int = 33
    let kPhaseFourStartTime: Int = 45
    let kPhaseFiveStartTime: Int = 64
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        sceneView = Bundle.main.loadNibNamed("CoagulationCascadeFibrinFormation", owner: self, options: nil)![0] as? UIView
        self.addSubview(sceneView!);
        
        // Hide node that should be hidden at the beginining of the animation
        for i in 0..<sceneData.nodeList.count {
            let n = sceneData.nodeList[i]
            if n.hiddenAtStart == true {
                let imageView = self.sceneView!.viewWithTag(n.nodeTag) as! UIImageView
                imageView.isHidden = true
            }
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func initData() {
        super.initData()
        sceneData.phaseList = ["Fibrin Formation", "Fibrinolysis Initiation", "Fibrinolysis Amplification", "Antifibrinolysis: Inhibition of Fibrinolysis", "Fibrin and fibrinogen degradation products"]
        
        // Phase List - Description
        sceneData.phaseDescription.insert(NSLocalizedString("fibrin-formation-detail", tableName: "FibrinFormationPhase", comment: "comment"), at: 0)
        sceneData.phaseDescription.insert(NSLocalizedString("fibrinolysis-initiation-detail", tableName: "FibrinFormationPhase", comment: "comment"), at: 1)
        sceneData.phaseDescription.insert(NSLocalizedString("fibrinolysis-amplification-detail", tableName: "FibrinFormationPhase", comment: "comment"), at: 2)
        sceneData.phaseDescription.insert(NSLocalizedString("antifibrinolysis-detail", tableName: "FibrinFormationPhase", comment: "comment"), at: 3)
        sceneData.phaseDescription.insert(NSLocalizedString("fibrin-and-fibrinogen-degragation-detail", tableName: "FibrinFormationPhase", comment: "comment"), at: 3)
        
        // TO BE MODIFY
        // Phase List - Duration
        sceneData.phaseTimelineList.insert(26.0, at: 0)
        sceneData.phaseTimelineList.insert(32.0, at: 1)
        sceneData.phaseTimelineList.insert(44.0, at: 2)
        sceneData.phaseTimelineList.insert(65.0, at: 3)
        sceneData.phaseTimelineList.insert(70.0, at: 4)
        
        sceneData.totalDuration = 70.0
        
        // ***************************** PHASE ONE - FIBRIN FORMATION *****************************
        var n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseOneStartTime, time: 1, nodeTag: 261)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseOneStartTime, time: 1, nodeTag: 40)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseOneStartTime, time: 2, nodeTag: 7)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseOneStartTime, time: 3, nodeTag: 41)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseOneStartTime, time: 4, nodeTag: 265)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseOneStartTime, time: 5, nodeTag: 9)
        n.nodeDescription = "Fibrin Monomer:\n\nResults from Fibrinogen conversion by Thrombin after FpA and FpB have been released\nA marker of Fibrin formation"
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseOneStartTime, time: 6, nodeTag: 266)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseOneStartTime, time: 7, nodeTag: 267)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseOneStartTime, time: 8, nodeTag: 42)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseOneStartTime, time: 9, nodeTag: 25)
        n.animationType = Utils.AnimationType.blink
        n.blinkTime = kPhaseOneStartTime + 10
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseOneStartTime, time: 9, nodeTag: 43)
        n.animationType = Utils.AnimationType.blink
        n.blinkTime = kPhaseOneStartTime + 10
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseOneStartTime, time: 11, nodeTag: 262)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseOneStartTime, time: 12, nodeTag: 263)
        n.nodeDescription = "XIII:\n\nFactor XIII / Fibrin-stabilizing Factor\nActivated into FXIIIa by Thrombin\nFXIIIa converts soluble Fibrin into insoluble Fibrin"
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseOneStartTime, time: 13, nodeTag: 264)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseOneStartTime, time: 14, nodeTag: 53)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseOneStartTime, time: 15, nodeTag: 27)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseOneStartTime, time: 16, nodeTag: 54)
        n.hiddenAtStart = true
        n.originPos = CGPoint(x: 561, y: 145)
        n.destPos = CGPoint(x: 8, y: 362)
        n.animationType = Utils.AnimationType.translationAndDisappear
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseOneStartTime, time: 17, nodeTag: 55)
        n.hiddenAtStart = true
        n.originPos = CGPoint(x: 561, y: 145)
        n.destPos = CGPoint(x: 12, y: 322)
        n.animationType = Utils.AnimationType.translationAndDisappear
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseOneStartTime, time: 18, nodeTag: 52)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseOneStartTime, time: 18, nodeTag: 45)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseOneStartTime, time: 20, nodeTag: 46)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseOneStartTime, time: 21, nodeTag: 18)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseOneStartTime, time: 22, nodeTag: 17)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseOneStartTime, time: 23, nodeTag: 16)
        n.nodeDescription = "PLG:\n\nPlasminogen\nConverted to plasmin by tPA and Urokinase\nDegrades fibrin into FDPs, which includes D-Dimer"
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseOneStartTime, time: 24, nodeTag: 47)
        n.nodeDescription = "PLM:\n\nPlasmin\nResults from PLG conversion tPA and Urokinase\nResponsible for Fibrinogen and Fibrin degradation leading to FDPs"
        sceneData.nodeList.append(n)
        
        // ***************************** PHASE TWO - FIBRINOLYSIS INITIATION *****************************
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseTwoStartTime, time: 1, nodeTag: 32)
        n.animationType = Utils.AnimationType.translation
        n.originPos = CGPoint(130, 333)
        n.destPos = CGPoint(386, 24)
        n.nodeDescription = "PLM:\n\nPlasmin\nResults from PLG conversion tPA and Urokinase\nResponsible for Fibrinogen and Fibrin degradation leading to FDPs"
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseTwoStartTime, time: 2, nodeTag: 21)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseTwoStartTime, time: 3, nodeTag: 201)
        sceneData.nodeList.append(n)

        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseTwoStartTime, time: 4, nodeTag: 22)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseTwoStartTime, time: 5, nodeTag: 30)
        sceneData.nodeList.append(n)
        
        // ***************************** PHASE THREE - FIBRINOLYSIS AMPLIFICATION *****************************
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseThreeStartTime, time: 1, nodeTag:70)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseThreeStartTime, time: 2, nodeTag:191)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseThreeStartTime, time: 3, nodeTag: 23)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseThreeStartTime, time: 4, nodeTag: 24)
        n.animationType = Utils.AnimationType.translation
        n.originPos = CGPoint(130, 333)
        n.destPos = CGPoint(543, 180)
        n.nodeDescription = "PLM:\n\nPlasmin\nResults from PLG conversion tPA and Urokinase\nResponsible for Fibrinogen and Fibrin degradation leading to FDPs"
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseThreeStartTime, time: 5, nodeTag: 5)
        n.animationType = Utils.AnimationType.translation
        n.originPos = CGPoint(130, 333)
        n.destPos = CGPoint(806, 271)
        n.nodeDescription = "PLM:\n\nPlasmin\nResults from PLG conversion tPA and Urokinase\nResponsible for Fibrinogen and Fibrin degradation leading to FDPs"
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseThreeStartTime, time: 5, nodeTag: 33)
        sceneData.nodeList.append(n)

        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseThreeStartTime, time: 6, nodeTag: 31)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseThreeStartTime, time: 7, nodeTag: 37)
        n.nodeDescription = "HMWK:\n\nHigh Molecular Weight Kininogen\nBinds to endothelial cells; activates of contact factors\nDeficiency is not associated with increased bleeding risk"
        sceneData.nodeList.append(n)

        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseThreeStartTime, time: 8, nodeTag: 36)
        n.nodeDescription = "Factor XII:\n\nPart of contact pathway\nActivates FXI and PK\nDeficiency prolongs PTT but does not indicate bleeding risk"
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseThreeStartTime, time: 9, nodeTag: 35)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseThreeStartTime, time: 10, nodeTag: 34)
        n.nodeDescription = "PK:\n\nPreKallikrein\nContact Factor\nDeficiency not associated with increased bleeding risk\nKallikrein activated form; activates Pro-urokinase to Urokinase"
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseThreeStartTime, time: 11, nodeTag: 27)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseThreeStartTime, time: 12, nodeTag: 281)
        sceneData.nodeList.append(n)

        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseThreeStartTime, time: 14, nodeTag: 29)
        sceneData.nodeList.append(n)
        
        // ***************************** PHASE FOUR - ANTIFIBRINOLYSIS : INHIBITION OF FIBRINOLYSIS *****************************
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseFourStartTime, time: 1, nodeTag: 20)
        n.nodeDescription = "PAI-1:\n\nPlasminogen Activator Inhibitor-1\nTissue Plasminogen Activator (tPA) inhibitor and urokinase (UK) inhibitor"
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseFourStartTime, time: 2, nodeTag: 19)
        n.nodeDescription = "PAI-1:\n\nPlasminogen Activator Inhibitor-1\nTissue Plasminogen Activator (tPA) inhibitor and urokinase (UK) inhibitor"
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseFourStartTime, time: 3, nodeTag: 28)
        n.nodeDescription = "C1 inh\n\nComplement C1 inhibitor\nPart of complement system\nInhibits Kallikrein by limiting activation of Pro-urokinase, indirectly limiting fibrinolysis"
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseFourStartTime, time: 4, nodeTag: 12)
        n.nodeDescription = "TM:\n\nThrombomodulin\nIs thrombin endothelial cell surface receptor\nThrombin – TM complex converts PC to aPC and TAFI to TAFIa\n"
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseFourStartTime, time: 4, nodeTag: 48)
        n.nodeDescription = "αMG:\n\nα2-MacroGlobulin\nΑ physiological inhibitor of Plasmin"
        sceneData.nodeList.append(n)
        
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseFourStartTime, time: 5, nodeTag: 13)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseFourStartTime, time: 5, nodeTag: 49)
        n.nodeDescription = "αAT:\n\nα1-AntiTrypsin\nΑ physiological inhibitor of Plasmin"
        sceneData.nodeList.append(n)
        
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseFourStartTime, time: 6, nodeTag: 50)
        n.nodeDescription = "αAP:\n\nα2-AntiPlasmin\nΑ physiological inhibitor of Plasmin"
        sceneData.nodeList.append(n)

        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseFourStartTime, time: 7, nodeTag: 14)
        n.nodeDescription = "TAFI:\n\nThrombin Activatable Fibrinolysis Inhibitor\nCleaves Lysin residues from PLG inhibiting fibrinolytic activity\nActivated half-life ~ 7 – 8 mins"
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseFourStartTime, time: 9, nodeTag: 15)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseFourStartTime, time: 10, nodeTag: 390)
        n.animationType = Utils.AnimationType.blink
        n.blinkTime = kPhaseFourStartTime + 11
        sceneData.nodeList.append(n)

        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseFourStartTime, time: 11, nodeTag: 391)
        n.animationType = Utils.AnimationType.blink
        n.blinkTime = kPhaseFourStartTime + 12
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseFourStartTime, time: 12, nodeTag: 393)
        n.animationType = Utils.AnimationType.blink
        n.blinkTime = kPhaseFourStartTime + 13
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseFourStartTime, time: 13, nodeTag: 392)
        n.animationType = Utils.AnimationType.blink
        n.blinkTime = kPhaseFourStartTime + 14
        sceneData.nodeList.append(n)
        
        // ***************************** PHASE FIVE - ANTIFIBRINOLYSIS : DEGRADATION PRODUCTS *****************************
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseFiveStartTime, time: 1, nodeTag: 38)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseFiveStartTime, time: 2, nodeTag: 44)
        sceneData.nodeList.append(n)


        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseFiveStartTime, time: 3, nodeTag: 1)
        n.nodeDescription = "Fibrin Degradation Products:\n\nProduced by action of plasmin on Fibrin\nComponents produced: D-Dimers, Fibrin / Fibrinogen Degradation products"
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseFiveStartTime, time: 4, nodeTag: 6)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseFiveStartTime, time: 5, nodeTag: 4)
        n.nodeDescription = "Fibrinogen Degradation Products:\n\nProduced by action of plasmin on Fibrinogen.\nWith Fibrin Degradation products are called FDP"
        sceneData.nodeList.append(n)
        /*
        n = CoagulationCascadeNodeModel(phaseStartTime: 0, time: 0, nodeTag: )
        n.timeline = 5
        n.nodeTag =
        n.nodeDescription = ""
        sceneData.nodeList.append(n)


        n = CoagulationCascadeNodeModel(phaseStartTime: 0, time: 0, nodeTag: 11)
        sceneData.nodeList.append(n)
        
        // T8
        
        // T9
        
        
        // T10
        n = CoagulationCascadeNodeModel(phaseStartTime: 0, time: 0, nodeTag: 43)
        sceneData.nodeList.append(n)
        
        
        
        // T13
        
        // T14
        
        // T15
        // T16
        
        // T17
        n = CoagulationCascadeNodeModel(phaseStartTime: 0, time: 0, nodeTag: 51)
        sceneData.nodeList.append(n)
        
        
        n = CoagulationCascadeNodeModel(phaseStartTime: 0, time: 0, nodeTag: 45)
        sceneData.nodeList.append(n)
        
        // T18
        
        // T19
        
        // T20
        
        // T21
        
        // T22
        
        // T23
        
        // T24
        
        // T25
        // NONE
        
        // T26
        
        // T27
        
        // T28
        
        // T29
        /*
        n = CoagulationCascadeNodeModel(phaseStartTime: 0, time: 0, nodeTag: )
        n.timeline = 29
        n.nodeTag =
        n.nodeDescription = ""
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: 0, time: 0, nodeTag: )
        n.timeline = 29
        n.nodeTag =
        n.nodeDescription = ""
        sceneData.nodeList.append(n)
        */
        
        // T30
        
        // T31
        
        // T32
        
        // T33
        
        // T34
        
        //T35
        // T36
        
        // T37
        
        // T38
        
        // T39
        
        // T40
        n = CoagulationCascadeNodeModel(phaseStartTime: 0, time: 0, nodeTag: 27)
        sceneData.nodeList.append(n)
        
        // T41
        
        // T42
        // NONE
        
        // T43
        
        // T44
        /*
        n = CoagulationCascadeNodeModel(phaseStartTime: 0, time: 0, nodeTag: )
        n.timeline = 44
        n.nodeTag = 29
        n.nodeDescription = ""
        sceneData.nodeList.append(n)
        */
        
        // T45
        /*
        n = CoagulationCascadeNodeModel(phaseStartTime: 0, time: 0, nodeTag: )
        n.timeline = 45
        n.nodeTag =
        n.nodeDescription = ""
        sceneData.nodeList.append(n)
        */
        
        // T46
        /*
        n = CoagulationCascadeNodeModel(phaseStartTime: 0, time: 0, nodeTag: )
        n.timeline = 46
        n.nodeTag =
        n.nodeDescription = ""
        sceneData.nodeList.append(n)
        */
        // T47
        /*
        n = CoagulationCascadeNodeModel(phaseStartTime: 0, time: 0, nodeTag: )
        n.timeline = 47
        n.nodeTag =
        n.nodeDescription = ""
        sceneData.nodeList.append(n)
        */
        
        // T48
        
        // T49
        
        // T50
        
        // T51
        
        // T52
        
        // T53
        
        // T54
        
        // T55
        
        // T56
        
        // T57
        
        // T58
        
        // T59
        
        // T60
        
        // T61
        
        // T62
        
        // T63
        n = CoagulationCascadeNodeModel(phaseStartTime: 0, time: 0, nodeTag: 6)
        n.animationType = Utils.AnimationType.blink
        n.blinkTime = 64
        sceneData.nodeList.append(n)
        
        // T65
        
        */
    }
}
