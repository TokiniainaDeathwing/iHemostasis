//
//  CoagulationCascadeAnticoagulantsScene.swift
//  iHemostasis
//
//  Created by Zo Rajaonarivony on 18/02/2016.
//  Copyright © 2016 Diagnostica Stago S.A.S. All rights reserved.
//

import UIKit

class CoagulationCascadeAnticoagulantsScene: ParentScene {
    let kPhaseOneStartTime: Int = 0
    let kPhaseTwoStartTime: Int = 7
    let kPhaseThreeStartTime: Int = 22
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        sceneView = NSBundle.mainBundle().loadNibNamed("CoagulationCascadeAnticoagulants", owner: self, options: nil)![0] as? UIView
        self.addSubview(sceneView!);
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func initData() {
        super.initData()
        sceneData.phaseList = ["Introduction", "Historical Multi target Anticoagulants", "Specific anti-IIa and anti-Xa drugs"]
        // Phase List - Description
        sceneData.phaseDescription.insert(NSLocalizedString("introduction-detail", tableName: "Anticoagulants", comment: "comment"), atIndex: 0)
        sceneData.phaseDescription.insert(NSLocalizedString("historical-detail", tableName: "Anticoagulants", comment: "comment"), atIndex: 1)
        sceneData.phaseDescription.insert(NSLocalizedString("specific-detail", tableName: "Anticoagulants", comment: "comment"), atIndex: 2)
        // Phase List - Duration
        sceneData.phaseTimelineList.insert(6.0, atIndex: 0)
        sceneData.phaseTimelineList.insert(21.0, atIndex: 1)
        sceneData.phaseTimelineList.insert(31.0, atIndex: 2)
        
        sceneData.totalDuration = 31.0
        
        // ***************************** PHASE ONE - INTRODUCTION *****************************
        var n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseOneStartTime, time: 4, nodeTag: 54)
        n.animationType = Utils.AnimationType.disappear
        n.disappearTime = 5
        sceneData.nodeList.append(n)
        
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseOneStartTime, time: 5, nodeTag: 15)
        sceneData.nodeList.append(n)
 
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseOneStartTime, time: 5, nodeTag: 87)
        sceneData.nodeList.append(n)
        
        //n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseOneStartTime, time: 1, nodeTag: 51)
        //sceneData.nodeList.append(n)
        
        //n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseOneStartTime, time: 1, nodeTag: 17)
        //sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseOneStartTime, time: 6, nodeTag: 16)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseOneStartTime, time: 6, nodeTag: 51)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseOneStartTime, time: 6, nodeTag: 17)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseOneStartTime, time: 6, nodeTag: 18)
        sceneData.nodeList.append(n)

        
        // ***************************** PHASE TWO - HISTORICAL... *****************************
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseTwoStartTime, time: 1, nodeTag: 3)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseTwoStartTime, time: 2, nodeTag: 2)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseTwoStartTime, time: 2, nodeTag: 30)
        n.nodeDescription = "Warfarin:\n\nDicoumarol derivative Vitamin K Antagonist (VKA), half life is 40 hours\nIndications: VTE treatment, prevention.\nMonitored: INR"
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseTwoStartTime, time: 2, nodeTag: 36)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseTwoStartTime, time: 2, nodeTag: 31)
        n.nodeDescription = "Acenocoumarol:\n\nCoumarin derivative Vitamin K Antagonist (VKA), half life is 8 – 11 hours\nMonitor: INR"
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseTwoStartTime, time: 2, nodeTag: 32)
        n.nodeDescription = "Phenprocoumon:\n\nCoumarin derivative, Vitamin K Antagonist (VKA), half life is 5-6 days\nMonitor: INR"
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseTwoStartTime, time: 2, nodeTag: 33)
        n.nodeDescription = "Fluindione:\n\nIndane-dione derivative, Vitamin K Antagonist (VKA); 30 hour half-life\nMonitor: INR"
        sceneData.nodeList.append(n)

        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseTwoStartTime, time: 3, nodeTag: 11)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseTwoStartTime, time: 4, nodeTag: 9)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseTwoStartTime, time: 5, nodeTag: 10)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseTwoStartTime, time: 6, nodeTag: 12)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseTwoStartTime, time: 7, nodeTag: 22)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseTwoStartTime, time: 8, nodeTag: 7)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseTwoStartTime, time: 9, nodeTag: 1)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseTwoStartTime, time: 9, nodeTag: 34)
        n.nodeDescription = "UFH:\n\nBinds to AT, potentates its anticoagulant activity.\nParenteral anticoagulant: inhibits FXa, FIIa.\nRequires monitoring: APTT or better Anti-Xa assay"
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseTwoStartTime, time: 9, nodeTag: 35)
        n.nodeDescription = "LMWH:\n\nDerived from UFH, parenteral, no monitoring\nLMWHs exhibit Anti-Xa, Anti-IIa activities\nMeasure: Anti-Xa assay"
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseTwoStartTime, time: 10, nodeTag: 14)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseTwoStartTime, time: 11, nodeTag: 20)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseTwoStartTime, time: 12, nodeTag: 13)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseTwoStartTime, time: 13, nodeTag: 23)
        sceneData.nodeList.append(n)
        
        // ***************************** PHASE ONE - SPECIFIC... *****************************
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseThreeStartTime, time: 1, nodeTag: 4)
        sceneData.nodeList.append(n)

        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseThreeStartTime, time: 2, nodeTag: 5)
        sceneData.nodeList.append(n)

        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseThreeStartTime, time: 2, nodeTag: 37)
        n.nodeDescription = "Hirudin:\n\nDirect FIIa inhibitor, derived from medicinal leech, parenteral\nAnticoagulant for HIT\nMeasure: ECT or ECA assays, prolongs APTT, TT"
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseThreeStartTime, time: 2, nodeTag: 38)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseThreeStartTime, time: 2, nodeTag: 39)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseThreeStartTime, time: 2, nodeTag: 40)
        n.nodeDescription = "Argatroban:\n\nSynthetic direct thrombin inhibitor, parenteral\nIndication: anticoagulant used in HIT\nMeasure: ECT or ECA assays"
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseThreeStartTime, time: 2, nodeTag: 41)
        n.nodeDescription = "Bivalirudin:\n\nSynthetic hirudin-derivative compound, parenteral\nIndications: anticoagulant used in HIT\nMeasure: ECA or ECT Assays"
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseThreeStartTime, time: 2, nodeTag: 42)
        n.nodeDescription = "Dabigatran:\n\nPradaxa®\nDirect FIIa (Thrombin) Inhibitor, oral, no monitoring\nIndications: VTE prophylaxis, Stroke Prevention AF\nMeasure: ECA Assay"
        sceneData.nodeList.append(n)

        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseThreeStartTime, time: 3, nodeTag: 8)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseThreeStartTime, time: 4, nodeTag: 88)
        sceneData.nodeList.append(n)

        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseThreeStartTime, time: 4, nodeTag: 21)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseThreeStartTime, time: 5, nodeTag: 6)
        sceneData.nodeList.append(n)

        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseThreeStartTime, time: 5, nodeTag: 43)
        n.nodeDescription = "Danaparoid:\n\nOrgaran®\nHeparinoid compound: heparin, dermatan, & chondroitin sulphate\nInhibits FXa indirectly via AT\nMeasure: Anti-Xa assay"
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseThreeStartTime, time: 5, nodeTag: 44)
        n.nodeDescription = "Fondaparinux:\n\nArixtra®\nSynthetic pentasaccharide, binds AT, indirect FXa inhibitor, parenteral\nMinimal or no effect on APTT, PT\nMeasure: Anti-Xa assay"
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseThreeStartTime, time: 5, nodeTag: 45)
        sceneData.nodeList.append(n)

        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseThreeStartTime, time: 6, nodeTag: 52)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseThreeStartTime, time: 7, nodeTag: 50)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseThreeStartTime, time: 7, nodeTag: 46)
        n.nodeDescription = "Rivaroxaban:\n\nXarelto®\nSynthetic, oral, direct FXa Inhibitor, no monitoring\nIndications: VTE prophylaxis, Stroke Prevention AF\nMeasure: Anti-Xa assay"
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseThreeStartTime, time: 7, nodeTag: 47)
        n.nodeDescription = "Apixaban:\n\nEliquis®\nSynthetic, oral, direct FXa Inhibitor, no monitoring\nIndications: VTE prophylaxis, Stroke Prevention AF\nMeasure: Anti-Xa assay"
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseThreeStartTime, time: 7, nodeTag: 48)
        n.nodeDescription = "Edoxaban:\n\nLyxiana®\nSynthetic, oral, direct FXa Inhibitor, no monitoring\nIndications: VTE prophylaxis, Stroke Prevention AF\nMeasure: Anti-Xa assay"
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseThreeStartTime, time: 7, nodeTag: 49)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseThreeStartTime, time: 8, nodeTag: 53)
        sceneData.nodeList.append(n)
        
    }
}
