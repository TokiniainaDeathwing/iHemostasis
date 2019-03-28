//
//  DisclaimerViewController.swift
//  iHemostasis
//
//  Created by Zo Rajaonarivony on 09/12/2015.
//  Copyright © 2015 Diagnostica Stago S.A.S. All rights reserved.
//

import UIKit

class DisclaimerViewController: ParentViewController {
    @IBOutlet weak var webView : UIWebView?
    @IBOutlet weak var closeButton: UIButton?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let file = NSBundle.mainBundle().URLForResource("Credits",
            withExtension: "html")!
        
        let request = NSURLRequest(URL: file)
        webView?.loadRequest(request)
        
        webView?.backgroundColor = UIColor.clearColor()
        webView?.opaque = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
