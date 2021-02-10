//
//  PracticalManualDetailViewController.swift
//  iHemostasis
//
//  Created by zoraj on 15/09/2016.
//  Copyright © 2016 com.stago. All rights reserved.
//
import WebKit
import UIKit

class PracticalManualDetailViewController: ParentViewController, UITableViewDelegate, UITableViewDataSource,UIWebViewDelegate {
    @IBOutlet weak var webViewContainerView : UIView?
    @IBOutlet weak var webView : WKWebView?
    @IBOutlet weak var contextMenuTableView: UITableView?
    @IBOutlet weak var blankView : UIView?
    
    var currentChapterIndex: Int = 0
    
    var contextMenuPointer  = [
        ["":""]
    ];

    
    let textCellIdentifier = "textCellIdentifier"
    
    @IBOutlet weak var tableView : UITableView?
    @IBOutlet weak var menuButton : UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.reloadUI()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        
        
        // Load the html
        let contextMenuItem = contextMenuPointer[0]
        var filename : String
        filename = contextMenuItem["filename"]!
        if(UIDevice.current.userInterfaceIdiom == .phone){
            filename += " copy";
        }
        let file = Bundle.main.url(forResource: filename, withExtension: "html")!
        let request = URLRequest(url: file)
        //let request = NSURLRequest(url: file)
        webView?.load(request)
        //webView?.loadRequest(request as URLRequest)
        
        /*
        // Load the first page
        let title = contextMenuItem["title"] as! String!
        let figure = contextMenuItem["figurename"] as! String!
        webView?.stringByEvaluatingJavaScriptFromString("loadPage('" + title + "');")
        webViewForPicture?.stringByEvaluatingJavaScriptFromString("loadPage('" + figure + "');")
        */
        
        
        // Select the first row
        let indexPath = NSIndexPath(row: 0, section: 0)
        contextMenuTableView?.selectRow(at: indexPath as IndexPath, animated: false, scrollPosition: .none)
        //self.onItemSelection(index: self.currentChapterIndex)
        
        let backbuttonImage: UIImage? = UIImage(named: "Back-ArrowWHITE")
        let backButton:UIButton = UIButton(type: UIButton.ButtonType.custom) as UIButton
        backButton.frame = CGRect(0, 0, 32, 32)
        backButton.addTarget(self, action: #selector(backButtonAction), for: UIControl.Event.touchUpInside)
        backButton.setTitle("", for: UIControl.State.normal)
        backButton.setTitleColor(UIColor.blue, for: UIControl.State.normal)
        let myCustomBackButtonItem:UIBarButtonItem = UIBarButtonItem(customView: backButton)
        self.navigationItem.leftBarButtonItem  = myCustomBackButtonItem
        backButton.setBackgroundImage(backbuttonImage, for: .normal)
        
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
        let orient = UIApplication.shared.statusBarOrientation
        let screenSize: CGRect = UIScreen.main.bounds
        if(UIDevice.current.userInterfaceIdiom == .pad){
            switch orient {
            case .portrait:
                self.contextMenuTableView?.isHidden = true
                self.menuButton?.isHidden = false
                self.contextMenuTableView?.frame = CGRect((self.blankView?.frame.width)!, 130, screenSize.width - (self.blankView?.frame.width)!, screenSize.height - 130)
                self.webView?.frame = CGRect(0, 80, screenSize.width - (self.contextMenuTableView?.frame.width)!, screenSize.height - 100)
                if self.webViewContainerView?.isHidden == true {
                    self.webViewContainerView?.frame = CGRect(600, 130.0, screenSize.width, screenSize.height - 130)
                }
                else {
                    self.webViewContainerView?.frame = CGRect(0, 130.0, screenSize.width, screenSize.height - 130)
                }
                self.blankView?.isHidden = false
            default:
                self.contextMenuTableView?.isHidden = false
                self.menuButton?.isHidden = true
                
                self.contextMenuTableView?.frame = CGRect(0, 90, 292, screenSize.height - 90)
                
                //self.webView?.frame = CGRect((self.contextMenuTableView?.frame.width)!, 90.0, screenSize.width - (self.contextMenuTableView?.frame.width)!, 670)
                //self.webViewContainerView?.backgroundColor = UIColor.redColor()
                //self.webView?.frame = CGRect(50.0, 90.0, screenSize.width - (self.contextMenuTableView?.frame.width)! - 100, 870)
                self.webViewContainerView?.frame = CGRect((self.contextMenuTableView?.frame.width)!, 90.0, screenSize.width - (self.contextMenuTableView?.frame.width)!, screenSize.height - 90)
                self.webView?.frame = CGRect(0, 50.0, screenSize.width - (self.contextMenuTableView?.frame.width)!, screenSize.height - 50)
                self.blankView?.isHidden = true
            }
        }else{
            switch orient {
            case .portrait:
                self.contextMenuTableView?.isHidden = true
                self.menuButton?.isHidden = false
//                self.contextMenuTableView?.frame = CGRect((self.blankView?.frame.width)!, 130, screenSize.width - (self.blankView?.frame.width)!, screenSize.height - 130)
//                self.webView?.frame = CGRect(10, 80, screenSize.width , screenSize.height - 180)
//                if self.webViewContainerView?.isHidden == true {
//                    self.webViewContainerView?.frame = CGRect(600, 130.0, screenSize.width , screenSize.height - 180)
//                }
//                else {
//                    self.webViewContainerView?.frame = CGRect(0, 130.0, screenSize.width   , screenSize.height - 180)
//                }
                self.blankView?.isHidden = false
            default:
                self.contextMenuTableView?.isHidden = false
                self.menuButton?.isHidden = true
                
                self.contextMenuTableView?.frame = CGRect(0, 90, 292, screenSize.height - 90)
                
                //self.webView?.frame = CGRect((self.contextMenuTableView?.frame.width)!, 90.0, screenSize.width - (self.contextMenuTableView?.frame.width)!, 670)
                //self.webViewContainerView?.backgroundColor = UIColor.redColor()
                //self.webView?.frame = CGRect(50.0, 90.0, screenSize.width - (self.contextMenuTableView?.frame.width)! - 100, 870)
                self.webViewContainerView?.frame = CGRect((self.contextMenuTableView?.frame.width)!, 90.0, screenSize.width - (self.contextMenuTableView?.frame.width)!, screenSize.height - 90)
                self.webView?.frame = CGRect(0, 50.0, screenSize.width - (self.contextMenuTableView?.frame.width)!, screenSize.height - 50)
                self.blankView?.isHidden = true
            }
        }
    
    }
    
