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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: textCellIdentifier, for: indexPath as IndexPath) as UITableViewCell
        cell.backgroundColor = UIColor.clear
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.text = "Clinical Case " + String(indexPath.row + 1)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dismiss(animated: true, completion: nil)
        delegate?.onItemSelection(index: indexPath.row)
    }
}
