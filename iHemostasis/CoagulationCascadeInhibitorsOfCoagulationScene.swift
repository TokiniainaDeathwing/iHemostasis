//
//  CoagulationCascadeInhibitorsOfCoagulationScene.swift
//  iHemostasis
//
//  Created by Zo Rajaonarivony on 18/02/2016.
//  Copyright © 2016 Diagnostica Stago S.A.S. All rights reserved.
//

import UIKit

class CoagulationCascadeInhibitorsOfCoagulationScene: ParentScene {
    let kPhaseOneStartTime: Int = 0
    let kPhaseTwoStartTime: Int = 25
    let kPhaseThreeStartTime: Int = 33
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        var sceneName :String! = "CoagulationCascadeInhibitorsOfCoagulation"
        if(UIDevice.current.userInterfaceIdiom == .phone){
            sceneName = "CoagulationCascadeInhibitorsOfCoagulation copy"
        }
        sceneView = Bundle.main.loadNibNamed(sceneName, owner: self, options: nil)![0] as? UIView
        self.addSubview(sceneView!);
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func initData() {
        super.initData()
        sceneData.phaseList = ["Protein C/S", "Protein Z and TFPI", "Antithrombin"]
        
        // Phase List - Description
        sceneData.phaseDescription.insert(NSLocalizedString("protein-c-s-detail", tableName: "InhibitorsCoagulationPhase", comment: "comment"), at: 0)
        sceneData.phaseDescription.insert(NSLocalizedString("protein-z-tfpi-detail", tableName: "InhibitorsCoagulationPhase", comment: "comment"), at: 1)
        sceneData.phaseDescription.insert(NSLocalizedString("antithrombin-detail", tableName: "InhibitorsCoagulationPhase", comment: "comment"), at: 2)
        
        // Phase List - Duration
        sceneData.phaseTimelineList.insert(24.0, at: 0)
        sceneData.phaseTimelineList.insert(32.0, at: 1)
        sceneData.phaseTimelineList.insert(46.0, at: 2)
        
        sceneData.totalDuration = 46.0
        
        // ***************************** PHASE ONE - Protein C/S *****************************
        var n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseOneStartTime, time: 1, nodeTag: 1)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseOneStartTime, time: 1, nodeTag: 3)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseOneStartTime, time: 1, nodeTag: 2)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseOneStartTime, time: 1, nodeTag: 4)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseOneStartTime, time: 1, nodeTag: 5)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseOneStartTime, time: 1, nodeTag: 6)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseOneStartTime, time: 1, nodeTag: 7)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseOneStartTime, time: 1, nodeTag: 9)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseOneStartTime, time: 1, nodeTag: 8)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseOneStartTime, time: 1, nodeTag: 10)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseOneStartTime, time: 1, nodeTag: 11)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseOneStartTime, time: 1, nodeTag: 36)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseOneStartTime, time: 2, nodeTag: 16)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseOneStartTime, time: 3, nodeTag: 17)
        n.animationType = Utils.AnimationType.translation
        n.originPos = CGPoint(68, 46)
        n.destPos = CGPoint(234, 46)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseOneStartTime, time: 4, nodeTag: 18)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseOneStartTime, time: 5, nodeTag: 191)
        sceneData.nodeList.append(n)

        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseOneStartTime, time: 6, nodeTag: 19)
        n.nodeDescription = "PC:\n\nProtein C\nVitamin K-dependent synthesized by the liver\naPC bound to PS inhibits FV\nDeficiency is a risk factor for VTE"
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseOneStartTime, time: 7, nodeTag: 29)
        n.nodeDescription = "PC:\n\nProtein C\nVitamin K-dependent synthesized by the liver\naPC bound to PS inhibits FV\nDeficiency is a risk factor for VTE"
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseOneStartTime, time: 8, nodeTag: 20)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseOneStartTime, time: 9, nodeTag: 292)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseOneStartTime, time: 10, nodeTag: 28)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseOneStartTime, time: 12, nodeTag: 13)
        n.nodeDescription = "ePCR:\n\nEndothelial Protein C Receptor\nVitamin K-dependent; activates PC and FVII\nBound to PC has cytoprotective activity\nDefects can be risk factor for VTE"
        sceneData.nodeList.append(n)

        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseOneStartTime, time: 13, nodeTag: 14)
        sceneData.nodeList.append(n)

        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseOneStartTime, time: 14, nodeTag: 37)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseOneStartTime, time: 15, nodeTag: 30)
        sceneData.nodeList.append(n)

        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseOneStartTime, time: 16, nodeTag: 27)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseOneStartTime, time: 16, nodeTag: 22)
        n.nodeDescription = "C4bBP:\n\nC4b Binding Protein\nComplement component protein that binds to C4b and PS\nC4bBP-bound PS accounts for 60-70% of total PS"
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseOneStartTime, time: 16, nodeTag: 23)
        n.nodeDescription = "PS:\n\nProtein S\nVitamin K-dependent liver synthesis\nCirculates bound to C4bBP or free\nFree is active, cofactor for PC and TFPI\nDeficiency risk factor for VTE"
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseOneStartTime, time: 16, nodeTag: 21)
        n.nodeDescription = "PS:\n\nProtein S\nVitamin K-dependent liver synthesis\nCirculates bound to C4bBP or free\nFree is active, cofactor for PC and TFPI\nDeficiency risk factor for VTE"
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseOneStartTime, time: 17, nodeTag: 60)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseOneStartTime, time: 18, nodeTag: 24)
        n.nodeDescription = "PS:\n\nProtein S\nVitamin K-dependent liver synthesis\nCirculates bound to C4bBP or free\nFree is active, cofactor for PC and TFPI\nDeficiency risk factor for VTE"
        sceneData.nodeList.append(n)

        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseOneStartTime, time: 19, nodeTag: 25)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseOneStartTime, time: 20, nodeTag: 38)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseOneStartTime, time: 21, nodeTag: 26)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseOneStartTime, time: 22, nodeTag: 39)
        n.nodeDescription = "PS:\n\nProtein S\nVitamin K-dependent liver synthesis\nCirculates bound to C4bBP or free\nFree is active, cofactor for PC and TFPI\nDeficiency risk factor for VTE"
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseOneStartTime, time: 23, nodeTag: 41)
        n.nodeDescription = "Factor V Leiden:\n\nFV variant where cleavage site by PC is affected\nResults in limited and decreased FVa degradation\nIncreased risk of VTE"
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseOneStartTime, time: 24, nodeTag: 52)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseOneStartTime, time: 25, nodeTag: 40)
        sceneData.nodeList.append(n)
        
        // ***************************** PHASE TWO - Protein Z and TFPI *************************
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseTwoStartTime, time: 1, nodeTag: 32)
        n.nodeDescription = "PZ:\n\nProtein Z\nVitamin K-dependent\nCofactor of Protein Z-dependent Protease Inhibitor (ZPI); together inhibit FXa and FIXa"
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseTwoStartTime, time: 2, nodeTag: 34)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseTwoStartTime, time: 3, nodeTag: 322)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseTwoStartTime, time: 4, nodeTag: 31)
        n.nodeDescription = "PZ:\n\nProtein Z\nVitamin K-dependent\nCofactor of Protein Z-dependent Protease Inhibitor (ZPI); together inhibit FXa and FIXa"
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseTwoStartTime, time: 6, nodeTag: 311)
        sceneData.nodeList.append(n)
 
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseTwoStartTime, time: 9, nodeTag: 35)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseTwoStartTime, time: 10, nodeTag: 33)
        n.nodeDescription = "TFPI:\n\nTissue Factor Pathway Inhibitor\nRegulates TF–FVIIa complex activity by inhibiting FXa and downregulating thrombin generation"
        sceneData.nodeList.append(n)
        
        // ***************************** PHASE THREE - Antithrombin *****************************
        // GOOD TIMING FROM HERE
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseThreeStartTime, time: 1, nodeTag: 43)
        n.nodeDescription = "AT:\n\nAntithrombin\nInhibitor of thrombin, FXa, FIXa, FXIa, FXIIa, FVIIa\nThrombin inhibition increased when bound to heparin\nInherited deficiency risk for VTE"
        n.animationType = Utils.AnimationType.translation
        n.originPos = CGPoint(38, 474)
        n.destPos = CGPoint(105, 412)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseThreeStartTime, time: 2, nodeTag: 45)
        n.nodeDescription = "AT:\n\nAntithrombin\nInhibitor of thrombin, FXa, FIXa, FXIa, FXIIa, FVIIa\nThrombin inhibition increased when bound to heparin\nInherited deficiency risk for VTE"
        n.animationType = Utils.AnimationType.translation
        n.originPos = CGPoint(8, 298)
        n.destPos = CGPoint(27, 418)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseThreeStartTime, time: 3, nodeTag: 46)
        n.nodeDescription = "AT:\n\nAntithrombin\nInhibitor of thrombin, FXa, FIXa, FXIa, FXIIa, FVIIa\nThrombin inhibition increased when bound to heparin\nInherited deficiency risk for VTE"
        n.animationType = Utils.AnimationType.translation
        n.originPos = CGPoint(25, 376)
        n.destPos = CGPoint(68, 370)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseThreeStartTime, time: 4, nodeTag: 47)
        n.nodeDescription = "AT:\n\nAntithrombin\nInhibitor of thrombin, FXa, FIXa, FXIa, FXIIa, FVIIa\nThrombin inhibition increased when bound to heparin\nInherited deficiency risk for VTE"
        n.animationType = Utils.AnimationType.translation
        n.originPos = CGPoint(25, 76)
        n.destPos = CGPoint(67, 198)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseThreeStartTime, time: 5, nodeTag: 48)
        n.nodeDescription = "AT:\n\nAntithrombin\nInhibitor of thrombin, FXa, FIXa, FXIa, FXIIa, FVIIa\nThrombin inhibition increased when bound to heparin\nInherited deficiency risk for VTE"
        n.animationType = Utils.AnimationType.translation
        n.originPos = CGPoint(119, 73)
        n.destPos = CGPoint(229, 84)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseThreeStartTime, time: 6, nodeTag: 44)
        n.nodeDescription = "AT:\n\nAntithrombin\nInhibitor of thrombin, FXa, FIXa, FXIa, FXIIa, FVIIa\nThrombin inhibition increased when bound to heparin\nInherited deficiency risk for VTE"
        n.animationType = Utils.AnimationType.translation
        n.originPos = CGPoint(64, 458)
        n.destPos = CGPoint(116, 488)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime: kPhaseThreeStartTime, time: 7, nodeTag: 42)
        n.nodeDescription = "AT:\n\nAntithrombin\nInhibitor of thrombin, FXa, FIXa, FXIa, FXIIa, FVIIa\nThrombin inhibition increased when bound to heparin\nInherited deficiency risk for VTE"
        n.animationType = Utils.AnimationType.translation
        n.originPos = CGPoint(0, 474)
        n.destPos = CGPoint(66, 508)
        sceneData.nodeList.append(n)
        
    }
    
}
