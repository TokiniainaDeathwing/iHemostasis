//
//  HomeButton.swift
//  iHemostasis
//
//  Created by M01 on 28/01/2021.
//  Copyright © 2021 com.stago. All rights reserved.
//

import Foundation
class HomeButton : UIButton{
    override init(frame: CGRect) {
           super.init(frame: frame)

           // set other operations after super.init, if required
           backgroundColor = .red
       }
    
   
    required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        let screenSize: CGRect = UIScreen.main.bounds
       // frame=CGRect(x: 0, y: 0, width:  20, height:50)
            // set other operations after super.init if required
        //widthAnchor.constraint(equalToConstant: screenSize.width*0.5).isActive = true
        //widthAnchor.constraint(equalToConstant:screenSize.height*0.5).isActive = true
        
        imageView?.widthAnchor.constraint(equalToConstant: 10).isActive = true
        imageView?.heightAnchor.constraint(equalToConstant: 10).isActive = true
       
//        titleLabel?.widthAnchor.constraint(equalToConstant:frame.width*0.95).isActive = true
      titleLabel?.numberOfLines = 1
       titleLabel?.adjustsFontSizeToFitWidth = true
       titleLabel?.lineBreakMode = .byClipping
    }
}
