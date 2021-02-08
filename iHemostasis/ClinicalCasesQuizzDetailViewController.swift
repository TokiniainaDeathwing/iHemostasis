//
//  CoagulationCascadeQuizzDetailViewController.swift
//  iHemostasis
//
//  Created by Zo Rajaonarivony on 28/12/2015.
//  Copyright © 2015 Diagnostica Stago S.A.S. All rights reserved.
//

import Foundation
import UIKit


class ClinicalCasesQuizzDetailViewController: UIViewController, ClinicalCasesQuizzDetailMenuListViewControllerDelegate,UITableViewDataSource, UITableViewDelegate {
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
        
        self.quizzTableView?.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        loadJsonData(quizzId: quizzIdentifier)
       
        indexButton?.setTitle("Clinical Case " + String(quizzIdentifier), for: UIControl.State.normal)
        
        setupUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let clinicalCasesQuizzDetailMenuListViewController = segue.destination as! ClinicalCasesQuizzDetailMenuListViewController
        clinicalCasesQuizzDetailMenuListViewController.preferredContentSize = CGSize(400.0, 700.0)
        clinicalCasesQuizzDetailMenuListViewController.delegate = self
    }
    
    func setupUI() {
        loadUI()
        responseView?.isHidden = true
        summaryResponseView?.isHidden = true
        nextButton?.isHidden = true
        if(UIDevice.current.userInterfaceIdiom == .pad){
        self.titleLabel!.font  = UIFont(name: Utils.SCREEN_TITLE_FONT_NAME, size: 24.0)
        }

        resultLabel?.isHidden = true
        percentResponseView?.isHidden = true
        
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
    
    
    func loadUI() {
        self.patientHistoryView?.isHidden = true
        if(UIDevice.current.userInterfaceIdiom == .pad){
            let orient = UIApplication.shared.statusBarOrientation
            let screenSize: CGRect = UIScreen.main.bounds
            switch orient {
            case .portrait:
                let height : CGFloat = (self.patientHistoryView?.frame.height)! - 228
                self.patientHistoryView?.isHidden = true
                self.patientHistoryButtonContainerView?.isHidden = false
                self.patientHistoryView?.frame = CGRect(0, 238, (self.patientHistoryView?.frame.width)!, (self.patientHistoryView?.frame.height)!)
                self.quizzView?.frame = CGRect(0, 238, screenSize.width, height)
                self.responseView?.frame = CGRect(0, 238, screenSize.width, height)
                self.summaryResponseView?.frame = CGRect(0, 238, screenSize.width, height)
                self.questionMarkView?.frame.origin = CGPoint(x: 117, y: 0)
                self.headerView?.frame = CGRect(0, 110, screenSize.width, 128)
                self.footerView?.frame = CGRect(0, (self.footerView?.frame.origin.y)!, screenSize.width, 100)
                self.titleLabel?.frame.origin = CGPoint(247, 8)
                self.resultLabel?.frame.origin = CGPoint(140, 8)
                self.titleLabel?.frame.size = CGSize(470, 89)
                self.quizzSummaryResponseTableView?.frame.size = CGSize((self.summaryResponseView?.frame.width)!, (self.summaryResponseView?.frame.height)!)
            default:
                self.patientHistoryButtonContainerView?.isHidden = true
                self.questionMarkView?.frame.origin = CGPoint(x: 0, y: 0)
                self.patientHistoryView?.isHidden = false
                self.patientHistoryView?.frame = CGRect(0, 109, (self.patientHistoryView?.frame.width)!, screenSize.height - 109)
                let height : CGFloat = (self.patientHistoryView?.frame.height)! - 228
                self.quizzView?.frame = CGRect((self.patientHistoryView?.frame.width)!, 238, screenSize.width - (self.patientHistoryView?.frame.width)!, height)
                self.responseView?.frame = CGRect((self.patientHistoryView?.frame.width)!, 238, screenSize.width - (self.patientHistoryView?.frame.width)!, height)
                self.summaryResponseView?.frame = CGRect((self.patientHistoryView?.frame.width)!, 238, screenSize.width - (self.patientHistoryView?.frame.width)!, height)
                self.headerView?.frame = CGRect(331, 110, screenSize.width - (self.patientHistoryView?.frame.width)!, 128)
                self.footerView?.frame = CGRect(331, (self.footerView?.frame.origin.y)!, screenSize.width - (self.patientHistoryView?.frame.width)!, 100)
                self.titleLabel?.frame.origin = CGPoint(140, 8)
                self.titleLabel?.frame.size = CGSize(470, 89)
                self.resultLabel?.frame.origin = CGPoint(40, 8)
                self.quizzSummaryResponseTableView?.frame.size = CGSize((self.summaryResponseView?.frame.width)!, (self.summaryResponseView?.frame.height)! - 100)
            }
        }
     
       
    }
    
    
    func loadJsonData(quizzId: Int) {
        //quizzIdentifier = quizzId
        let jsonFileName = "Quizz_" + String(quizzId)
        quizzDataArray.removeAll()
        
        if let path = Bundle.main.path(forResource: jsonFileName, ofType: "json") {
            do {
                let fileData = try NSData(contentsOfFile: path, options: .mappedIfSafe)
                
                do {
                    if let jsonResult = try JSONSerialization.jsonObject(with: fileData as Data, options: []) as? NSDictionary {
                        let jsonArray = jsonResult["q&r"] as? NSArray
                        for i in 0..<jsonArray!.count {
                            let node: NSDictionary = (jsonArray?.object(at: i))! as! NSDictionary
                            let quizzData = ClinicalCasesModel()
                            
                            // Questions
                            quizzData.title = node["question"] as? String
                            quizzData.explanation = node["explanation"] as? String
                            quizzData.statement = node["statement"] as? String
                            
                            // Responses
                            let responses: NSArray = node["responses"] as! NSArray
                            for j in 0..<responses.count {
                                let dict:NSDictionary = responses.object(at: j) as! NSDictionary
                                
                                let quizzResponseData = ClinicalCasesResponseModel()
                                quizzResponseData.response = dict["reponse"] as? String
                                quizzResponseData.correctness = (dict["correct"] as? Bool)!
                                quizzResponseData.userResponse = false
                                quizzData.responses.append(quizzResponseData)
                            }
                            
                            quizzDataArray.insert(quizzData, at: i)
                        }
                    }
                    currentQuizzIndex = 0
                    reloadData(index: 0)
                    
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
        print("currentQuizzIndex: " + String(currentQuizzIndex))
        let quizzData = quizzDataArray[currentQuizzIndex]
        titleLabel?.text = quizzData.title
        quizzTableView?.reloadData()
        
        var patientHistoryText = ""
        for i in 0..<quizzDataArray.count {
            patientHistoryText += quizzDataArray[i].statement! + "\n"
        }
        
        patientHistoryDetailLabel?.text = patientHistoryText
        patientHistoryDetailLabel?.sizeToFit()
        patientHistoryScrollView?.contentSize = CGSize(width: 0, height: (patientHistoryDetailLabel?.frame.height)! + 20.0)
    }
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) -> Void in
            self.loadUI()
            }, completion: { (UIViewControllerTransitionCoordinatorContext) -> Void in
                //print("rotation completed")
        })
        
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    
    // TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == quizzTableView && quizzView!.isHidden == false { // && quizzView!.hidden == false ==> this test avoid crash when orentation changed
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == quizzTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: textCellIdentifier, for: indexPath as IndexPath) as! ClinicalCasesQuizzViewCell
            let row = indexPath.row
            currentQuizzData = quizzDataArray[currentQuizzIndex]
            let currentQuizzResponseData = currentQuizzData.responses[row]
            cell.reloadData(data: currentQuizzResponseData)
            return cell
        }
        
        if tableView == quizzSummaryResponseTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: textCellIdentifier, for: indexPath as IndexPath) as! ClinicalCasesQuizzResponseSummaryViewCell
            let quizz:ClinicalCasesModel = quizzDataArray[indexPath.row]
            cell.reloadData(data: quizz)
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == quizzTableView {
            let cell = tableView.cellForRow(at: indexPath) as! ClinicalCasesQuizzViewCell
            
            let row = indexPath.row
            let currentQuizzDataSelected = quizzDataArray[currentQuizzIndex]
            let currentQuizzResponseData = currentQuizzDataSelected.responses[row]
            currentQuizzResponseData.userResponse = !currentQuizzResponseData.userResponse
            
            cell.reloadData(data: currentQuizzResponseData)
            self.quizzTableView?.reloadRows(at: [indexPath], with: UITableView.RowAnimation.none)
        }
    }
    
    func onItemSelection(index: Int) {
        /*
        currentQuizzIndex = index
        reloadData(currentQuizzIndex)
        */
        
        let alert = UIAlertController(title: "The quiz is in progress", message: "Do you really want to select new case?", preferredStyle: UIAlertController.Style.alert)
        self.present(alert, animated: true, completion: nil)
        
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
            switch action.style{
            case .default:
                self.currentQuizzIndex = 0
                self.loadJsonData(quizzId: index + 1)
                self.indexButton?.setTitle("Clinical Case " + String(index + 1), for: UIControl.State.normal)
                self.reloadData(index: index)
            case .cancel:
                print("YES cancel")
                
            case .destructive:
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
            var strIdx = userResponseResume?.index(userResponseResume!.startIndex, offsetBy: 0)
            var endIdx = userResponseResume?.index(userResponseResume!.endIndex, offsetBy: -2)
            userResponseResume = String(((userResponseResume?[strIdx!..<endIdx!] ?? nil) ?? nil)!)
            strIdx = correctResponseResume?.index(correctResponseResume!.startIndex, offsetBy: 0)
            endIdx = correctResponseResume?.index(correctResponseResume!.endIndex, offsetBy: -2)
            correctResponseResume = String(((correctResponseResume?[strIdx!..<endIdx!] ?? nil) ?? nil)!)
            userResponseLabel?.text = userResponseResume
            correctResponseLabel?.text = correctResponseResume
            
            explanationWebView?.loadHTMLString(currentQuizzData.explanation!, baseURL: nil)
            
            quizzView?.isHidden = true
            responseView?.isHidden = false
            validateButton?.isHidden = true
            nextButton?.isHidden = false
            
            
            // Let's colour our view answer
            if (userCorrectPoint == quizzTotalCorrectPoint && userIncorrectPoint == 0) {
                currentQuizzSummaryResponseView?.backgroundColor = Utils.colorWithHexString(hex: "#70BD16") // Green
                currentQuizzIconStatusResponseImageView?.isHighlighted = true
                self.userResponseLabel?.textColor = UIColor.white
                self.userResponseTitleLabel?.textColor = UIColor.white
            }
            else {
                if (userCorrectPoint > 0 && userIncorrectPoint == 0) {
                    currentQuizzSummaryResponseView?.backgroundColor = Utils.colorWithHexString(hex: "#EFEFF4") // Grey
                    currentQuizzIconStatusResponseImageView?.isHighlighted = true
                    self.userResponseLabel?.textColor = UIColor.black
                    self.userResponseTitleLabel?.textColor = UIColor.black
                }
                else if (userCorrectPoint > 0 && userIncorrectPoint >= 0) {
                    currentQuizzSummaryResponseView?.backgroundColor = Utils.colorWithHexString(hex: "#EFEFF4") // Grey
                    currentQuizzIconStatusResponseImageView?.isHighlighted = false
                    self.userResponseLabel?.textColor = UIColor.black
                    self.userResponseTitleLabel?.textColor = UIColor.black
                }
                    
                else if (userCorrectPoint == 0) {
                    currentQuizzSummaryResponseView?.backgroundColor = Utils.colorWithHexString(hex: "#BD2716") // Red
                    currentQuizzIconStatusResponseImageView?.isHighlighted = false
                    self.userResponseLabel?.textColor = UIColor.white
                    self.userResponseTitleLabel?.textColor = UIColor.white
                }
            }
        }

    }
    
    func showNextQuizz() {
        quizzView?.isHidden = false
        responseView?.isHidden = true
        validateButton?.isHidden = false
        nextButton?.isHidden = true
        reloadData(index: currentQuizzIndex)
    }
    
    func showSummaryResponse() {
        var totalPercentInPoint: Float = 0.0
        var percentInPoint: Float = 0.0
        quizzView?.isHidden = true
        responseView?.isHidden = true
        validateButton?.isHidden = true
        nextButton?.isHidden = true
        summaryResponseView?.isHidden = false
        questionMarkView?.isHidden = true
        resultLabel?.isHidden = false
        titleLabel?.isHidden = true
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
        percentResponseView?.isHidden = false
    
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
        let orient = UIApplication.shared.statusBarOrientation
        if orient == .portrait {
            if patientHistoryView?.isHidden == true {
                patientHistoryView?.isHidden = false
            }
            else {
                patientHistoryView?.isHidden = true
            }
        }
    }
    
    @objc func backButtonAction() {
        if currentQuizzIndex < quizzDataArray.count  {
            let alert = UIAlertController(title: "The quiz is in progress", message: "Do you really want to select new case?", preferredStyle: UIAlertController.Style.alert)
            //alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.Default, handler: nil))
            //alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            alert.addAction(UIAlertAction(title: "No", style: .default, handler: nil))
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
                switch action.style{
                case .default:
                    self.navigationController?.popViewController(animated: true)
                    
                case .cancel:
                    print("YES cancel")
                    
                case .destructive:
                    print("Ys destructive")
                }
            }))
        }
        else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
}
