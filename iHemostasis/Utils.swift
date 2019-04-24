//
//  Utils.swift
//  iHemostasis
//
//  Created by Zo Rajaonarivony on 29/01/2016.
//  Copyright © 2016 Diagnostica Stago S.A.S. All rights reserved.
//

import Foundation

public class Utils {
    static let MAIN_MENU_FONT_NAME = "Barmeno-Regular"
    static let MAIN_MENU_FONT_SIZE: CGFloat = 34.0
    static let MAIN_MENU_DISCLAIMER_FONT_SIZE: CGFloat = 18.0
    static let PRACTICAL_MANUAL_MENU_TITLE: CGFloat = 21.0
    
    static let SCREEN_TITLE_FONT_NAME = "Barmeno-Regular"
    static let SCREEN_TITLE_FONT_SIZE: CGFloat = 32.0
    static let CLINICAL_CASE_ALL_ABOVE_TEST_TEXT = "All of the above tests"
    
    static let RED_COLOR = "BD2716"
    
    static let HAEMOSCORE_URL = "https://itunes.apple.com/us/app/haemoscore/id972605212?mt=8"
    
    enum AnimationType {
        case normal
        case disappear
        case blink
        case translation
        case translationAndDisappear
    }
    
    enum PracticalManualType {
        case AntiphospholipidSyndrome
        case ParenteralAnticoagulants
        case OralAnticoagulants
        case BleedingDisorders
    }
    
    // Creates a UIColor from a Hex string.
    static func colorWithHexString (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in:NSCharacterSet.whitespacesAndNewlines).uppercased()
        
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
