//
//  SpecialFocusListViewController.swift
//  iHemostasis
//
//  Created by Zo Rajaonarivony on 09/12/2015.
//  Copyright © 2015 Diagnostica Stago S.A.S. All rights reserved.
//

import UIKit

class SpecialFocusListViewController: ParentViewController, UITableViewDelegate, UITableViewDataSource {
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
        
        let screenSize: CGRect = UIScreen.main.bounds
        let orient = UIApplication.shared.statusBarOrientation
        
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
        

        let file = Bundle.main.url(forResource: "III-Diag of HIT pour APPS rev. FD 140521-def", withExtension: "pdf")
        let request = NSURLRequest(url: (file ?? nil)!)
        webView?.loadRequest(request as URLRequest)
        self.setScreenTitle(title: "Special Focus")
        let indexPath = NSIndexPath(row: 0, section: 0)
        contextMenuTableView?.selectRow(at: indexPath as IndexPath, animated: false, scrollPosition: .none)
        
        let backbuttonImage: UIImage? = UIImage(named: "Back-ArrowWHITE")
        let backButton:UIButton = UIButton(type: UIButton.ButtonType.custom) as UIButton
        backButton.frame = CGRect(0, 0, 32, 32)
        backButton.addTarget(self, action: #selector(ParentViewController.backButtonAction), for: UIControl.Event.touchUpInside)
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
        }
        super.viewWillTransition(to: size, with: coordinator)
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
        cell.textLabel?.highlightedTextColor = UIColor.black
        
        cell.detailTextLabel?.text = contextMenuSubTitleList[row]
        cell.detailTextLabel?.textColor = UIColor.white
        cell.detailTextLabel?.highlightedTextColor = UIColor.black
        cell.backgroundColor = UIColor.clear
        
        let backgroundSelectionView:UIView = UIView(frame: CGRect(100, 200, 100, 100))
        backgroundSelectionView.backgroundColor = UIColor.white
        cell.selectedBackgroundView	 = backgroundSelectionView
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.onItemSelection(index: indexPath.row)
        let orient = UIApplication.shared.statusBarOrientation
        if orient == .portrait {
            contextMenuTableView?.isHidden = true
        }
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
