//
//  PracticalManualAbbreviationViewController.swift
//  iHemostasis
//
//  Created by zoraj on 06/12/2016.
//  Copyright © 2016 com.stago. All rights reserved.
//

class PracticalManualAbbreviationViewController: ParentViewController {
    @IBOutlet weak var webView: UIWebView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Customize back button
        let backbuttonImage: UIImage? = UIImage(named: "Back-ArrowWHITE")
        let backButton:UIButton = UIButton(type: UIButtonType.Custom) as UIButton
        backButton.frame = CGRectMake(0, 0, 32, 32)
        backButton.addTarget(self, action: "backButtonAction", forControlEvents: UIControlEvents.TouchUpInside)
        backButton.setTitle("", forState: UIControlState.Normal)
        backButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        let myCustomBackButtonItem:UIBarButtonItem = UIBarButtonItem(customView: backButton)
        self.navigationItem.leftBarButtonItem  = myCustomBackButtonItem
        backButton.setBackgroundImage(backbuttonImage, forState: .Normal)

        
        // Load pdf file
        let file = NSBundle.mainBundle().URLForResource("Abbreviations",
                                                        withExtension: "pdf")!
        
        let request = NSURLRequest(URL: file)
        webView?.loadRequest(request)
        self.setScreenTitle("Abbreviations")
        
    }
}
