//
//  ClinicalCasesQuizzDetailMenuListViewController.swift
//  iHemostasis
//
//  Created by Zo Rajaonarivony on 26/01/2016.
//  Copyright © 2016 Diagnostica Stago S.A.S. All rights reserved.
//

import UIKit

protocol ClinicalCasesQuizzDetailMenuListViewControllerDelegate {
    func onItemSelection(index: Int)
}

class ClinicalCasesQuizzDetailMenuListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    var delegate: ClinicalCasesQuizzDetailMenuListViewControllerDelegate?
    
    let textCellIdentifier = "textCellIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // TableView
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(textCellIdentifier, forIndexPath: indexPath) as UITableViewCell
        cell.backgroundColor = UIColor.clearColor()
        cell.textLabel?.textColor = UIColor.whiteColor()
        cell.textLabel?.text = "Clinical Case " + String(indexPath.row + 1)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.dismissViewControllerAnimated(true, completion: nil)
        delegate?.onItemSelection(indexPath.row)
    }
}
