//
//  ParentViewController.swift
//  iHemostasis
//
//  Created by Zo Rajaonarivony on 29/01/2016.
//  Copyright © 2016 Diagnostica Stago S.A.S. All rights reserved.
//

import UIKit

class ParentViewController: UIViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }
    
    func setScreenTitle(title: String) {
        let titleLabel: UILabel = UILabel(frame: CGRect(x: 700, y: 0, width: 800, height: 40))
        titleLabel.text = title
        titleLabel.font  = UIFont(name: Utils.SCREEN_TITLE_FONT_NAME, size: Utils.SCREEN_TITLE_FONT_SIZE)
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.textAlignment = .Right
        self.navigationItem.titleView = titleLabel;
    }
    
    func backButtonAction() {
        self.navigationController?.popViewControllerAnimated(true)
    }
}


extension UINavigationController {
    public override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if visibleViewController is CoagulationCascadeListViewController || visibleViewController is CoagulationCascadePlayerViewController/* || visibleViewController is ClinicalCasesListViewController */{
            super.supportedInterfaceOrientations()
            return UIInterfaceOrientationMask.LandscapeLeft
        }
        return UIInterfaceOrientationMask.All
    }
/*
    public override func shouldAutorotate() -> Bool {
        if visibleViewController is CoagulationCascadeListViewController || visibleViewController is CoagulationCascadePlayerViewController {
            let value = UIInterfaceOrientation.LandscapeLeft.rawValue
            UIDevice.currentDevice().setValue(value, forKey: "orientation")
            return false
        }
        return true
    }*/
}
