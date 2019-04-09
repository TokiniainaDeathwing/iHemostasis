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
        
        let file = Bundle.main.url(forResource: "Credits", withExtension: "html")
        
        let request = NSURLRequest(url: (file ?? nil)!)
        webView?.loadRequest(request as URLRequest)
        
        webView?.backgroundColor = UIColor.clear
        webView?.isOpaque = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
