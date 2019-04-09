//
//  PracticalManualViewController.swift
//  iHemostasis
//
//  Created by Zo Rajaonarivony on 14/09/2016.
//  Copyright © 2016 com.stago. All rights reserved.
//

import UIKit

class PracticalManualViewController: ParentViewController {
    @IBOutlet weak var labelOne: UILabel?
    @IBOutlet weak var labelTwo: UILabel?
    @IBOutlet weak var buttonOne: UIButton?
    @IBOutlet weak var buttonTwo: UIButton?
    @IBOutlet weak var buttonThree: UIButton?
    @IBOutlet weak var viewOne: UIView?
    @IBOutlet weak var viewTwo: UIView?
    @IBOutlet weak var viewThree: UIView?
    @IBOutlet weak var haemoscoreAppLabel: UILabel?
    
    private let practicalManualChaptersOne = [
        ["description":"", "title":"Pathophysiology", "colour":"#d48634", "author":"Bas De Laat", "entity":"Synapse BV and Maastricht University Maastricht, The Netherlands"],
        ["description":"", "title":"Clinical manifestations", "colour":"#00a5eb", "author":"Luc Darnige", "entity":"Service d’Hématologie Biologique\nHôpital Européen Georges Pompidou - APHP - Paris, France"],
        ["description":"", "title":"Laboratory diagnosis:\nImmunoassays", "colour":"#674b99", "author":"Vittorio Pengo & Allessandra Banzanto", "entity": "Departement of Cardiac,\nThoracic and Vascular Sciences\nUniversity of Padova, Italy"],
        ["description":"", "title":"Laboratory diagnosis:\nLupus anticoagulant", "colour":"#674b99", "author":"Katrien Devreese", "entity":"Coagulation Laboratory\nGhent University Hospital, Belgium"],
        ["description":"", "title":"Laboratory diagnosis:\nApplication of current guidelines\nfor LA detection", "colour":"#674b99", "author":"Gary W. Moore", "entity":"Departement of Haemostasis & Thrombosis\nSt. Thomas' Hospital - London, England"],
        ["description":"", "title":"Management of patients", "colour":"#8f7759", "author":"Luc Darnige", "entity":"Service d’Hématologie Biologique\nHôpital Européen Georges Pompidou - APHP - Paris, France"],
        ]
    
