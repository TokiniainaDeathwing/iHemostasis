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
        
        let orient = UIApplication.shared.statusBarOrientation
        let screenSize: CGRect = UIScreen.main.bounds
        
        switch orient {
        case .portrait:
            self.contextMenuTableView?.isHidden = true
            self.menuButton?.isHidden = false
            self.contextMenuTableView?.frame = CGRect((blankView?.frame.width)!, 130, screenSize.width - (blankView?.frame.width)!, screenSize.height - 130)
            self.webView?.frame = CGRect(0, 130.0, screenSize.width, screenSize.height - 130)
            self.blankView?.isHidden = false
        default:
            self.contextMenuTableView?.isHidden = false
            self.menuButton?.isHidden = true
            
            self.contextMenuTableView?.frame = CGRect(0, 90, 292, screenSize.height - 90)
            
            self.webView?.frame = CGRect((self.contextMenuTableView?.frame.width)!, 90.0, screenSize.width - (self.contextMenuTableView?.frame.width)!, screenSize.height - 90)
            self.blankView?.isHidden = true
            
        }
        
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        
        let file = Bundle.main.url(forResource: "QuickGuide1", withExtension: "pdf")!
        let request = NSURLRequest(url: file)
        webView?.loadRequest(request as URLRequest)
        self.setScreenTitle(title: "Quick Guide")
        
        // Select the first row
        let indexPath = NSIndexPath(row: 0, section: 0)
        contextMenuTableView?.selectRow(at: indexPath as IndexPath, animated: false, scrollPosition: .none)
        
        let backbuttonImage: UIImage? = UIImage(named: "Back-ArrowWHITE")
        let backButton:UIButton = UIButton(type: UIButton.ButtonType.custom) as UIButton
        backButton.frame = CGRect(0, 0, 32, 32)
        backButton.addTarget(self, action: #selector(backButtonAction),for: .touchUpInside)
        backButton.setTitle("", for: UIControl.State.normal)
        backButton.setTitleColor(UIColor.blue, for: UIControl.State.normal)
        let myCustomBackButtonItem:UIBarButtonItem = UIBarButtonItem(customView: backButton)
        self.navigationItem.leftBarButtonItem  = myCustomBackButtonItem
        backButton.setBackgroundImage(backbuttonImage, for: .normal)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func onItemSelection(index: Int) {
        let fileName = fileToDisplay[index]
        let file = Bundle.main.url(forResource: fileName, withExtension: "pdf")!
        let request = NSURLRequest(url: file)
        webView?.loadRequest(request as URLRequest)
    }
    
    // TableView
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contextMenuTitleList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: textCellIdentifier, for: indexPath as IndexPath) as UITableViewCell
        
        let row = indexPath.row
        cell.textLabel?.text = contextMenuTitleList[row]
        cell.textLabel?.textColor = UIColor.white
        cell.backgroundColor = UIColor.clear
        cell.textLabel?.highlightedTextColor = UIColor.black
        
        cell.detailTextLabel?.text = contextMenuSubTitleList[row]
        cell.detailTextLabel?.textColor = UIColor.white
        cell.detailTextLabel?.highlightedTextColor = UIColor.black
        cell.backgroundColor = UIColor.clear
        
        let backgroundSelectionView:UIView = UIView(frame: CGRect(100, 200, 100, 100))
        backgroundSelectionView.backgroundColor = UIColor.white
        cell.selectedBackgroundView     = backgroundSelectionView
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.onItemSelection(index: indexPath.row)
        let orient = UIApplication.shared.statusBarOrientation
        if orient == .portrait {
            contextMenuTableView?.isHidden = true
        }
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) -> Void in
            
            let orient = UIApplication.shared.statusBarOrientation
            let screenSize: CGRect = UIScreen.main.bounds
            
            switch orient {
            case .portrait:
                self.contextMenuTableView?.isHidden = true
                self.menuButton?.isHidden = false
                self.contextMenuTableView?.frame = CGRect((self.blankView?.frame.width)!, 130, screenSize.width - (self.blankView?.frame.width)!, screenSize.height - 130)
                self.webView?.frame = CGRect(0, 130.0, screenSize.width, screenSize.height - 130)
                self.blankView?.isHidden = false
            default:
                self.contextMenuTableView?.isHidden = false
                self.menuButton?.isHidden = true
                self.contextMenuTableView?.frame = CGRect(0, 90, 292, screenSize.height - 90)
                self.webView?.frame = CGRect((self.contextMenuTableView?.frame.width)!, 90.0, screenSize.width - (self.contextMenuTableView?.frame.width)!, screenSize.height - 90)
                self.blankView?.isHidden = true
            }
            
        }, completion: { (UIViewControllerTransitionCoordinatorContext) -> Void in
            print("rotation completed")
        })
        
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    // IBAction
    @IBAction func contextMenuButtonAction(sender: UIButton) {
        if contextMenuTableView?.isHidden == true {
            contextMenuTableView?.isHidden = false
        }
        else {
            contextMenuTableView?.isHidden = true
        }
    }
    
}
