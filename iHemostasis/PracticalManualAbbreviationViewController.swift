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
        let backButton:UIButton = UIButton(type: UIButton.ButtonType.custom) as UIButton
        backButton.frame = CGRect(0, 0, 32, 32)
        backButton.addTarget(self, action: #selector(backButtonAction), for: UIControl.Event.touchUpInside)
        backButton.setTitle("", for: UIControl.State.normal)
        backButton.setTitleColor(UIColor.blue, for: UIControl.State.normal)
        let myCustomBackButtonItem:UIBarButtonItem = UIBarButtonItem(customView: backButton)
        self.navigationItem.leftBarButtonItem  = myCustomBackButtonItem
        backButton.setBackgroundImage(backbuttonImage, for: .normal)

        
        // Load pdf file
        let file = Bundle.main.url(forResource: "Abbreviations",
                                                        withExtension: "pdf")!
        
        let request = NSURLRequest(url: file)
        webView?.loadRequest(request as URLRequest)
        self.setScreenTitle(title: "Abbreviations")
        
    }
}

