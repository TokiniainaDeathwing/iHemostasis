//
//  CoagulationCascadeCoagulationCascadeScene.swift
//  iHemostasis
//
//  Created by Zo Rajaonarivony on 16/12/2015.
//  Copyright © 2015 Diagnostica Stago S.A.S. All rights reserved.
//

import UIKit

class CoagulationCascadeCoagulationCascadeScene: ParentScene  {
    let kPhaseOneStartTime: Int = 0
    let kPhaseTwoStartTime: Int = 18
    let kPhaseThreeStartTime: Int = 23
    let kPhaseFourStartTime: Int = 29
    var percentHeight: CGFloat = 0
    override init(frame: CGRect) {
        super.init(frame: frame)
        var sceneName :String! = "CoagulationCascadeCoagulationCascade"
        if(UIDevice.current.userInterfaceIdiom == .phone){
           
            if(UIScreen.main.bounds.height >= 1024){
                percentHeight = UIScreen.main.bounds.height * 20 / 100;
            }else if(UIScreen.main.bounds.height < 1024 && UIScreen.main.bounds.height >= 834){
                percentHeight = UIScreen.main.bounds.height * 8 / 100;
            }
            sceneName = "CoagulationCascadeCoagulationCascade copy"
        }
        sceneView = Bundle.main.loadNibNamed(sceneName, owner: self, options: nil)![0] as? UIView
//        var sW = CGFloat(1024)
//        var h = CGFloat(648)
//        if(sW < UIScreen.main.bounds.width){
//            h = h + UIScreen.main.bounds.width - sW
//            sW = UIScreen.main.bounds.width
//        }
//        self.frame = CGRect(0 ,0 , sW, h)
//        self.sceneView!.frame = CGRect(0 ,0 , sW, h)
//        self.sceneView?.subviews[0].frame = CGRect(0 ,0 , sW, h)
        if(UIDevice.current.userInterfaceIdiom == .phone){
            let sW = CGFloat(UIScreen.main.bounds.width)
            let h = CGFloat(320*UIScreen.main.bounds.height/414)
           self.sceneView!.frame = CGRect(0 ,0 , sW, h)
//            for i in 1..<sceneView!.subviews.count {
//              //  var frame:CGRect=(sceneView?.subviews[i].frame)! ;
//               // sceneView?.subviews[i].frame = CGRect(frame.origin.x  ,frame.origin.y , frame.size.width, frame.size.height )
//                if((sceneView?.subviews[i].isKind(of: UIButton.self))!){
//                    let button:UIButton = sceneView?.subviews[i] as! UIButton
//
//                        //button.addTarget(self, action: #selector(showNodeDetail(sender:)), for: .touchUpInside)
//                        print("frame button",button.allTargets)
//
//
//                }
//
//            }
        }
        for i in 1..<sceneView!.subviews.count {
          //  var frame:CGRect=(sceneView?.subviews[i].frame)! ;
           // sceneView?.subviews[i].frame = CGRect(frame.origin.x  ,frame.origin.y , frame.size.width, frame.size.height )
            if((sceneView?.subviews[i].isKind(of: UIButton.self))!){
                let button:UIButton = sceneView?.subviews[i] as! UIButton
                
                    //button.addTarget(self, action: #selector(showNodeDetail(sender:)), for: .touchUpInside)
                let test = "\(button.isEnabled), \(button.isUserInteractionEnabled)"
                print("frame button",test)
                
              
            }
            
        }
        self.addSubview(sceneView!);
         
        if(UIScreen.main.bounds.height >= 1024){
            for i in 1..<sceneView!.subviews.count {
                if((sceneView?.subviews[i].isKind(of: UIButton.self))!){
                    (sceneView?.subviews[i] as! UIButton).setBackgroundImage(UIImage(named: "PH_26@3x"), for: .normal);
                }
            }
        }
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
        
        // Phase List - Title
        sceneData.phaseList = ["Initiation Phase", "Propagation Phase", "Amplification Phase", "Fibrin Formation"]
        // Phase List - Description
        sceneData.phaseDescription.insert(NSLocalizedString("initiation-phase-detail", tableName: "CoagulationCascadePhase", comment: "comment"), at: 0)
        sceneData.phaseDescription.insert(NSLocalizedString("propagation-phase-detail", tableName: "CoagulationCascadePhase", comment: "comment"), at: 1)
        sceneData.phaseDescription.insert(NSLocalizedString("amplification-phase", tableName: "CoagulationCascadePhase", comment: "comment"), at: 2)
        sceneData.phaseDescription.insert(NSLocalizedString("fibrin-formation", tableName: "CoagulationCascadePhase", comment: "comment"), at: 3)
        // Phase List - Duration
        sceneData.phaseTimelineList.insert(17.0, at: 0)
        sceneData.phaseTimelineList.insert(22.0, at: 1)
        sceneData.phaseTimelineList.insert(28.0, at: 2)
        sceneData.phaseTimelineList.insert(35.0, at: 3)
        
        sceneData.totalDuration = 35.0
        

        // ***************************** PHASE ONE - INITIATION PHASE *****************************
        var n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseOneStartTime, time: 1, nodeTag: 1)
        n.nodeDescription = "TF: \n\nTissue Factor\nTransmembrane glycoprotein\nReceptor for plasma FVII/ FIIa\nPrimary initiator of in vivo coagulation"
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseOneStartTime, time: 2, nodeTag: 2)
        n.nodeDescription = "VIIa: \nActivated Factor VII\nVitamin K-dependent liver synthesis\nRapidly activated into FVIIa when FVII is bound to TF\nFVIIa-TF comlex activates FX and FIXn"
        n.animationType = Utils.AnimationType.translation
        //n.originPos = CGPoint(363, 456)
        //n.destPos = CGPoint(506, 515)
        n.originPos = CGPoint(363, 456)
        n.destPos = CGPoint(506, 515)
        if(UIDevice.current.userInterfaceIdiom == .phone){
            n.originPos = CGPoint(410*UIScreen.main.bounds.width/896, 199*UIScreen.main.bounds.height/414)
            
            n.destPos = CGPoint(440*UIScreen.main.bounds.width/896, 245*UIScreen.main.bounds.height/414)
        }
        sceneData.nodeList.append(n)

        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseOneStartTime, time:3, nodeTag: 6)
        n.nodeDescription = "X:\n\nFactor X\nVitamin K-dependent liver synthesis\nActivated F X(Xa) inhibited indrectly by UFH, LMWH, fondaparinux with AT, directly by rivaroxaban, apixxaban, edxaban"
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseOneStartTime, time: 4, nodeTag: 3)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseOneStartTime, time: 5, nodeTag: 9)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseOneStartTime, time:6, nodeTag: 10)
        sceneData.nodeList.append(n)

        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseOneStartTime,time: 7, nodeTag: 4)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseOneStartTime,time: 8, nodeTag: 7)
        n.nodeDescription = "IX:\n\nFactor IX\nVitamin K-dependent liver synthesis\nInherited FIX deficiency is responsible for Haemophilia B\nActivated to FIXa by FXIa"
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseOneStartTime, time: 8, nodeTag: 42)
        sceneData.nodeList.append(n)
        

        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseOneStartTime, time: 9, nodeTag: 19)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseOneStartTime, time: 10, nodeTag: 11)
        sceneData.nodeList.append(n)

        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseOneStartTime, time: 11, nodeTag: 12)
        n.nodeDescription = "II:\n\nFactor II\nVitamin K-dependent liver synthesis\nActivated to FIIa (Thrombin) by FXa - FVa - Phospholipids-Ca\nInhibited by Direct Thrombin Inhibitors (dabigatran)"
        n.animationType = Utils.AnimationType.blink
        n.blinkTime = 13
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseOneStartTime, time: 12, nodeTag: 13)
        n.nodeDescription = "IIa:\n\nFactor IIa / Thrombin\nResults from Factor II activation\nFIIa converts Fibrinogen to Fibrin"
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseOneStartTime, time: 13, nodeTag: 40)
        n.animationType = Utils.AnimationType.blink
        n.blinkTime = 26
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseOneStartTime, time: 14, nodeTag: 5)
        n.animationType = Utils.AnimationType.blink
        n.blinkCount = 5
        sceneData.nodeList.append(n)
        
        // ***************************** PHASE TWO - PROPAGATION PHASE *****************************
        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseTwoStartTime, time: 1, nodeTag: 18)
        n.nodeDescription = "XI:\n\nFactor XI\nNon vitamin K-dependent liver synthesis\nDeficiency is responsible for rare Haeomophilia C\nActivated to FXIa by FXIIa and thrombin"
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseTwoStartTime, time: 1, nodeTag: 21)
        n.nodeDescription = "V:\n\nFactor V\nNon-Vitamin K-dependent liver and possible megakaryocyte synthesis\nFVa forms a complex with FXa that activates FII to FIIa (Thrombin)"
        sceneData.nodeList.append(n)

        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseTwoStartTime, time: 1, nodeTag: 16)
        n.nodeDescription = "VIII:\n\nFactor VIII\nNon-Vitamin K-dependent liver synthesis\nInherited FVIII deficiency is responible for Haemophilia A\nActivated by FIXa and FIIa"
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseTwoStartTime, time: 1, nodeTag: 24)
        n.hiddenAtStart = true
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseTwoStartTime, time: 2, nodeTag: 41)
        //n.animationType = Utils.AnimationType.disappear
        //n.disappearTime = 16
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseTwoStartTime, time: 3, nodeTag: 20)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseTwoStartTime, time: 3, nodeTag: 25)
        n.nodeDescription = "VWF:\n\nVon Willebrand Factor\nMediates platelet adhesion to site of vascular damage\nCarrier of FVIII in plasma\nInherited defects of VWF result in VW Disease"
        sceneData.nodeList.append(n)

        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseTwoStartTime, time: 4, nodeTag: 37)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseTwoStartTime,time: 4, nodeTag: 22)
        sceneData.nodeList.append(n)
        

        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseTwoStartTime, time: 5, nodeTag: 36)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseTwoStartTime,time: 5, nodeTag: 23)
        sceneData.nodeList.append(n)
        

        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseTwoStartTime, time: 6, nodeTag: 43)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseTwoStartTime, time: 7, nodeTag: 17)
        sceneData.nodeList.append(n)
        
        
        // ***************************** PHASE THREE - AMPLIFICATION PHASE *****************************
        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseThreeStartTime,time: 1, nodeTag: 8)
        sceneData.nodeList.append(n)

        /*
        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseThreeStartTime, time: 2, nodeTag: 5)
        n.animationType = Utils.AnimationType.blink
        n.blinkTime = 2
        sceneData.nodeList.append(n)
        */

        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseThreeStartTime, time: 3, nodeTag: 14)
        sceneData.nodeList.append(n)
        
        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseThreeStartTime,time: 4, nodeTag: 38)
        n.nodeDescription = "Fibrinogen:\n\nFibrinogen /Factor I \nNon-Vitamin K-dependent liver synthesis\nConverted by Thrombin to Fibrin"
        sceneData.nodeList.append(n)

        
        // ***************************** PHASE THREE - FIBRIN FORMATION *****************************
        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseFourStartTime, time: 1, nodeTag: 15)
        sceneData.nodeList.append(n)

        n = CoagulationCascadeNodeModel(phaseStartTime:kPhaseFourStartTime, time: 2, nodeTag: 39)
        sceneData.nodeList.append(n)

    }
}