    func onItemSelection(index: Int) {
        let contextMenuItem = contextMenuPointer[index]
        let title = contextMenuItem["title"]
        if(UIDevice.current.userInterfaceIdiom == .pad){
            webView?.evaluateJavaScript("loadPage(\"" + ((title! )) + "\");")
        }else{
            webView?.evaluateJavaScript("loadPage2(\"" + ((title! )) + "\");")
        }
        webView?.evaluateJavaScript( "scrollTo(0, 0);")
      //  webView?.stringByEvaluatingJavaScript(from: "loadPage(\"" + ((title! )) + "\");")
        //webView?.stringByEvaluatingJavaScript(from: "scrollTo(0, 0);")
    }
    
    // TableView
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contextMenuPointer.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: textCellIdentifier, for: indexPath as IndexPath) as UITableViewCell
        
        let row = indexPath.row
        let contextMenuItem = contextMenuPointer[row]
        
        cell.textLabel?.text = contextMenuItem["title"] 
        cell.textLabel?.textColor = UIColor.white
        cell.backgroundColor = UIColor.clear
        cell.textLabel?.highlightedTextColor = UIColor.black
        
        cell.detailTextLabel?.text = contextMenuItem["author"] 
        cell.detailTextLabel?.textColor = UIColor.white
        cell.detailTextLabel?.highlightedTextColor = UIColor.black
        
        let backgroundSelectionView:UIView = UIView(frame: CGRect(100, 200, 100, 100))
        backgroundSelectionView.backgroundColor = UIColor.white
        cell.selectedBackgroundView	 = backgroundSelectionView
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.currentChapterIndex = indexPath.row
        self.onItemSelection(index: self.currentChapterIndex)
        let orient = UIApplication.shared.statusBarOrientation
        if orient == .portrait {
            contextMenuTableView?.isHidden = true
        }
        self.webView?.isHidden = false
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) -> Void in
                self.reloadUI()
            
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
    
    func webViewDidFinishLoad(_ webView : WKWebView) {
        if (self.webView == webView) {
            // Load the first page
            let contextMenuItem = contextMenuPointer[0]
            let title = contextMenuItem["title"]
           // webView.stringByEvaluatingJavaScript(from: "loadPage(\"" + ((title! )) + "\");")
           // webView.scrollView.contentOffset = CGPoint(webView.scrollView.contentOffset.x, 0);
            if(UIDevice.current.userInterfaceIdiom == .pad){
             webView.evaluateJavaScript("loadPage(\"" + ((title! )) + "\");")
            }else{
                webView.evaluateJavaScript("loadPage2(\"" + ((title! )) + "\");")
            }
            
             webView.scrollView.contentOffset = CGPoint(webView.scrollView.contentOffset.x, 0);
        }
    }
}
