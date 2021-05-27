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
    @IBOutlet weak var labelThree: UILabel?
    @IBOutlet weak var labelFive: UILabel?
    @IBOutlet weak var labelSix: UILabel!
    @IBOutlet weak var labelSeven: UILabel!
    //Ajout labelSix
    @IBOutlet weak var buttonOne: UIButton?
    @IBOutlet weak var buttonTwo: UIButton?
    @IBOutlet weak var buttonThree: UIButton?
    @IBOutlet weak var buttonFour: UIButton?
    @IBOutlet weak var buttonFive: UIButton?
    @IBOutlet weak var buttonSix: UIButton?
    @IBOutlet weak var buttonSeven: UIButton!
    
    
    //Ajout buttonSix
    @IBOutlet weak var viewOne: UIView?
    @IBOutlet weak var viewTwo: UIView?
    @IBOutlet weak var viewThree: UIView?
    @IBOutlet weak var viewFour: UIView?
    @IBOutlet weak var viewFive: UIView?
    @IBOutlet weak var viewSix: UIView?
    @IBOutlet weak var viewSeven: UIView!
    @IBOutlet weak var haemoscoreAppLabel: UILabel?
    
    @IBOutlet var scrollView: UIScrollView!
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
    
    private let practicalManualChaptersThree = [
        ["description":"", "title":"Vitamin K Antagonists", "colour":"#d48634", "author":"Virginie Siguret* & Eric Pautas**", "entity": "AP-HP – Paris, France INSERM UMR-S-1140, Paris Descartes Université\n*Clinical Haematology Laboratory,University Hospital Lariboisière\n**Departement of Gerontology,University Hospitals Pitie-Salpêtrière-Charles Foix"],
        ["description":"", "title":"Dabigatran Etexilate: Pharmacological and Clinical Aspects", "colour":"#00a5eb", "author":"Jeffrey I. Weitz* & James C. Fredenburgh", "entity": "Department of Medicine,McMaster University – Hamilton, Ontario, Canada\n*Department of Biochemistry and Biomedical Sciences"],
        ["description":"", "title":"Dabigatran Etexilate: \nClinical Laboratory Aspects", "colour":"#9D4C9D", "author":"François Mullier","entity":"Université catholique de Louvain,\nCHU UCL Namur, Namur Thrombosis and Hemostasis center,\nHematology Laboratory – Namur, Belgium"],
        ["description":"", "title":"Direct Factor Xa Inhibitors: \nPharmacological and Clinical Aspects", "colour":"#8f7759", "author":"Walter Ageno","entity":"Department of Clinical and Experimental Medicine,\nUniversity of Insubria – Varese, Italy"],
        ["description":"", "title":"Direct Factor Xa Inhibitors: \nClinical Laboratory Aspects", "colour":"#BF2F1C", "author":"Isabelle Gouin-Thibault","entity":"Clinical Haematology Laboratory\nPontchaillou University Hospital – Rennes, France\nINSERM UMR-S-1140, Paris Descartes Université – Paris, France"],
        ["description":"", "title":"Reversal of Direct Oral \nAnticoagulants", "colour":"#3B87C8", "author":"Marcel Levi","entity":"Department of Medicine,\nUniversity College London Hospitals – London, United Kingdom\nDepartment of Vascular Medicine,\nUniversity of Amsterdam – Amsterdam, The Netherland"],
        ["description":"", "title":"Periprocedural Anticoagulant \nManagement", "colour":"#9D4C9D", "author":"Alfonso Tafur* & James Douketis**","entity":"Department of Medicine\n*Division of Cardiology-Vascular Medicine\nNorthShore University HealthSystem – Evanston, Illinois, USA\n**Department of Medicine,McMaster University – Hamilton, Ontario, Canada"],
        ["description":"", "title":"Thrombolysis in Patients Taking Oral Anticoagulants", "colour":"#A4C156", "author":"David J. Seiffge & Stefan T. Engelter","entity":"Department of Neurology,\nUniversity Hospital Basel – Basel, Switzerland"],
    ]
    
    private let practicalManualChaptersFour = [
        ["description":"", "title":"Haemophilia A and B:\nclinical aspects", "colour":"#d48634", "author":"Guy Young", "entity": "Hemostasis and Thrombosis Center,\nChildren’s Hospital Los Angeles,\nUniversity of Southern California Keck School of Medicine -\nLos Angeles, California, USA."],
        ["description":"", "title":"Haemophilia A and B:\nclinical laboratory aspects", "colour":"#00a5eb", "author":"Alberto Tosetto", "entity": "Hemostasis and Thrombosis Center,\nDepartment of Haematology,\nSan Bortolo Hospital - Vicenza, Italy."],
        ["description":"", "title":"Von Willebrand disease:\nclinical aspects", "colour":"#9D4C9D", "author":"Frank W.G. Leebeek","entity":"Department of Haematology,\nErasmus University Medical Centre -\nRotterdam, The Netherlands."],
        ["description":"", "title":"Von Willebrand disease:\nclinical laboratory aspects", "colour":"#8f7759", "author":"Raimondo De Cristofaro","entity":"Institute of Internal Medicine and Geriatrics,Haemostasis and Thrombosis Centre,Catholic University of the Sacred Heart School of Medicine - Rome, Italy."],
        ["description":"", "title":"Rare bleeding disorders", "colour":"#BF2F1C", "author":"Catherine Hayward","entity":"Departments of Pathology\nand Molecular Medicine and Department of Medicine,Hamilton Regional Laboratory Medicine Program,McMaster University – Hamilton, Ontario, Canada."],
        ["description":"", "title":"Acquired bleeding disorders:\npathophysiology,laboratory diagnosis,and treatment", "colour":"#3B87C8", "author":"Riitta Lassila","entity":"Coagulation Disorders Unit,\nDepartment of Haematology and Comprehensive Cancer Center,\nUniversity of Helsinki and Helsinki University Hospital - Helsinki, Finland."],
        ["description":"", "title":"Management of bleeding disorders", "colour":"#9D4C9D", "author":"Miguel Escobar* & Natalie Montanez**","entity":"Gulf States Hemophilia and Thrombophilia Center, University of Texas Health Science Center - Houston, Texas, USA.\n*Department of Internal Medicine and Pediatrics,\n**McGovern Medical School"],
        ["description":"", "title":"Bleeding disorders:\nspecial circumstances", "colour":"#A4C156","author":"Richard Gooding","entity":"Department of Haematology,\nUniversity Hospitals of Leicester -\nLeicester, United Kingdom."],
    ]
    
    //PraticalManualChapterFive (details)
    /*
     
     */
    private let praticalManualChaptersSix=[
    ["description":"", "title":"Platelet physiology", "colour":"#EA7805", "author":"Paul Harrison", "entity": "Institute of Inflammation and Ageing,\nCollege of Medical and Dental Sciences,\nUniversity of Birmingham - Birmingham, United Kingdom."],
    ["description":"", "title":"Platelet pathology: Thrombocytopenia", "colour":"#009FE4", "author":"Marco Cattaneo", "entity": "Division of Internal Medicine,\nSan Paolo Hospital and Milano University - Milano, Italy."],
    ["description":"", "title":"Platelet pathology: Thrombocythemia", "colour":"#724092", "author":"Michele P. Lamber and Mortimer Poncz", "entity": "Special Coagulation Laboratory,\nDepartment of Pediatrics, Division of Hematology,\nDivision of Hematology Jane,\nChildren’s Hospital of Philadelphia,\nUniversity of Pennsylvania – Philadelphia, Pennsylvania, USA."],
    ["description":"", "title":"Platelet pathology: Congenital platelet function disorders", "colour":"#80715D", "author":"Paolo Gresele, Loredana Bury, Emanuela Falcinelli", "entity": "Division of Internal and Cardiovascular Medicine,\nDepartment of Medicine,\nUniversity of Perugia - Perugia, Italy."],
    ["description":"", "title":"Acquired platelet anomalies induced by tyrosine kinase inhibitors", "colour":"#BD2A0C", "author":"Bernard Payrastre", "entity": "Haematology Laboratory,\nToulouse University Hospital,\nIINSERM U1048, Toulouse III Paul Sabatier University - Toulouse, France."],
    ["description":"", "title":"Laboratory diagnosis of platelet disorders", "colour":"#3F86C6", "author":"Catherine P.M. Hayward", "entity": "Departments of Pathology and Molecular Medicine, and Medicine\n Hamilton Regional Laboratory Medicine Program,\nMcMaster University - Hamilton, Ontario, Canada."],
    ["description":"", "title":"Viscoelastography: Review of its application to platelet function assessment", "colour":"#A44392", "author":"Joseph A. Jakubowski", "entity": "Lilly Research Laboratories,\nEli Lilly and Company - Indianapolis, Indiana, USA."],
    ["description":"", "title":"Antiplatelet drugs", "colour":"#B2C34A", "author":"Sergio Buccheri and Dominick J. Angiolillo", "entity": "Division of Cardiology,\nUniversity Hospital Vittorio Emanuele,\nUniversity of Catania - Catania, Italy.\n\nDivision of Cardiology,\nUniversity of Florida College of Medicine - Jacksonville, Florida, USA."],
    ["description":"", "title":"Perioperative management of patients on antiplatelet drugs", "colour":"#03723A", "author":"Elisabeth Mahla and Wolfgang Korte", "entity": "Anaesthesiology and Intensive Care Medicine,\nMedical University of Graz - Graz, Austria.\n\nHaemostasis and Haemophilia Center,\nCentre for Laboratory Medicine - Saint Gallen, Switzerland."],

    
    ]
    
    override func viewDidAppear(_ animated: Bool) {
      
      super.viewDidAppear(animated)
        AppDelegate.lockScreenIphone()
    
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if(UIDevice.current.userInterfaceIdiom == .phone){
            return UIInterfaceOrientationMask.portrait
        }
        else{
            return UIInterfaceOrientationMask.all
            
        }
    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        AppDelegate.lockScreenIphone()
        if(UIDevice.current.userInterfaceIdiom == .pad){
            reloadUI(size: size)
        }
    }
    
    func reloadUI(size: CGSize) {
        let orient = (size.width < size.height)
        switch orient {
        case true:
           /* viewOne?.frame.origin = CGPoint(71, 79)
            viewTwo?.frame.origin = CGPoint(447, 79)
            viewFour?.frame.origin = CGPoint(71, 552)
            viewFive?.frame.origin = CGPoint(447, 552)
            viewSix?.frame.origin = CGPoint(71, 1100)
            viewThree?.frame.origin=CGPoint(71,552)
            scrollView?.contentSize = CGSize(scrollView.frame.size.height,1600);*/
            viewOne?.frame.origin = CGPoint(71, 79)
            viewTwo?.frame.origin = CGPoint(447, 79)
            //viewFour?.frame.origin = CGPoint(71, 552)
            viewFive?.frame.origin = CGPoint(447, 552)
            viewSix?.frame.origin = CGPoint(71, 1100)
            viewThree?.frame.origin = CGPoint(71, 1600)
            //viewThree?.frame.origin = CGPoint(447, 1100)
            viewSeven?.frame.origin = CGPoint(447, 1100)
            viewFour?.frame.origin=CGPoint(71,552)
            scrollView?.contentSize = CGSize(scrollView.frame.size.height,2000);
        default:
            viewOne?.frame.origin = CGPoint(50, 69)
            viewTwo?.frame.origin = CGPoint(371, 69)
            viewFour?.frame.origin = CGPoint(691, 69)
            viewFive?.frame.origin = CGPoint(50, 542)
            viewSix?.frame.origin = CGPoint(371, 542)
            //viewThree?.frame.origin=CGPoint(691,542)
            viewSeven?.frame.origin=CGPoint(691,542)
            viewThree?.frame.origin=CGPoint(50,1000)
            scrollView?.contentSize = CGSize(scrollView.frame.size.width, 1400);
        }
    }
    
    private func setupUI() {
        let orient = UIApplication.shared.statusBarOrientation
        
        switch orient {
        case .portrait:
            //isLandscape = false
            viewOne?.frame.origin = CGPoint(71, 79)
            viewTwo?.frame.origin = CGPoint(447, 79)
            //viewFour?.frame.origin = CGPoint(71, 552)
            viewFive?.frame.origin = CGPoint(447, 552)
            viewSix?.frame.origin = CGPoint(71, 1100)
            viewThree?.frame.origin = CGPoint(71, 1600)
            //viewThree?.frame.origin = CGPoint(447, 1100)
            viewSeven?.frame.origin = CGPoint(447, 1100)
            viewFour?.frame.origin=CGPoint(71,552)
            scrollView?.contentSize = CGSize(scrollView.frame.size.height,2000);
        case .portraitUpsideDown:
            viewOne?.frame.origin = CGPoint(71, 79)
            viewTwo?.frame.origin = CGPoint(447, 79)
            //viewFour?.frame.origin = CGPoint(71, 552)
            viewFive?.frame.origin = CGPoint(447, 552)
            viewSix?.frame.origin = CGPoint(71, 1100)
            viewThree?.frame.origin = CGPoint(71, 1600)
            //viewThree?.frame.origin = CGPoint(447, 1100)
            viewSeven?.frame.origin = CGPoint(447, 1100)
            viewFour?.frame.origin=CGPoint(71,552)
            scrollView?.contentSize = CGSize(scrollView.frame.size.height,2000);
        default:
            viewOne?.frame.origin = CGPoint(50, 69)
            viewTwo?.frame.origin = CGPoint(371, 69)
            viewFour?.frame.origin = CGPoint(691, 69)
            viewFive?.frame.origin = CGPoint(50, 542)
            viewSix?.frame.origin = CGPoint(371, 542)
            //viewThree?.frame.origin=CGPoint(691,542)
            viewSeven?.frame.origin=CGPoint(691,542)
            viewThree?.frame.origin=CGPoint(50,1000)
            scrollView?.contentSize = CGSize(scrollView.frame.size.width, 1400);
            
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
        labelThree!.font  = UIFont(name: Utils.MAIN_MENU_FONT_NAME, size: Utils.PRACTICAL_MANUAL_MENU_TITLE)
        labelFive!.font  = UIFont(name: Utils.MAIN_MENU_FONT_NAME, size: Utils.PRACTICAL_MANUAL_MENU_TITLE)
        labelSix!.font  = UIFont(name: Utils.MAIN_MENU_FONT_NAME, size: Utils.PRACTICAL_MANUAL_MENU_TITLE)
        labelSeven!.font  = UIFont(name: Utils.MAIN_MENU_FONT_NAME, size: Utils.PRACTICAL_MANUAL_MENU_TITLE)
        haemoscoreAppLabel!.font  = UIFont(name: Utils.MAIN_MENU_FONT_NAME, size: Utils.PRACTICAL_MANUAL_MENU_TITLE)
        
        // Add labelSix
        
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
        let storyBoard : UIStoryboard
        if(UIDevice.current.userInterfaceIdiom == .phone){
            storyBoard  = UIStoryboard(name: "Main-iphone", bundle:nil)
        }else{
            storyBoard  = UIStoryboard(name: "Main", bundle:nil)
        }
      
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
        else if (target == buttonFour){
            practicalManualChapterViewController.practicalManualChapters = practicalManualChaptersThree
            practicalManualChapterViewController.setScreenTitle(title: "Oral anticoagulants")
            practicalManualChapterViewController.practicalManualType = Utils.PracticalManualType.OralAnticoagulants
            self.navigationController!.pushViewController(practicalManualChapterViewController, animated: true)
            self.navigationController!.navigationBar.topItem?.title = "     "
        }
        else if (target == buttonFive){
            practicalManualChapterViewController.practicalManualChapters = practicalManualChaptersFour
            practicalManualChapterViewController.setScreenTitle(title: "Bleeding disorders")
            practicalManualChapterViewController.practicalManualType = Utils.PracticalManualType.BleedingDisorders
            self.navigationController!.pushViewController(practicalManualChapterViewController, animated: true)
            self.navigationController!.navigationBar.topItem?.title = "     "
        }
        //Add new Button Six
        else if (target == buttonSix){
            practicalManualChapterViewController.practicalManualChapters = praticalManualChaptersSix
            practicalManualChapterViewController.setScreenTitle(title: "Platelets")
            practicalManualChapterViewController.practicalManualType = Utils.PracticalManualType.Platelets
            self.navigationController!.pushViewController(practicalManualChapterViewController, animated: true)
            self.navigationController!.navigationBar.topItem?.title = "     "
        }
        else if (target == buttonSeven){
            practicalManualChapterViewController.practicalManualChapters = praticalManualChaptersSix
            practicalManualChapterViewController.setScreenTitle(title: "Platelets")
            practicalManualChapterViewController.practicalManualType = Utils.PracticalManualType.Platelets
            self.navigationController!.pushViewController(practicalManualChapterViewController, animated: true)
            self.navigationController!.navigationBar.topItem?.title = "     "
        }
    }
    
}
