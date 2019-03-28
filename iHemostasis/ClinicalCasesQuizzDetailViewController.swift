//
//  CoagulationCascadeQuizzDetailViewController.swift
//  iHemostasis
//
//  Created by Zo Rajaonarivony on 28/12/2015.
//  Copyright © 2015 Diagnostica Stago S.A.S. All rights reserved.
//

import Foundation
import UIKit


class ClinicalCasesQuizzDetailViewController: UIViewController, ClinicalCasesQuizzDetailMenuListViewControllerDelegate {
    @IBOutlet weak var titleLabel : UILabel?
    @IBOutlet weak var indexButton : UIButton?
    @IBOutlet weak var descriptionLabel : UILabel?
    @IBOutlet weak var quizzTableView: UITableView?
    @IBOutlet weak var quizzSummaryResponseTableView: UITableView?
    @IBOutlet weak var quizzView: UIView?
    @IBOutlet weak var responseView: UIView?
    @IBOutlet weak var summaryResponseView: UIView?
    @IBOutlet weak var questionMarkView: UIView?
    @IBOutlet weak var currentQuizzSummaryResponseView: UIView?
    @IBOutlet weak var currentQuizzIconStatusResponseImageView: UIImageView?
    @IBOutlet weak var patientHistoryView: UIView?
    @IBOutlet weak var patientHistoryScrollView: UIScrollView?
    @IBOutlet weak var headerView: UIView?
    @IBOutlet weak var footerView: UIView?
    @IBOutlet weak var patientHistoryButtonContainerView: UIView?
    @IBOutlet weak var patientHistoryDetailLabel: UILabel?
    
    @IBOutlet weak var validateButton: UIButton?
    @IBOutlet weak var nextButton: UIButton?
    @IBOutlet weak var userResponseTitleLabel: UILabel?
    @IBOutlet weak var userResponseLabel: UILabel?
    @IBOutlet weak var correctResponseLabel: UILabel?
    @IBOutlet weak var explanationWebView: UIWebView?
    @IBOutlet weak var percentResponseLabel: UILabel?
    @IBOutlet weak var percentResponseView: UIView?
    @IBOutlet weak var resultLabel: UILabel?
    
    var quizzIdentifier = 0
    let textCellIdentifier = "textCellIdentifier"
    var quizzDataArray = [ClinicalCasesModel()]
    var currentQuizzIndex = 0
    var currentQuizzData = ClinicalCasesModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.quizzTableView?.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        loadJsonData(quizzIdentifier)
        indexButton?.setTitle("Clinical Case " + String(quizzIdentifier), forState: UIControlState.Normal)
        
        setupUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let clinicalCasesQuizzDetailMenuListViewController = segue.destinationViewController as! ClinicalCasesQuizzDetailMenuListViewController
        clinicalCasesQuizzDetailMenuListViewController.preferredContentSize = CGSizeMake(400.0, 700.0)
        clinicalCasesQuizzDetailMenuListViewController.delegate = self
    }
    
    func setupUI() {
        loadUI()
        responseView?.hidden = true
        summaryResponseView?.hidden = true
        nextButton?.hidden = true
        self.titleLabel!.font  = UIFont(name: Utils.SCREEN_TITLE_FONT_NAME, size: 24.0)
        resultLabel?.hidden = true
        percentResponseView?.hidden = true
        
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
    
    
    func loadUI() {
        let orient = UIApplication.sharedApplication().statusBarOrientation
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        switch orient {
        case .Portrait:
            self.patientHistoryView?.hidden = true
            self.patientHistoryButtonContainerView?.hidden = false
            self.patientHistoryView?.frame = CGRectMake(0, 238, (self.patientHistoryView?.frame.width)!, (self.patientHistoryView?.frame.height)!)
            self.quizzView?.frame = CGRectMake(0, 238, 768, 686)
            self.responseView?.frame = CGRectMake(0, 238, 768, 686)
            self.summaryResponseView?.frame = CGRectMake(0, 238, 768, 686)
            self.questionMarkView?.frame.origin = CGPoint(x: 117, y: 0)
            self.headerView?.frame = CGRectMake(0, 110, 768, 128)
            self.footerView?.frame = CGRectMake(0, 924, 768, 100)
            self.titleLabel?.frame.origin = CGPointMake(247, 8)
            self.resultLabel?.frame.origin = CGPointMake(140, 8)
            self.titleLabel?.frame.size = CGSizeMake(470, 89)
            self.quizzSummaryResponseTableView?.frame.size = CGSizeMake((self.summaryResponseView?.frame.width)!, (self.summaryResponseView?.frame.height)!)
        default:
            self.patientHistoryButtonContainerView?.hidden = true
            self.questionMarkView?.frame.origin = CGPoint(x: 0, y: 0)
            self.patientHistoryView?.hidden = false
            self.patientHistoryView?.frame = CGRectMake(0, 109, (self.patientHistoryView?.frame.width)!, 659)
            self.quizzView?.frame = CGRectMake((self.patientHistoryView?.frame.width)!, 238, screenSize.width - (self.patientHistoryView?.frame.width)!, (self.quizzView?.frame.height)!)
            self.responseView?.frame = CGRectMake((self.patientHistoryView?.frame.width)!, 238, screenSize.width - (self.patientHistoryView?.frame.width)!, (self.responseView?.frame.height)!)
            self.summaryResponseView?.frame = CGRectMake((self.patientHistoryView?.frame.width)!, 238, screenSize.width - (self.patientHistoryView?.frame.width)!, (self.summaryResponseView?.frame.height)!)
            self.headerView?.frame = CGRectMake(331, 110, 693, 128)
            self.footerView?.frame = CGRectMake(331, 668, 693, 100)
            self.titleLabel?.frame.origin = CGPointMake(140, 8)
            self.titleLabel?.frame.size = CGSizeMake(470, 89)
            self.resultLabel?.frame.origin = CGPointMake(40, 8)
            self.quizzSummaryResponseTableView?.frame.size = CGSizeMake((self.summaryResponseView?.frame.width)!, (self.summaryResponseView?.frame.height)! - 100)
        }
    }
    
    
    func loadJsonData(quizzId: Int) {
        //quizzIdentifier = quizzId
        let jsonFileName = "Quizz_" + String(quizzId)
        quizzDataArray.removeAll()
        
        if let path = NSBundle.mainBundle().pathForResource(jsonFileName, ofType: "json") {
            do {
                let fileData = try NSData(contentsOfFile: path, options: .DataReadingMappedIfSafe)
                
                do {
                    if let jsonResult = try NSJSONSerialization.JSONObjectWithData(fileData, options: []) as? NSDictionary {
                        let jsonArray = jsonResult["q&r"] as? NSArray
                        for var i = 0; i < jsonArray!.count; i++ {
                            let node: NSDictionary = (jsonArray?.objectAtIndex(i))! as! NSDictionary
                            let quizzData = ClinicalCasesModel()
                            
                            // Questions
                            quizzData.title = node["question"] as? String
                            quizzData.explanation = node["explanation"] as? String
                            quizzData.statement = node["statement"] as? String
                            
                            // Responses
                            let responses: NSArray = node["responses"] as! NSArray
                            for var j = 0; j < responses.count; j++ {
                                let dict:NSDictionary = responses.objectAtIndex(j) as! NSDictionary
                                
                                let quizzResponseData = ClinicalCasesResponseModel()
                                quizzResponseData.response = dict["reponse"] as? String
                                quizzResponseData.correctness = (dict["correct"] as? Bool)!
                                quizzResponseData.userResponse = false
                                quizzData.responses.append(quizzResponseData)
                            }
                            
                            quizzDataArray.insert(quizzData, atIndex: i)
                        }
                    }
                    currentQuizzIndex = 0
                    reloadData(0)
                    
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            }
            catch {
                print("Error parsing JSON Quizz File")
            }
        }
    }
    
    func reloadData(index: Int) {
        let quizzData = quizzDataArray[currentQuizzIndex]
        titleLabel?.text = quizzData.title
        quizzTableView?.reloadData()
        
        var patientHistoryText = ""
        for var i: Int = 0; i <= index; i++ {
            patientHistoryText += quizzDataArray[i].statement! + "\n"
        }
        
        patientHistoryDetailLabel?.text = patientHistoryText
        patientHistoryDetailLabel?.sizeToFit()
        patientHistoryScrollView?.contentSize = CGSize(width: 0, height: (patientHistoryDetailLabel?.frame.height)! + 20.0)
    }
    
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animateAlongsideTransition({ (UIViewControllerTransitionCoordinatorContext) -> Void in
            self.loadUI()
            }, completion: { (UIViewControllerTransitionCoordinatorContext) -> Void in
                //print("rotation completed")
        })
        
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
    }
    
    
    // TableView
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == quizzTableView && quizzView!.hidden == false { // && quizzView!.hidden == false ==> this test avoid crash when orentation changed
            currentQuizzData = quizzDataArray[currentQuizzIndex]
            return currentQuizzData.responses.count
        }
        if tableView == quizzSummaryResponseTableView {
            return quizzDataArray.count
        }
        
        return 0
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if tableView == quizzTableView {
            let cell = tableView.dequeueReusableCellWithIdentifier(textCellIdentifier, forIndexPath: indexPath) as! ClinicalCasesQuizzViewCell
            let row = indexPath.row
            currentQuizzData = quizzDataArray[currentQuizzIndex]
            let currentQuizzResponseData = currentQuizzData.responses[row]
            cell.reloadData(currentQuizzResponseData)
            return cell
        }
        
        if tableView == quizzSummaryResponseTableView {
            let cell = tableView.dequeueReusableCellWithIdentifier(textCellIdentifier, forIndexPath: indexPath) as! ClinicalCasesQuizzResponseSummaryViewCell
            let quizz:ClinicalCasesModel = quizzDataArray[indexPath.row]
            cell.reloadData(quizz)
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if tableView == quizzTableView {
            let cell = tableView.dequeueReusableCellWithIdentifier(textCellIdentifier, forIndexPath: indexPath) as! ClinicalCasesQuizzViewCell
            
            let row = indexPath.row
            let currentQuizzDataSelected = quizzDataArray[currentQuizzIndex]
            let currentQuizzResponseData = currentQuizzDataSelected.responses[row]
            currentQuizzResponseData.userResponse = !currentQuizzResponseData.userResponse
            
            cell.reloadData(currentQuizzResponseData)
            self.quizzTableView?.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.None)
        }
    }
    
    func onItemSelection(index: Int) {
        /*
        currentQuizzIndex = index
        reloadData(currentQuizzIndex)
        */
        
        let alert = UIAlertController(title: "The quiz is in progress", message: "Do you really want to select new case?", preferredStyle: UIAlertControllerStyle.Alert)
        self.presentViewController(alert, animated: true, completion: nil)
        
        alert.addAction(UIAlertAction(title: "No", style: .Default, handler: nil))
        alert.addAction(UIAlertAction(title: "Yes", style: .Default, handler: { action in
            switch action.style{
            case .Default:
                self.currentQuizzIndex = 0
                self.loadJsonData(index + 1)
                self.indexButton?.setTitle("Clinical Case " + String(index + 1), forState: UIControlState.Normal)
                self.reloadData(index)
            case .Cancel:
                print("YES cancel")
                
            case .Destructive:
                print("Ys destructive")
            }
        }))
    }
    
    
    // Private Func
    func analyseAndShowCurrentQuizzResult() {
        var userCorrectPoint: Int = 0
        var userIncorrectPoint: Int = 0
        var quizzTotalCorrectPoint: Int = 0
        
        
        var userResponseResume: String? = ""
        var correctResponseResume: String? = ""
        
        
        // Zo 28/04/16 #1091 Special Case Answer "Case 4, Quizz 2" - All of the above tests
        // I just hope there is no more special case like this,
        if quizzIdentifier == 4 && currentQuizzIndex == 1 {
            if (currentQuizzData.responses[3].userResponse == true) { // All of the above tests
                for i in 0 ... 3 {
                    if currentQuizzData.responses[i].userResponse == true {
                        userResponseResume =  userResponseResume! + (currentQuizzData.responses[i].response)! + " / "
                    }
                    
                    correctResponseResume = correctResponseResume! + (currentQuizzData.responses[i].response)! + " / "
                    currentQuizzData.responses[i].userResponse = true
                }
                quizzTotalCorrectPoint = 4
                userCorrectPoint = 4
            }
            else {
                for quizz in currentQuizzData.responses {
                    if quizz.userResponse == true {
                        userResponseResume =  userResponseResume! + (quizz.response)! + " / "
                    }
                    if quizz.correctness == true {
                        correctResponseResume = correctResponseResume! + (quizz.response)! + " / "
                        quizzTotalCorrectPoint = quizzTotalCorrectPoint + 1
                    }
                    
                    // Check now if user answers are correct
                    if quizz.userResponse == quizz.correctness && quizz.correctness == true {
                        userCorrectPoint = userCorrectPoint + 1
                    }
                    
                    // Check now if user answers are incorrect
                    if quizz.userResponse == true && quizz.correctness == false {
                        userIncorrectPoint = userIncorrectPoint + 1
                    }
                }
                if (userCorrectPoint == 3) {
                    userCorrectPoint = 4
                    currentQuizzData.responses[3].userResponse = true // Check the last answer as true
                }
            }
        }
        // Manage the quizz in general without special case here
        else {
            for quizz in currentQuizzData.responses {
                if quizz.userResponse == true {
                    userResponseResume =  userResponseResume! + (quizz.response)! + " / "
                }
                if quizz.correctness == true {
                    correctResponseResume = correctResponseResume! + (quizz.response)! + " / "
                    quizzTotalCorrectPoint = quizzTotalCorrectPoint + 1
                }
                
                // Check now if user answers are correct
                if quizz.userResponse == quizz.correctness && quizz.correctness == true {
                    userCorrectPoint = userCorrectPoint + 1
                }
                
                // Check now if user answers are incorrect
                if quizz.userResponse == true && quizz.correctness == false {
                    userIncorrectPoint = userIncorrectPoint + 1
                }
            }
        }
        
        
        if userResponseResume != "" {
            userResponseResume = userResponseResume!.substringWithRange(Range<String.Index>(start: userResponseResume!.startIndex, end:userResponseResume!.endIndex.advancedBy(-2)))
            correctResponseResume = correctResponseResume!.substringWithRange(Range<String.Index>(start: correctResponseResume!.startIndex, end:correctResponseResume!.endIndex.advancedBy(-2)))
            userResponseLabel?.text = userResponseResume
            correctResponseLabel?.text = correctResponseResume
            
            explanationWebView?.loadHTMLString(currentQuizzData.explanation!, baseURL: nil)
            
            quizzView?.hidden = true
            responseView?.hidden = false
            validateButton?.hidden = true
            nextButton?.hidden = false
            
            
            // Let's colour our view answer
            if (userCorrectPoint == quizzTotalCorrectPoint && userIncorrectPoint == 0) {
                currentQuizzSummaryResponseView?.backgroundColor = Utils.colorWithHexString("#70BD16") // Green
                currentQuizzIconStatusResponseImageView?.highlighted = true
                self.userResponseLabel?.textColor = UIColor.whiteColor()
                self.userResponseTitleLabel?.textColor = UIColor.whiteColor()
            }
            else {
                if (userCorrectPoint > 0 && userIncorrectPoint == 0) {
                    currentQuizzSummaryResponseView?.backgroundColor = Utils.colorWithHexString("#EFEFF4") // Grey
                    currentQuizzIconStatusResponseImageView?.highlighted = true
                    self.userResponseLabel?.textColor = UIColor.blackColor()
                    self.userResponseTitleLabel?.textColor = UIColor.blackColor()
                }
                else if (userCorrectPoint > 0 && userIncorrectPoint >= 0) {
                    currentQuizzSummaryResponseView?.backgroundColor = Utils.colorWithHexString("#EFEFF4") // Grey
                    currentQuizzIconStatusResponseImageView?.highlighted = false
                    self.userResponseLabel?.textColor = UIColor.blackColor()
                    self.userResponseTitleLabel?.textColor = UIColor.blackColor()
                }
                    
                else if (userCorrectPoint == 0) {
                    currentQuizzSummaryResponseView?.backgroundColor = Utils.colorWithHexString("#BD2716") // Red
                    currentQuizzIconStatusResponseImageView?.highlighted = false
                    self.userResponseLabel?.textColor = UIColor.whiteColor()
                    self.userResponseTitleLabel?.textColor = UIColor.whiteColor()
                }
            }
        }

    }
    
    func showNextQuizz() {
        quizzView?.hidden = false
        responseView?.hidden = true
        validateButton?.hidden = false
        nextButton?.hidden = true
        reloadData(currentQuizzIndex)
    }
    
    func showSummaryResponse() {
        var totalPercentInPoint: Float = 0.0
        var percentInPoint: Float = 0.0
        quizzView?.hidden = true
        responseView?.hidden = true
        validateButton?.hidden = true
        nextButton?.hidden = true
        summaryResponseView?.hidden = false
        questionMarkView?.hidden = true
        resultLabel?.hidden = false
        titleLabel?.hidden = true
        quizzSummaryResponseTableView?.reloadData()
        
        
        for quizz in quizzDataArray {
            var userCorrectPoint: Int = 0
            var userIncorrectPoint: Int = 0
            var quizzTotalCorrectPoint: Int = 0
            var currentPercentInPoint: Float = 0.0
            
            // Calculate Quizz Answer
            for quizzResponses in quizz.responses {
                // Total Correct Response For The Quizz
                if quizzResponses.correctness == true {
                    quizzTotalCorrectPoint = quizzTotalCorrectPoint + 1
                }
                
                // Check now if user answers are correct
                if quizzResponses.userResponse == quizzResponses.correctness && quizzResponses.correctness == true {
                    userCorrectPoint = userCorrectPoint + 1
                }
                
                // Check now if user answers are incorrect
                if quizzResponses.userResponse == true && quizzResponses.correctness == false {
                    userIncorrectPoint = userIncorrectPoint + 1
                }
            }
            
            // One good answer
            if quizzTotalCorrectPoint == 1 {
                if userCorrectPoint == 0 && userIncorrectPoint >= 0 {
                    currentPercentInPoint = 0.0
                }
                else if userCorrectPoint == 1 && userIncorrectPoint == 0 {
                    currentPercentInPoint = 100.0
                }
                else if userCorrectPoint == 1 && userIncorrectPoint > 0 {
                    currentPercentInPoint = 0.0
                }
            }
            
            // Two good answers
            if quizzTotalCorrectPoint == 2 {
                if userCorrectPoint == 0 && userIncorrectPoint >= 0 {
                    currentPercentInPoint = 0.0
                }
                else if userCorrectPoint == 1 && userIncorrectPoint == 0 {
                    currentPercentInPoint = 66.0
                }
                else if userCorrectPoint == 1 && userIncorrectPoint == 1 {
                    currentPercentInPoint = 33.0
                }
                else if userCorrectPoint == 1 && userIncorrectPoint > 1 {
                    currentPercentInPoint = 0.0
                }
                else if userCorrectPoint == 2 && userIncorrectPoint == 0 {
                    currentPercentInPoint = 100.0
                }
                else if userCorrectPoint == 2 && userIncorrectPoint == 1 {
                    currentPercentInPoint = 0.0
                }
                else if userCorrectPoint == 2 && userIncorrectPoint > 1 {
                    currentPercentInPoint = 0.0
                }
            }
            // Three good answers
            if quizzTotalCorrectPoint == 3 {
                if userCorrectPoint == 0 && userIncorrectPoint >= 0 {
                    currentPercentInPoint = 0.0
                }
                else if userCorrectPoint == 1 && userIncorrectPoint == 0 {
                    currentPercentInPoint = 50.0
                }
                else if userCorrectPoint == 1 && userIncorrectPoint == 1 {
                    currentPercentInPoint = 30.0
                }
                else if userCorrectPoint == 1 && userIncorrectPoint == 2 {
                    currentPercentInPoint = 10.0
                }
                else if userCorrectPoint == 1 && userIncorrectPoint > 2 {
                    currentPercentInPoint = 0.0
                }
                else if userCorrectPoint == 2 && userIncorrectPoint == 0 {
                    currentPercentInPoint = 75.0
                }
                else if userCorrectPoint == 2 && userIncorrectPoint == 1 {
                    currentPercentInPoint = 50.0
                }
                else if userCorrectPoint == 2 && userIncorrectPoint > 1 {
                    currentPercentInPoint = 0.0
                }
                else if userCorrectPoint == 3 && userIncorrectPoint == 0 {
                    currentPercentInPoint = 100.0
                }
                else if userCorrectPoint == 3 && userIncorrectPoint > 0 {
                    currentPercentInPoint = 0.0
                }
            }
            if quizzTotalCorrectPoint == 4 {
                // TODO
                if userCorrectPoint == 4 && userIncorrectPoint == 0 {
                    currentPercentInPoint = 100.0
                }
                else if userCorrectPoint == 3 && userIncorrectPoint == 0 {
                    currentPercentInPoint = 75.0
                }
                else if userCorrectPoint == 2 && userIncorrectPoint == 0 {
                    currentPercentInPoint = 50.0
                }
                else if userCorrectPoint == 1 && userIncorrectPoint == 0 {
                    currentPercentInPoint = 25.0
                }
                    
                else if userCorrectPoint == 2 && userIncorrectPoint == 1 {
                    currentPercentInPoint = 30.0
                }
                else if userCorrectPoint == 1 && userIncorrectPoint == 1 {
                    currentPercentInPoint = 10.0
                }
                else if userCorrectPoint == 2 && userIncorrectPoint == 2 {
                    currentPercentInPoint = 20.0
                }
                else if userCorrectPoint == 1 && userIncorrectPoint == 2 {
                    currentPercentInPoint = 5.0
                }
                else if userCorrectPoint == 1 && userIncorrectPoint == 3 {
                    currentPercentInPoint = 10.0
                }
                else {
                    currentPercentInPoint = 0.0
                }
            }
            percentInPoint = percentInPoint + currentPercentInPoint
        }
    
        totalPercentInPoint = percentInPoint / Float(quizzDataArray.count)
    
        // Calculate Percent Response
        percentResponseView?.hidden = false
    
        if totalPercentInPoint <= 30.0 {
            percentResponseLabel?.text = "< 30%"
        }
        else {
            percentResponseLabel?.text = String(totalPercentInPoint) + "%"
        }
    }
    
    // IBAction
    @IBAction func validateButtonAction(sender: UIButton) {
        analyseAndShowCurrentQuizzResult()
    }
    
    @IBAction func nextButtonAction(sender: UIButton) {
        currentQuizzIndex = currentQuizzIndex + 1
        if currentQuizzIndex < quizzDataArray.count {
            showNextQuizz()
        }
        else {
            showSummaryResponse()
        }
    }
    
    @IBAction func patientHistoryButtonAction(sender: UIButton) {
        let orient = UIApplication.sharedApplication().statusBarOrientation
        if orient == .Portrait {
            if patientHistoryView?.hidden == true {
                patientHistoryView?.hidden = false
            }
            else {
                patientHistoryView?.hidden = true
            }
        }
    }
    
    func backButtonAction() {
        if currentQuizzIndex < quizzDataArray.count  {
            let alert = UIAlertController(title: "The quiz is in progress", message: "Do you really want to select new case?", preferredStyle: UIAlertControllerStyle.Alert)
            //alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.Default, handler: nil))
            //alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            
            alert.addAction(UIAlertAction(title: "No", style: .Default, handler: nil))
            alert.addAction(UIAlertAction(title: "Yes", style: .Default, handler: { action in
                switch action.style{
                case .Default:
                    self.navigationController?.popViewControllerAnimated(true)
                    
                case .Cancel:
                    print("YES cancel")
                    
                case .Destructive:
                    print("Ys destructive")
                }
            }))
        }
        else {
            self.navigationController?.popViewControllerAnimated(true)
        }
    }
    
}
