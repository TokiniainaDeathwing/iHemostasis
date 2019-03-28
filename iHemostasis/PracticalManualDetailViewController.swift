//
//  PracticalManualDetailViewController.swift
//  iHemostasis
//
//  Created by zoraj on 15/09/2016.
//  Copyright © 2016 com.stago. All rights reserved.
//

import UIKit

class PracticalManualDetailViewController: ParentViewController {
    @IBOutlet weak var webViewContainerView : UIView?
    @IBOutlet weak var webView : UIWebView?
    @IBOutlet weak var contextMenuTableView: UITableView?
    @IBOutlet weak var blankView : UIView?
    
    var currentChapterIndex: Int = 0
    var contextMenuPointer = []
    
    let textCellIdentifier = "textCellIdentifier"
    
    @IBOutlet weak var tableView : UITableView?
    @IBOutlet weak var menuButton : UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.reloadUI()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.translucent = true
        
        
        // Load the html
        let contextMenuItem = contextMenuPointer[0]
        let filename = contextMenuItem["filename"] as! String!
        let file = NSBundle.mainBundle().URLForResource(filename, withExtension: "html")!
        let request = NSURLRequest(URL: file)
        webView?.loadRequest(request)
        
        /*
        // Load the first page
        let title = contextMenuItem["title"] as! String!
        let figure = contextMenuItem["figurename"] as! String!
        webView?.stringByEvaluatingJavaScriptFromString("loadPage('" + title + "');")
        webViewForPicture?.stringByEvaluatingJavaScriptFromString("loadPage('" + figure + "');")
        */
        
        // Select the first row
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        contextMenuTableView?.selectRowAtIndexPath(indexPath, animated: false, scrollPosition: .None)
        //self.onItemSelection(self.currentChapterIndex)
        
        let backbuttonImage: UIImage? = UIImage(named: "Back-ArrowWHITE")
        let backButton:UIButton = UIButton(type: UIButtonType.Custom) as UIButton
        backButton.frame = CGRectMake(0, 0, 32, 32)
        backButton.addTarget(self, action: "backButtonAction", forControlEvents: UIControlEvents.TouchUpInside)
        backButton.setTitle("", forState: UIControlState.Normal)
        backButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        let myCustomBackButtonItem:UIBarButtonItem = UIBarButtonItem(customView: backButton)
        self.navigationItem.leftBarButtonItem  = myCustomBackButtonItem
        backButton.setBackgroundImage(backbuttonImage, forState: .Normal)
        
        /*
        // Setup swipe
        let swipeToTheLeft = UISwipeGestureRecognizer(target: self, action: #selector(PracticalManualDetailViewController.handleSwipe(_:)))
        swipeToTheLeft.direction = UISwipeGestureRecognizerDirection.Left
        webView?.addGestureRecognizer(swipeToTheLeft)
        
        let swipeToTheRight = UISwipeGestureRecognizer(target: self, action: #selector(PracticalManualDetailViewController.handleFigureSwipe(_:)))
        swipeToTheRight.direction = UISwipeGestureRecognizerDirection.Right
        webViewForPicture?.addGestureRecognizer(swipeToTheRight)
        webViewForPicture?.hidden = true
        */
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func reloadUI() {
        let orient = UIApplication.sharedApplication().statusBarOrientation
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        
        switch orient {
        case .Portrait:
            self.contextMenuTableView?.hidden = true
            self.menuButton?.hidden = false
            self.contextMenuTableView?.frame = CGRectMake(506, 130, 262, 894)
            self.webView?.frame = CGRectMake(0, 130.0, screenSize.width - 100, 894)
            if self.webViewContainerView?.hidden == true {
                self.webViewContainerView?.frame = CGRectMake(600, 130.0, screenSize.width, 894)
            }
            else {
                self.webViewContainerView?.frame = CGRectMake(0, 130.0, screenSize.width, 894)
            }
            self.blankView?.hidden = false
        default:
            self.contextMenuTableView?.hidden = false
            self.menuButton?.hidden = true
            
            self.contextMenuTableView?.frame = CGRectMake(0, 90, 292, 700)
            
            //self.webView?.frame = CGRectMake((self.contextMenuTableView?.frame.width)!, 90.0, screenSize.width - (self.contextMenuTableView?.frame.width)!, 670)
            //self.webViewContainerView?.backgroundColor = UIColor.redColor()
            //self.webView?.frame = CGRectMake(50.0, 90.0, screenSize.width - (self.contextMenuTableView?.frame.width)! - 100, 870)
            self.webView?.frame = CGRectMake(-90.0, 50.0, screenSize.width - (self.contextMenuTableView?.frame.width)! + 90.0, 770)
            self.webViewContainerView?.frame = CGRectMake((self.contextMenuTableView?.frame.width)!, 90.0, screenSize.width - (self.contextMenuTableView?.frame.width)!, 770)
            self.blankView?.hidden = true
        }
    }
    
    func onItemSelection(index: Int) {
        let contextMenuItem = contextMenuPointer[index]
        let title = contextMenuItem["title"] as! String!
        webView?.stringByEvaluatingJavaScriptFromString("loadPage('" + title + "');")
        webView?.stringByEvaluatingJavaScriptFromString("scrollTo(0, 0);")
    }
    
    // TableView
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contextMenuPointer.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(textCellIdentifier, forIndexPath: indexPath) as UITableViewCell
        
        let row = indexPath.row
        let contextMenuItem = contextMenuPointer[row]
        
        cell.textLabel?.text = contextMenuItem["title"] as! String!
        cell.textLabel?.textColor = UIColor.whiteColor()
        cell.backgroundColor = UIColor.clearColor()
        cell.textLabel?.highlightedTextColor = UIColor.blackColor()
        
        cell.detailTextLabel?.text = contextMenuItem["author"] as! String!
        cell.detailTextLabel?.textColor = UIColor.whiteColor()
        cell.detailTextLabel?.highlightedTextColor = UIColor.blackColor()
        
        let backgroundSelectionView:UIView = UIView(frame: CGRectMake(100, 200, 100, 100))
        backgroundSelectionView.backgroundColor = UIColor.whiteColor()
        cell.selectedBackgroundView	 = backgroundSelectionView
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.currentChapterIndex = indexPath.row
        self.onItemSelection(self.currentChapterIndex)
        let orient = UIApplication.sharedApplication().statusBarOrientation
        if orient == .Portrait {
            contextMenuTableView?.hidden = true
        }
        self.webView?.hidden = false
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animateAlongsideTransition({ (UIViewControllerTransitionCoordinatorContext) -> Void in
                self.reloadUI()
            
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
    
    func webViewDidFinishLoad(webView : UIWebView) {
        if (self.webView == webView) {
            // Load the first page
            let contextMenuItem = contextMenuPointer[0]
            let title = contextMenuItem["title"] as! String!
            webView.stringByEvaluatingJavaScriptFromString("loadPage('" + title + "');")
            webView.scrollView.contentOffset = CGPointMake(webView.scrollView.contentOffset.x, 0);
        }
    }
}
