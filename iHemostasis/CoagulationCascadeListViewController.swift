//
//  CoagulationCascadeMenuListViewController.swift
//  iHemostasis
//
//  Created by Zo Rajaonarivony on 09/12/2015.
//  Copyright © 2015 Diagnostica Stago S.A.S. All rights reserved.
//

import UIKit

class CoagulationCascadeListViewController: ParentViewController {
    @IBOutlet weak var cc1Label: UILabel?
    @IBOutlet weak var cc2Label: UILabel?
    @IBOutlet weak var cc3Label: UILabel?
    @IBOutlet weak var cc4Label: UILabel?
    @IBOutlet weak var cc5Label: UILabel?
    
    let kTitleSize: CGFloat = 20.0
    
    override func viewDidLoad() {
        super.viewDidLoad();
        setupUI()
    }
    
    func setupUI() {
        if(UIDevice.current.userInterfaceIdiom == .pad){
                self.setScreenTitle(title: "Coagulation Cascade")
                
                // Set the orientation to always landscape
                let orient = UIApplication.shared.statusBarOrientation
                switch orient {
                case .landscapeLeft:
                    break
                case .landscapeRight:
                    break
                default:
                    let value = UIInterfaceOrientation.landscapeLeft.rawValue
                    UIDevice.current.setValue(value, forKey: "orientation")
                }
                
                self.cc1Label?.font  = UIFont(name: Utils.MAIN_MENU_FONT_NAME, size: kTitleSize)
                self.cc2Label?.font  = UIFont(name: Utils.MAIN_MENU_FONT_NAME, size: kTitleSize)
                self.cc3Label?.font  = UIFont(name: Utils.MAIN_MENU_FONT_NAME, size: kTitleSize)
                self.cc4Label?.font  = UIFont(name: Utils.MAIN_MENU_FONT_NAME, size: kTitleSize)
                self.cc5Label?.font  = UIFont(name: Utils.MAIN_MENU_FONT_NAME, size: kTitleSize)
            }
            let backbuttonImage: UIImage? = UIImage(named: "Back-ArrowWHITE")
            let backButton:UIButton = UIButton(type: UIButton.ButtonType.custom) as UIButton
            backButton.frame = CGRect(0, 0, 32, 32)
            backButton.addTarget(self, action: #selector(backButtonAction),for: UIControl.Event.touchUpInside)
            backButton.setTitle("", for: UIControl.State.normal)
            backButton.setTitleColor(UIColor.blue, for: UIControl.State.normal)
            let myCustomBackButtonItem:UIBarButtonItem = UIBarButtonItem(customView: backButton)
            self.navigationItem.leftBarButtonItem  = myCustomBackButtonItem
            backButton.setBackgroundImage(backbuttonImage, for: .normal)
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    /*
    override func shouldAutorotate() -> Bool {
        super.shouldAutorotate()
        return false
    }
 */
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.landscapeLeft
    }
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let coagulationCascadePlayerViewController = storyBoard.instantiateViewController(withIdentifier: "CoagulationCascadePlayerViewController") as! CoagulationCascadePlayerViewController
        coagulationCascadePlayerViewController.animationIndex = indexPath.row
        self.navigationController!.pushViewController(coagulationCascadePlayerViewController, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let playerViewController = segue.destination as! CoagulationCascadePlayerViewController
        playerViewController.animationIndex = Int(segue.identifier!)!
    }
    
}

/*

extension CoagulationCascadeListViewController {
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CoagulationCascadeMenuViewCell", forIndexPath: indexPath) as! CoagulationCascadeMenuViewCell
        //cell.photo = photos[indexPath.item]
        
        return cell
    }
}

*/

/*
extension PhotoStreamViewController : PinterestLayoutDelegate {
    // 1. Returns the photo height
    func collectionView(collectionView:UICollectionView, heightForPhotoAtIndexPath indexPath:NSIndexPath , withWidth width:CGFloat) -> CGFloat {
        let photo = photos[indexPath.item]
        let boundingRect =  CGRect(x: 0, y: 0, width: width, height: CGFloat(MAXFLOAT))
        let rect  = AVMakeRectWithAspectRatioInsideRect(photo.image.size, boundingRect)
        return rect.size.height
    }
    
    // 2. Returns the annotation size based on the text
    func collectionView(collectionView: UICollectionView, heightForAnnotationAtIndexPath indexPath: NSIndexPath, withWidth width: CGFloat) -> CGFloat {
        let annotationPadding = CGFloat(4)
        let annotationHeaderHeight = CGFloat(17)
        
        let photo = photos[indexPath.item]
        let font = UIFont(name: "AvenirNext-Regular", size: 10)!
        let commentHeight = photo.heightForComment(font, width: width)
        let height = annotationPadding + annotationHeaderHeight + commentHeight + annotationPadding
        return height
    }
}
*/




