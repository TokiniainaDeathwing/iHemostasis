//
//  QuickGuideListViewController.swift
//  iHemostasis
//
//  Created by Zo Rajaonarivony on 09/12/2015.
//  Copyright © 2015 Diagnostica Stago S.A.S. All rights reserved.
//

import UIKit

/*
protocol QuickGuideListViewControllerDelegate {
    //func onItemSelection(controller: QuickGuideListViewController, index: Int)
    func onItemSelection(index: Int)
}
*/

class QuickGuideListViewController: ParentViewController, UITableViewDataSource, UITableViewDelegate {
    

    @IBOutlet weak var webView : UIWebView?
    @IBOutlet weak var menuButton : UIButton?
    @IBOutlet weak var contextMenuTableView: UITableView?
    @IBOutlet weak var blankView : UIView?

    var contextMenuTitleList: [String] = [
        "Screening assays in Haemostasis",
        "Anticoagulant therapy monitoring (1)",
        "Anticoagulant therapy monitoring (2)",
        "Assays for other anticoagulant therapy (3)",
        "Disseminated Intravascular Coagulation (DIC)",
        "Thrombophilia",
        "D-Dimer assay for the exclusion of venous thromboembolism (VTE)",
        "Lupus anticoagulants / Antiphospholipid antibodies",
        "Haemostasis / paediatrics",
        "Haemostasis / pregnancy"]
    
    var contextMenuSubTitleList: [String] = [
        "Overview",
        "Oral anticoagulant therapy with vitamin K antagonists",
        "Unfractionated heparin (UFH) and low molecular Wight heparin (LMWH)...",
        "Hirudin, Danaparoid Sodium, Fondaparinux...",
        "Clinical and laboratory diagnosis,...",
        "Classification, diagnostic tests, values, prevalence, prenalytic...",
        "DVT, PE, others causes, NPV...",
        "",
        "",
        ""]
    var fileToDisplay: [String] = [
        "QuickGuide1",
        "QuickGuide2",
        "QuickGuide3",
        "QuickGuide4",
        "QuickGuide5",
        "QuickGuide6",
        "QuickGuide7",
        "QuickGuide8",
        "11-12028 Fiche Paediatrics IPAD MaJ BD V3",
        "11-12028 Fiche Pregnancy IPAD MaJ BD V3"
        
    ]
    
    let textCellIdentifier = "textCellIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        

        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.translucent = true
        
        let file = NSBundle.mainBundle().URLForResource("QuickGuide1", withExtension: "pdf")!
        let request = NSURLRequest(URL: file)
        webView?.loadRequest(request)
        self.setScreenTitle("Quick Guide")
        
        // Select the first row
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
        cell.backgroundColor = UIColor.clearColor()
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
