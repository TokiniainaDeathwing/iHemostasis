//
//  ClinicalCasesListViewController.swift
//  iHemostasis
//
//  Created by Zo Rajaonarivony on 09/12/2015.
//  Copyright © 2015 Diagnostica Stago S.A.S. All rights reserved.
//

import UIKit

class ClinicalCasesListViewController: ParentViewController, UICollectionViewDelegate, UICollectionViewDataSource {
  @IBOutlet var cells : Array <UIView>?
  private let kClinicalCaseCellIdentifier = "kClinicalCaseCellIdentifier"
  private let clinicalCases = [
    ["description":"Three-year old Julien us referred to laboratory for screening for a bleeding disorder. His parents brought him to visit the general practitioner because of his frequent and prolonged nosebleeds and bruising..."],
    ["description":"Mrs T., 35, is hospitalized after miscarriage at 15 weeks of gestation. She previously experiences two other miscarriages at 12 and 18 weeks of gestation..."],
    ["description":"Mr B, 75, is undergoing long term warfarin therapy at the prescribed dose of 5 mg/ day for atrial fibrillation. His treatment is stabilized and last zeek, his PT/INR ordered by the physician was measured at 2.2. He presented with oral thrush and started a local antifungal treatment (floconazole) 48 hoours ago..."],
    ["description":"A 31 year old male, with no specific medical history, flew 18 hours to go to his vacation resort. The day after his arrival, he felt an intense and hard pain in his chest with a significant dyspnea. He was immediately admitted to the Emergency Department..."],
    ["description":"Mr B, a 34 year-old man, presents with acute abdominal pain. The complete Blood Count results are consistent with appendicitis. According to the clinical outcome the physician diagnoses peritonitis..."],
    ["description":"Mrs G., 91 years old, is hospitalized for pulmonary embolism. She does not have severe renal insufficiency. She receives curative treatment by tinzaparin (Innohep, a low molecular weight heparin) 175 IU/kg OD..."],
    ["description":"Paul, 14-month old, is referred to physician for recent bruising. They are localised to knee, ankle and elbow following repeated falls linked to his first steps.The physician requests a haemostasis work-up."],
    ["description":"Mrs. T. 60-years old suffers from multiple myeloma diagnosed 3 years ago.\nSince 1 month, she is experiencing repeated mucocutaneous bleeding (epistaxis). She indicates that she is not under anticoagulant treatment. A coagulation workup is requested."],
    ["description":"Blood samples have been collected from Mr. S., 35-year old, at the Health Centre for a haemostasis preoperative workup and a total blood count. Samples were prepared for shipping to the reference lab. Mr. S. reports a bleeding tendency in his maternal grandmother."],
    ["description":"Mrs. S. 70-years old, is referred to the laboratory for a preoperative work-up for a total knee replacement. She describes a bleeding episode in her family that occurred during a tooth extraction. She confirms that she is not on anticoagulant treatment."],
    ["description":"Mrs W., 83-year old, is admitted to the emergency room after a road accident around 9:00 am.A femoral condyle fracture is diagnosed and urgent surgery is decided.\n\nA blood sample is drawn around 10:30 am to perform a presurgery workup."],
    ["description":"Mr. M., 67-year old, is dispatched to the hospital emergency room for acute abdominal pain. Acute appendicitis is suspected. A pre-surgery workup is prescribed."]
  ]
  
  @IBOutlet var collectionView : UICollectionView!
  
  override func viewDidLoad() {
    super.viewDidLoad();
    
    let layout = collectionView.collectionViewLayout as! iHGridLayout
    layout.itemHeight = 280.0
    
    self.setScreenTitle(title: "Clinical Cases")
    
    let backbuttonImage: UIImage? = UIImage(named: "Back-ArrowWHITE")
    let backButton:UIButton = UIButton(type: UIButton.ButtonType.custom) as UIButton
    backButton.frame = CGRect(0, 0, 32, 32)
    backButton.addTarget(self, action: #selector(backButtonAction), for: UIControl.Event.touchUpInside)
    backButton.setTitle("", for: UIControl.State.normal)
    backButton.setTitleColor(UIColor.blue, for: UIControl.State.normal)
    let myCustomBackButtonItem:UIBarButtonItem = UIBarButtonItem(customView: backButton)
    self.navigationItem.leftBarButtonItem  = myCustomBackButtonItem
    backButton.setBackgroundImage(backbuttonImage, for: .normal)
    
  }
  
    override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
        reloadUI(size: self.view.frame.size)
  }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let quizzDetailViewController = segue.destination as! ClinicalCasesQuizzDetailViewController
    quizzDetailViewController.quizzIdentifier = Int(segue.identifier!)!
  }
  
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
    reloadUI(size: size)
  }
  
  func reloadUI(size: CGSize) {
    var isLandscape = false
    
    let orient = UIApplication.shared.statusBarOrientation
    
    switch orient {
    case .portrait:
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
        if(UIDevice.current.userInterfaceIdiom == .phone){
            layout.numberOfColumns = 1
        }else{
            layout.numberOfColumns = 2
        }
     
      layout.minimumInteritemSpacing = 20.0
    }
    layout.sectionInset = UIEdgeInsets(
        top: 20.0,
        left: layout.minimumInteritemSpacing,
        bottom: 20.0,
        right: layout.minimumInteritemSpacing);
    
    layout.invalidateLayout()
  }
  
  func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return 1
  }
  
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return clinicalCases.count
  }
  
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kClinicalCaseCellIdentifier, for: indexPath as IndexPath) as! iHClinicalCaseCell
    let index = indexPath.item
    let element = clinicalCases[index]
    let attributedText = cell.descriptionTextView.attributedText.mutableCopy() as! NSMutableAttributedString
    attributedText.mutableString.setString(element["description"]!)
    cell.descriptionTextView.attributedText = NSAttributedString(attributedString: attributedText)
    cell.descriptionTextView.textColor = UIColor.white
        cell.descriptionTextView.font = UIFont(name: (cell.descriptionTextView.font?.fontName)!, size: 17)
    cell.titleLabel.text = String(format: "Clinical Case %d", index + 1)
    cell.titleLabel.font  = UIFont(name: Utils.SCREEN_TITLE_FONT_NAME, size: 23)
    return cell
  }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
    let clinicalCasesQuizzDetailViewController = storyBoard.instantiateViewController(withIdentifier: "ClinicalCasesQuizzDetailViewController") as! ClinicalCasesQuizzDetailViewController
    clinicalCasesQuizzDetailViewController.quizzIdentifier = indexPath.row + 1
    
    self.navigationController!.pushViewController(clinicalCasesQuizzDetailViewController, animated: true)
    self.navigationController!.navigationBar.topItem?.title = "     "
  }
    
  func reloadData() {
        
  }

}