    private let practicalManualChaptersTwo = [
        ["description":"", "title":"Unfractionated Heparin", "colour":"#d48634", "author":"Noel C. Chan & Jack Hirsh", "entity": "Department of Medicine, Monash University,\nClayton, Victoria, Australia,\nDepartment of Medicine,\nMacMaster University\nHamilton, Ontario, Canada"],
        ["description":"", "title":"Low Molecular Weight Heparins", "colour":"#00a5eb", "author":"Susanne Alban", "entity": "Pharmaceutical Insitute,\nChristian-Albrechts-University of Kiel\nKiel, Germany"],
        ["description":"", "title":"Heparin-induced Thrombocytopenia", "colour":"#674b99", "author":"Claire Pouplard","entity":"Haematology Laboratory and\nHaemophilia Care Centre,\nTours University Hospital – Tours, France"],
        ["description":"", "title":"Fondaparinux", "colour":"#8f7759", "author":"Maurice Petitou & Pierre Guéret","entity":"Consultant, (formerly at Institut Choay and Sanofi) Paris France,\nHaematology Laboratory and Haemophilia Care Centre\nUniversity Hospital, Rennes, France"],
        /*["description":"", "title":"Fondaparinux", "colour":"#8f7759", "author":"Maurice Petitou & Pierre Guéret","entity":"Consultant,\n(formerly at Institut  Choay and Sanofi) Paris France, and Haematology Laboratory and Haemophilia Care Centre University Hospital \nRennes, France"],*/

        ["description":"", "title":"Danaparoid sodium", "colour":"#b33b22", "author":"Theodore E. Warkentin","entity":"Department of Pathology and Molecular Medicine, and Department of Medicine, McMaster University\nHamilton, Ontario, Canada"],
        ["description":"", "title":"Direct Thrombin Inhibitors", "colour":"#3286cc", "author":"Michael Spannagl","entity":"Hospital of the Ludwig-Maximilians-University,\nMunich, Germany"],
    ]
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        reloadUI(size: size)
    }
    
    func reloadUI(size: CGSize) {
        let orient = UIApplication.shared.statusBarOrientation
        
        switch orient {
        case .portrait:
            viewOne?.frame.origin = CGPoint(50, 265)
            viewTwo?.frame.origin = CGPoint(371, 265)
            viewThree?.frame.origin = CGPoint(691, 265)
        default:
            viewOne?.frame.origin = CGPoint(71, 69)
            viewTwo?.frame.origin = CGPoint(447, 69)
            viewThree?.frame.origin = CGPoint(71, 502)
        }
    }
    
    private func setupUI() {
        let orient = UIApplication.shared.statusBarOrientation
        
        switch orient {
        case .portrait:
            //isLandscape = false
            viewOne?.frame.origin = CGPoint(71, 69)
            viewTwo?.frame.origin = CGPoint(447, 69)
            viewThree?.frame.origin = CGPoint(71, 502)
        case .portraitUpsideDown:
            viewOne?.frame.origin = CGPoint(71, 69)
            viewTwo?.frame.origin = CGPoint(447, 69)
            viewThree?.frame.origin = CGPoint(71, 502)
            
        default:
            viewOne?.frame.origin = CGPoint(50, 265)
            viewTwo?.frame.origin = CGPoint(371, 265)
            viewThree?.frame.origin = CGPoint(691, 265)
            
            //isLandscape = true
        }
        
        // Set the orientation to always landscape
        /*
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
        */
        labelOne!.font  = UIFont(name: Utils.MAIN_MENU_FONT_NAME, size: Utils.PRACTICAL_MANUAL_MENU_TITLE)
        labelTwo!.font  = UIFont(name: Utils.MAIN_MENU_FONT_NAME, size: Utils.PRACTICAL_MANUAL_MENU_TITLE)
        haemoscoreAppLabel!.font  = UIFont(name: Utils.MAIN_MENU_FONT_NAME, size: Utils.PRACTICAL_MANUAL_MENU_TITLE)
        
        self.setScreenTitle(title: "Practical Manual Series")
        
        let backbuttonImage: UIImage? = UIImage(named: "Back-ArrowWHITE")
        let backButton:UIButton = UIButton(type: UIButton.ButtonType.custom) as UIButton
        backButton.frame = CGRect(0, 0, 32, 32)
        backButton.addTarget(self, action: #selector(backButtonAction), for: UIControl.Event.touchUpInside)
        backButton.setTitle("", for: UIControl.State.normal)
        backButton.setTitleColor(UIColor.blue, for: UIControl.State.normal)
        let myCustomBackButtonItem:UIBarButtonItem = UIBarButtonItem(customView: backButton)
        self.navigationItem.leftBarButtonItem  = myCustomBackButtonItem
        backButton.setBackgroundImage(backbuttonImage, for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    @IBAction func buttonAction(target: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let practicalManualChapterViewController = storyBoard.instantiateViewController(withIdentifier: "PracticalManualChapterViewController") as! PracticalManualChapterViewController
        if (target == buttonOne) {
            practicalManualChapterViewController.practicalManualChapters = practicalManualChaptersOne
            practicalManualChapterViewController.setScreenTitle(title: "Antiphospholip syndrome")
            practicalManualChapterViewController.practicalManualType = Utils.PracticalManualType.AntiphospholipidSyndrome
            self.navigationController!.pushViewController(practicalManualChapterViewController, animated: true)
            self.navigationController!.navigationBar.topItem?.title = "     "
        }
        else if (target == buttonTwo) {
            practicalManualChapterViewController.practicalManualChapters = practicalManualChaptersTwo
            practicalManualChapterViewController.setScreenTitle(title: "Parenteral anticoagulants")
            practicalManualChapterViewController.practicalManualType = Utils.PracticalManualType.ParenteralAnticoagulants
            self.navigationController!.pushViewController(practicalManualChapterViewController, animated: true)
            self.navigationController!.navigationBar.topItem?.title = "     "
        }
        else if (target == buttonThree) {
            UIApplication.shared.openURL(NSURL(string: Utils.HAEMOSCORE_URL)! as URL)
        }
    }
    
}
