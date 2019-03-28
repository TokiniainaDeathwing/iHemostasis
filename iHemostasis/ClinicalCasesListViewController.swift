//
//  ClinicalCasesListViewController.swift
//  iHemostasis
//
//  Created by Zo Rajaonarivony on 09/12/2015.
//  Copyright © 2015 Diagnostica Stago S.A.S. All rights reserved.
//

import UIKit

class ClinicalCasesListViewController: ParentViewController {
  @IBOutlet var cells : Array <UIView>?
  private let kClinicalCaseCellIdentifier = "kClinicalCaseCellIdentifier"
  private let clinicalCases = [
    ["description":"Three-year old Julien us referred to laboratory for screening for a bleeding disorder. His parents brought him to visit the general practitioner because of his frequent and prolonged nosebleeds and bruising..."],
    ["description":"Mrs T., 35, is hospitalized after miscarriage at 15 weeks of gestation. She previously experiences two other miscarriages at 12 and 18 weeks of gestation..."],
    ["description":"Mr B, 75, is undergoing long term warfarin therapy at the prescribed dose of 5 mg/ day for atrial fibrillation. His treatment is stabilized and last zeek, his PT/INR ordered by the physician was measured at 2.2. He presented with oral thrush and started a local antifungal treatment (floconazole) 48 hoours ago..."],
    ["description":"A 31 year old male, with no specific medical history, flew 18 hours to go to his vacation resort. The day after his arrival, he felt an intense and hard pain in his chest with a significant dyspnea. He was immediately admitted to the Emergency Department..."],
    ["description":"Mr B, a 34 year-old man, presents with acute abdominal pain. The complete Blood Count results are consistent with appendicitis. According to the clinical outcome the physician diagnoses peritonitis..."],
    ["description":"Mrs G., 91 years old, is hospitalized for pulmonary embolism. She does not have severe renal insufficiency. She receives curative treatment by tinzaparin (Innohep, a low molecular weight heparin) 175 IU/kg OD..."],
  ]
  
  @IBOutlet var collectionView : UICollectionView!
  
  override func viewDidLoad() {
    super.viewDidLoad();
    
    let layout = collectionView.collectionViewLayout as! iHGridLayout
    layout.itemHeight = 280.0
    
    self.setScreenTitle("Clinical Cases")
    
    let backbuttonImage: UIImage? = UIImage(named: "Back-ArrowWHITE")
    let backButton:UIButton = UIButton(type: UIButtonType.Custom) as UIButton
    backButton.frame = CGRectMake(0, 0, 32, 32)
    backButton.addTarget(self, action: "backButtonAction", forControlEvents: UIControlEvents.TouchUpInside)
    backButton.setTitle("", forState: UIControlState.Normal)
    backButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
    let myCustomBackButtonItem:UIBarButtonItem = UIBarButtonItem(customView: backButton)
    self.navigationItem.leftBarButtonItem  = myCustomBackButtonItem
    backButton.setBackgroundImage(backbuttonImage, forState: .Normal)
    
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
    reloadUI(self.view.frame.size)
  }
    
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    let quizzDetailViewController = segue.destinationViewController as! ClinicalCasesQuizzDetailViewController
    quizzDetailViewController.quizzIdentifier = Int(segue.identifier!)!
  }
  
  override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
    reloadUI(size)
  }
  
  func reloadUI(size: CGSize) {
    var isLandscape = false
    
    let orient = UIApplication.sharedApplication().statusBarOrientation
    
    switch orient {
    case .Portrait:
        isLandscape = false
    default:
        isLandscape = true
    }
    
    let layout = collectionView.collectionViewLayout as! iHGridLayout
    if (isLandscape) {
      layout.numberOfColumns = 3
      layout.minimumInteritemSpacing = 10.0
    }
    else {
      layout.numberOfColumns = 2
      layout.minimumInteritemSpacing = 20.0
    }
    layout.sectionInset = UIEdgeInsetsMake(
      20.0,
      layout.minimumInteritemSpacing,
      20.0,
      layout.minimumInteritemSpacing);
    
    layout.invalidateLayout()
  }
  
  func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return clinicalCases.count
  }
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier(kClinicalCaseCellIdentifier, forIndexPath: indexPath) as! iHClinicalCaseCell
    let index = indexPath.item
    let element = clinicalCases[index]
    let attributedText = cell.descriptionTextView.attributedText.mutableCopy() as! NSMutableAttributedString
    attributedText.mutableString.setString(element["description"]!)
    cell.descriptionTextView.attributedText = NSAttributedString(attributedString: attributedText)
    cell.titleLabel.text = String(format: "Clinical Case %d", index + 1)
    cell.titleLabel.font  = UIFont(name: Utils.SCREEN_TITLE_FONT_NAME, size: 23)
    return cell
  }
    
  func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
    let clinicalCasesQuizzDetailViewController = storyBoard.instantiateViewControllerWithIdentifier("ClinicalCasesQuizzDetailViewController") as! ClinicalCasesQuizzDetailViewController
    clinicalCasesQuizzDetailViewController.quizzIdentifier = indexPath.row + 1
    
    self.navigationController!.pushViewController(clinicalCasesQuizzDetailViewController, animated: true)
    self.navigationController!.navigationBar.topItem?.title = "     "
  }
    
  func reloadData() {
        
  }

}
