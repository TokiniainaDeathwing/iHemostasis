//
//  SpecialFocusListViewController.swift
//  iHemostasis
//
//  Created by Zo Rajaonarivony on 09/12/2015.
//  Copyright © 2015 Diagnostica Stago S.A.S. All rights reserved.
//

import UIKit

class SpecialFocusListViewController: ParentViewController {
    @IBOutlet weak var webView : UIWebView?
    @IBOutlet weak var contextMenuTableView: UITableView?
    @IBOutlet weak var blankView : UIView?
    
    var contextMenuTitleList: [String] = [
        "HIT range",
        "Antiplatelet therapy",
        "DIC and Fibrin Related Markers",
        "Microparticles",
        "NOAC"]
    
    var contextMenuSubTitleList: [String] = [
        "Diagnosis of Heparin Induced Thrombocytopenia",
        "",
        "A comprehensive offer",
        "",
        "Role of the Clinical Laboratory in Patients Receiving New Oral Anticoagulants"]
    
    var fileToDisplay: [String] = [
        "III-Diag of HIT pour APPS rev. FD 140521-def",
        "III-ANTIPLATLET pour APPS rev FD 140521-def",
        "III-DIC and Fibrin Related Markers pour APPS rev. FD 140521-def",
        "III-MICROPARTICLES_pour APPS rev. FD 140521-def",
        "III-NOAC pour APPS rev. FD 140521-def"
    ]
    
    let textCellIdentifier = "textCellIdentifier"

    @IBOutlet weak var tableView : UITableView?
    @IBOutlet weak var menuButton : UIButton?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        let orient = UIApplication.sharedApplication().statusBarOrientation
        
        switch orient {
        case .Portrait:
            self.contextMenuTableView?.hidden = true
            self.menuButton?.hidden = false
            self.contextMenuTableView?.frame = CGRectMake(506, 130, 262, 894)
            self.webView?.frame = CGRectMake(0, 130.0, screenSize.width, 894)
            self.blankView?.hidden = false
        default:
            self.contextMenuTableView?.hidden = false
            self.menuButton?.hidden = true
            
            self.contextMenuTableView?.frame = CGRectMake(0, 90, 292, 700)
            
            self.webView?.frame = CGRectMake((self.contextMenuTableView?.frame.width)!, 90.0, screenSize.width - (self.contextMenuTableView?.frame.width)!, 670)
            
            self.blankView?.hidden = true
        }
        

        let file = NSBundle.mainBundle().URLForResource("III-Diag of HIT pour APPS rev. FD 140521-def", withExtension: "pdf")!
        let request = NSURLRequest(URL: file)
        webView?.loadRequest(request)
        self.setScreenTitle("Special Focus")
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        contextMenuTableView?.selectRowAtIndexPath(indexPath, animated: false, scrollPosition: .None)
        
        let backbuttonImage: UIImage? = UIImage(named: "Back-ArrowWHITE")
        let backButton:UIButton = UIButton(type: UIButtonType.Custom) as UIButton
        backButton.frame = CGRectMake(0, 0, 32, 32)
        backButton.addTarget(self, action: "backButtonAction", forControlEvents: UIControlEvents.TouchUpInside)
        backButton.setTitle("", forState: UIControlState.Normal)
        backButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        let myCustomBackButtonItem:UIBarButtonItem = UIBarButtonItem(customView: backButton)
        self.navigationItem.leftBarButtonItem  = myCustomBackButtonItem
        backButton.setBackgroundImage(backbuttonImage, forState: .Normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func onItemSelection(index: Int) {
        let fileName = fileToDisplay[index]
        let file = NSBundle.mainBundle().URLForResource(fileName, withExtension: "pdf")!
        let request = NSURLRequest(URL: file)
        webView?.loadRequest(request)
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animateAlongsideTransition({ (UIViewControllerTransitionCoordinatorContext) -> Void in
            
            let orient = UIApplication.sharedApplication().statusBarOrientation
            let screenSize: CGRect = UIScreen.mainScreen().bounds
            
            switch orient {
            case .Portrait:
                self.contextMenuTableView?.hidden = true
                self.menuButton?.hidden = false
                self.contextMenuTableView?.frame = CGRectMake(506, 130, 262, 894)
                self.webView?.frame = CGRectMake(0, 130.0, screenSize.width, 894)
                self.blankView?.hidden = false
            default:
                self.contextMenuTableView?.hidden = false
                self.menuButton?.hidden = true
                self.contextMenuTableView?.frame = CGRectMake(0, 90, 292, 700)
                self.webView?.frame = CGRectMake((self.contextMenuTableView?.frame.width)!, 90.0, screenSize.width - (self.contextMenuTableView?.frame.width)!, 670)
                self.blankView?.hidden = true
            }
            
            }, completion: { (UIViewControllerTransitionCoordinatorContext) -> Void in
                print("rotation completed")
        })
        
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
    }
    
    // TableView
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contextMenuTitleList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(textCellIdentifier, forIndexPath: indexPath) as UITableViewCell
        
        let row = indexPath.row
        cell.textLabel?.text = contextMenuTitleList[row]
        cell.textLabel?.textColor = UIColor.whiteColor()
        cell.textLabel?.highlightedTextColor = UIColor.blackColor()
        
        cell.detailTextLabel?.text = contextMenuSubTitleList[row]
        cell.detailTextLabel?.textColor = UIColor.whiteColor()
        cell.detailTextLabel?.highlightedTextColor = UIColor.blackColor()
        cell.backgroundColor = UIColor.clearColor()
        
        let backgroundSelectionView:UIView = UIView(frame: CGRectMake(100, 200, 100, 100))
        backgroundSelectionView.backgroundColor = UIColor.whiteColor()
        cell.selectedBackgroundView	 = backgroundSelectionView
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.onItemSelection(indexPath.row)
        let orient = UIApplication.sharedApplication().statusBarOrientation
        if orient == .Portrait {
            contextMenuTableView?.hidden = true
        }
    }
    
    // IBAction
    @IBAction func contextMenuButtonAction(sender: UIButton) {
        if contextMenuTableView?.hidden == true {
            contextMenuTableView?.hidden = false
        }
        else {
            contextMenuTableView?.hidden = true
        }
    }
    
}
