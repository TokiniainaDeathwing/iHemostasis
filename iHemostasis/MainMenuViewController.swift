//
//  MainMenuViewController.swift
//  iHemostasis
//
//  Created by Zo Rajaonarivony on 09/12/2015.
//  Copyright © 2015 Diagnostica Stago S.A.S. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {
    // UI Logic
    @IBOutlet weak var coagulationCascadeButton : UIButton?
    @IBOutlet weak var clinicalCasesButton : UIButton?
    @IBOutlet weak var specialFocusButton : UIButton?
    @IBOutlet weak var quickGuideButton : UIButton?
    @IBOutlet weak var disclaimerButton : UIButton?
    @IBOutlet weak var practicalManualButton : UIButton?
    @IBOutlet weak var backgroundImageView : UIImageView?
    
    var disclaimerViewController: DisclaimerViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true

        coagulationCascadeButton!.titleLabel!.font  = UIFont(name: Utils.MAIN_MENU_FONT_NAME, size: Utils.MAIN_MENU_FONT_SIZE)
        clinicalCasesButton!.titleLabel!.font  = UIFont(name: Utils.MAIN_MENU_FONT_NAME, size: Utils.MAIN_MENU_FONT_SIZE)
        specialFocusButton!.titleLabel!.font  = UIFont(name: Utils.MAIN_MENU_FONT_NAME, size: Utils.MAIN_MENU_FONT_SIZE)
        quickGuideButton!.titleLabel!.font  = UIFont(name: Utils.MAIN_MENU_FONT_NAME, size: Utils.MAIN_MENU_FONT_SIZE)
        practicalManualButton!.titleLabel!.font = UIFont(name: Utils.MAIN_MENU_FONT_NAME, size: Utils.MAIN_MENU_FONT_SIZE)
        disclaimerButton!.titleLabel!.font  = UIFont(name: Utils.MAIN_MENU_FONT_NAME, size: Utils.MAIN_MENU_DISCLAIMER_FONT_SIZE)
        /*
        for family: String in UIFont.familyNames()
        {
            print("\(family)")
            for names: String in UIFont.fontNamesForFamilyName(family)
            {
                print("== \(names)")
            }
        }
        */
        let orient = UIApplication.shared.statusBarOrientation
        
        /*
        switch orient {
        case .Portrait:
            self.backgroundImageView?.frame = CGRectMake(0, -60, (self.backgroundImageView?.frame.width)!, (self.backgroundImageView?.frame.height)!)
        default:
            self.backgroundImageView?.frame = CGRectMake(0, 60, (self.backgroundImageView?.frame.width)!, (self.backgroundImageView?.frame.height)!)
        }*/
        switch orient {
        case .landscapeLeft:
            self.backgroundImageView?.frame = CGRect(0, 60, (self.backgroundImageView?.frame.width)!, (self.backgroundImageView?.frame.height)!)
        case .landscapeRight:
            self.backgroundImageView?.frame = CGRect(0, 60, (self.backgroundImageView?.frame.width)!, (self.backgroundImageView?.frame.height)!)
        default:
            self.backgroundImageView?.frame = CGRect(0, 0, (self.backgroundImageView?.frame.width)!, (self.backgroundImageView?.frame.height)!)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) -> Void in
            
            let orient = UIApplication.shared.statusBarOrientation
            //let screenSize: CGRect = UIScreen.mainScreen().bounds
            /*
            switch orient {
            case .Portrait:
                //self.backgroundImageView?.frame = CGRectMake(0, 0, (self.backgroundImageView?.frame.width)!, (self.backgroundImageView?.frame.height)!)
            default:
                //self.backgroundImageView?.frame = CGRectMake(0, 60, (self.backgroundImageView?.frame.width)!, (self.backgroundImageView?.frame.height)!)
            }*/
            switch orient {
            case .landscapeLeft:
                self.backgroundImageView?.frame = CGRect(0, 60, (self.backgroundImageView?.frame.width)!, (self.backgroundImageView?.frame.height)!)
            case .landscapeRight:
                self.backgroundImageView?.frame = CGRect(0, 60, (self.backgroundImageView?.frame.width)!, (self.backgroundImageView?.frame.height)!)
            default:
                self.backgroundImageView?.frame = CGRect(0, 0, (self.backgroundImageView?.frame.width)!, (self.backgroundImageView?.frame.height)!)
            }
            
            },
                    completion: { (UIViewControllerTransitionCoordinatorContext) -> Void in
                print("rotation completed")
        })

        super.viewWillTransition(to: size, with: coordinator)
    }
    
        
    @IBAction func disclaimerButtonAction(sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        disclaimerViewController = storyBoard.instantiateViewController(withIdentifier: "DisclaimerViewController") as? DisclaimerViewController
        
        let screenSize: CGRect = UIScreen.main.bounds
        
        disclaimerViewController?.view.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height)
        disclaimerViewController?.closeButton?.addTarget(self, action: #selector(disclaimerCloseButtonAction), for: UIControl.Event.touchUpInside)
        self.view.addSubview((disclaimerViewController?.view)!)
    }
    
    @objc func disclaimerCloseButtonAction(sender: UIButton) {
        disclaimerViewController?.view.removeFromSuperview()
    }
}
