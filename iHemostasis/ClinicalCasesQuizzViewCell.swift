//
//  ClinicalCasesQuizzViewCell.swift
//  iHemostasis
//
//  Created by Zo Rajaonarivony on 28/12/2015.
//  Copyright © 2015 Diagnostica Stago S.A.S. All rights reserved.
//

import UIKit

class ClinicalCasesQuizzViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var checkboxImageView: UIImageView?
    
    func reloadData(data: ClinicalCasesResponseModel) {

        if data.userResponse == true {
            self.checkboxImageView?.isHighlighted = true
        }
        else {
            self.checkboxImageView?.isHighlighted = false
        }
        
        
        self.titleLabel?.text = data.response
    }
}
