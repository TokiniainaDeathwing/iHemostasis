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
            cellBackgroundView?.backgroundColor = colorWithHexString(hex: "#70BD16") // Green
            checkboxImageView?.isHighlighted = true
            self.quizzQuestionLabel?.textColor = UIColor.white
            self.quizzGoodAnswerLabel?.textColor = UIColor.white
        }
        else {
            if (userCorrectPoint > 0 && userIncorrectPoint == 0) {
                cellBackgroundView?.backgroundColor = Utils.colorWithHexString(hex: "#EFEFF4") // Grey
                checkboxImageView?.isHighlighted = true
                self.quizzGoodAnswerLabel?.textColor = UIColor.black
                self.quizzQuestionLabel?.textColor = UIColor.black
            }
            else if (userCorrectPoint > 0 && userIncorrectPoint >= 0) {
                cellBackgroundView?.backgroundColor = Utils.colorWithHexString(hex: "#EFEFF4") // Grey
                checkboxImageView?.isHighlighted = false
                self.quizzQuestionLabel?.textColor = UIColor.black
                self.quizzGoodAnswerLabel?.textColor = UIColor.black
            }
                
            else if (userCorrectPoint == 0) {
                cellBackgroundView?.backgroundColor = Utils.colorWithHexString(hex: "#BD2716") // Red
                checkboxImageView?.isHighlighted = false
                self.quizzGoodAnswerLabel?.textColor = UIColor.white
                self.quizzQuestionLabel?.textColor = UIColor.white
            }
            
        }
        quizzGoodAnswerLabel?.text = "GOOD ANSWER: " + correctResponseResume
    }
    
    // Creates a UIColor from a Hex string.
    func colorWithHexString (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: NSCharacterSet.whitespaces).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString = (cString as NSString).substring(from: 1)
        }
        
        if (cString.characters.count != 6) {
            return UIColor.gray
        }
        
        let rString = (cString as NSString).substring(to: 2)
        let gString = ((cString as NSString).substring(from: 2) as NSString).substring(to: 2)
        let bString = ((cString as NSString).substring(from: 4) as NSString).substring(to: 2)
        
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
    }

   
}
