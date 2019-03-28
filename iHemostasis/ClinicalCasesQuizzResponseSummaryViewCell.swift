//
//  ClinicalCasesQuizzResponseSummaryViewCell.swift
//  iHemostasis
//
//  Created by Zo Rajaonarivony on 28/01/2016.
//  Copyright © 2016 Diagnostica Stago S.A.S. All rights reserved.
//

import UIKit

class ClinicalCasesQuizzResponseSummaryViewCell: UITableViewCell {
    @IBOutlet weak var quizzQuestionLabel: UILabel?
    @IBOutlet weak var cellBackgroundView: UIView?
    @IBOutlet weak var quizzGoodAnswerLabel: UILabel?
    @IBOutlet weak var checkboxImageView: UIImageView?
    
    func reloadData(data: ClinicalCasesModel) {
        var userCorrectPoint: Int = 0
        var userIncorrectPoint: Int = 0
        var quizzTotalCorrectPoint: Int = 0
        
        self.quizzQuestionLabel?.text = data.title
        
        var correctResponseResume: String = ""
        for object in data.responses {
            if object.correctness == true {
                correctResponseResume = correctResponseResume + (object.response)! + " / "
            }
        }
        
        
        for object in data.responses {
            if object.correctness == true {
                quizzTotalCorrectPoint = quizzTotalCorrectPoint + 1
            }
            
            // Check now if user answers are correct
            if object.userResponse == object.correctness && object.correctness == true {
                userCorrectPoint = userCorrectPoint + 1
            }
            
            // Check now if user answers are incorrect
            if object.userResponse == true && object.correctness == false {
                userIncorrectPoint = userIncorrectPoint + 1
            }
            
        }
        
        // Let's colour our view answer
        if (userCorrectPoint == quizzTotalCorrectPoint && userIncorrectPoint == 0) {
            cellBackgroundView?.backgroundColor = colorWithHexString("#70BD16") // Green
            checkboxImageView?.highlighted = true
            self.quizzQuestionLabel?.textColor = UIColor.whiteColor()
            self.quizzGoodAnswerLabel?.textColor = UIColor.whiteColor()
        }
        else {
            if (userCorrectPoint > 0 && userIncorrectPoint == 0) {
                cellBackgroundView?.backgroundColor = Utils.colorWithHexString("#EFEFF4") // Grey
                checkboxImageView?.highlighted = true
                self.quizzGoodAnswerLabel?.textColor = UIColor.blackColor()
                self.quizzQuestionLabel?.textColor = UIColor.blackColor()
            }
            else if (userCorrectPoint > 0 && userIncorrectPoint >= 0) {
                cellBackgroundView?.backgroundColor = Utils.colorWithHexString("#EFEFF4") // Grey
                checkboxImageView?.highlighted = false
                self.quizzQuestionLabel?.textColor = UIColor.blackColor()
                self.quizzGoodAnswerLabel?.textColor = UIColor.blackColor()
            }
                
            else if (userCorrectPoint == 0) {
                cellBackgroundView?.backgroundColor = Utils.colorWithHexString("#BD2716") // Red
                checkboxImageView?.highlighted = false
                self.quizzGoodAnswerLabel?.textColor = UIColor.whiteColor()
                self.quizzQuestionLabel?.textColor = UIColor.whiteColor()
            }
            
        }
        quizzGoodAnswerLabel?.text = "GOOD ANSWER: " + correctResponseResume
    }
    
    // Creates a UIColor from a Hex string.
    func colorWithHexString (hex:String) -> UIColor {
        var cString:String = hex.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).uppercaseString
        
        if (cString.hasPrefix("#")) {
            cString = (cString as NSString).substringFromIndex(1)
        }
        
        if (cString.characters.count != 6) {
            return UIColor.grayColor()
        }
        
        let rString = (cString as NSString).substringToIndex(2)
        let gString = ((cString as NSString).substringFromIndex(2) as NSString).substringToIndex(2)
        let bString = ((cString as NSString).substringFromIndex(4) as NSString).substringToIndex(2)
        
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        NSScanner(string: rString).scanHexInt(&r)
        NSScanner(string: gString).scanHexInt(&g)
        NSScanner(string: bString).scanHexInt(&b)
        
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
    }

   
}
