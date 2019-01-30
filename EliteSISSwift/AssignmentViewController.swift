//
//  AssignmentViewController.swift
//  EliteSISSwift
//
//  Created by Vivek Garg on 24/02/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import UIKit

class AssignmentViewController: UIViewController, UITableViewDelegate,UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var searchBarAssignment: UISearchBar!
    @IBOutlet weak var tblViewAssignment: UITableView!
    var arrAssignments = [[String : Any]]()
    var arrResult = [[String : Any]]()
    
    @IBOutlet weak var tblViewBottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.callAssignment()
        tblViewAssignment.separatorStyle = .none
        
        tblViewAssignment.delegate = self
        tblViewAssignment.dataSource = self
        searchBarAssignment.delegate = self
        
        //Dummy data:
        var dictMaths = [String:String]()
        dictMaths["desc"] = "Maths - Write 1 - 10"
        dictMaths["issueDate"] = "5-Jan-2018"
        dictMaths["submitDate"] = "4-Nov-2018"
        
        var dictEng = [String:String]()
        dictEng["desc"] = "English - Write A - Z"
        dictEng["issueDate"] = "5-Jan-2018"
        dictEng["submitDate"] = "20-Nov-2018"
        
        var dictArt = [String:String]()
        dictArt["desc"] = "Art - Draw Flower"
        dictArt["issueDate"] = "5-Jan-2018"
        dictArt["submitDate"] = "14-Dec-2018"
        
        var dictLearn = [String:String]()
        dictLearn["desc"] = "Learn Rhyme - Twinkle Twinkle"
        dictLearn["issueDate"] = "7-Jan-2018"
        dictLearn["submitDate"] = "4-Nov-2018"
        
        //Hard-coding the assignment values:
        /*
         arrAssignments.append(dictMaths)
         arrAssignments.append(dictEng)
         arrAssignments.append(dictArt)
         arrAssignments.append(dictLearn)
         
         arrResult.append(dictMaths)
         arrResult.append(dictEng)
         arrResult.append(dictArt)
         arrResult.append(dictLearn) */
        
        tblViewAssignment.sectionHeaderHeight = 60
        
        tblViewAssignment.estimatedRowHeight = 50
        tblViewAssignment.rowHeight = UITableViewAutomaticDimension
        
        tblViewAssignment.register(UINib(nibName:Constants.Nib.NibIdentifier.assignmentTableViewCell, bundle: nil), forCellReuseIdentifier: Constants.Nib.ReusableIdentifier.assignmentTableViewCell)
        tblViewAssignment.register(UINib(nibName:Constants.Nib.NibIdentifier.assignmentHeaderReusableView, bundle: nil), forHeaderFooterViewReuseIdentifier: Constants.Nib.ReusableIdentifier.assignmentHeaderReusableView)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(AssignmentViewController.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(AssignmentViewController.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        guard let kbSizeValue = (notification as NSNotification).userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue else { return }
        guard let kbDurationNumber = (notification as NSNotification).userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber else { return }
        animateToKeyboardHeight(kbSizeValue.cgRectValue.height, duration: kbDurationNumber.doubleValue)
    }
    
    
    @objc func keyboardWillHide(_ notification: Notification) {
        guard let kbDurationNumber = (notification as NSNotification).userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber else { return }
        animateToKeyboardHeight(0, duration: kbDurationNumber.doubleValue)
    }
    
    func animateToKeyboardHeight(_ kbHeight: CGFloat, duration: Double) {
        if kbHeight > 0 {
            tblViewBottomConstraint.constant = kbHeight
        }
        if kbHeight == 0 {
            tblViewBottomConstraint.constant = 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrAssignments.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let viewHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: Constants.Nib.ReusableIdentifier.assignmentHeaderReusableView) as! AssignmentHeaderReusableView
        
        viewHeader.contentView.backgroundColor = UIColor.init(red: 44.0/255.0, green: 154.0/255.0, blue: 243.0/255.0, alpha: 1.0) //44 154 243
        return viewHeader
    }
    
    //Neeraj_Jan_21
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    //Neeraj_Jan_21
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Nib.ReusableIdentifier.assignmentTableViewCell) as! AssignmentTableViewCell
        //cell.lblDescription.text = arrAssignments[indexPath.row]["desc"] as! String
        cell.lblDescription.text = arrAssignments[indexPath.row][Constants.ServerKey.AssignmentKey.name] as? String
        
        //Convert the issue date to the required format:
        let issueDateStringFromServer = arrAssignments[indexPath.row][Constants.ServerKey.AssignmentKey.issueDate] as? String
        let arrIssueDate = issueDateStringFromServer!.components(separatedBy: "T")
        let issueDateString = arrIssueDate[0]
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let issueDate = dateFormatter.date(from: issueDateString)
        
        dateFormatter.dateFormat = "dd-MMM"
        let issueDateFinal = dateFormatter.string(from: issueDate!)
        //print(issueDate)
        // cell.lblIssueDate.text = arrAssignments[indexPath.row]["issueDate"] as! String
        //cell.lblIssueDate.text = arrAssignments[indexPath.row][Constants.ServerKey.AssignmentKey.issueDate] as? String
        cell.lblIssueDate.text = issueDateFinal
        
        //Convert the due date to the required format:
        let dueDateStringFromServer = arrAssignments[indexPath.row][Constants.ServerKey.AssignmentKey.dueDate] as? String
        let arrDueDate = dueDateStringFromServer!.components(separatedBy: "T")
        let dueDateString = arrDueDate[0]
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "yyyy-MM-dd"
        let dueDate = dateFormatter2.date(from: dueDateString)
        
        dateFormatter2.dateFormat = "dd-MMM"
        let dueDateFinal = dateFormatter2.string(from: dueDate!)
        //print(dueDateFinal)
        
        // cell.lblSubmitDate.text = arrAssignments[indexPath.row]["submitDate"] as? String
        //cell.lblSubmitDate.text = arrAssignments[indexPath.row][Constants.ServerKey.AssignmentKey.dueDate] as? String
        cell.lblSubmitDate.text = dueDateFinal
        
        cell.btnViewAssignment.tag = indexPath.row
        cell.btnViewAssignment.addTarget(self, action: #selector(AssignmentViewController.showAssignmentDetails(btn:)), for: .touchUpInside)
        cell.btnDownloadAssignment.addTarget(self, action: #selector(AssignmentViewController.downloadAssignment(btn:)), for: .touchUpInside)
        return cell
    }
    
    @objc func downloadAssignment(btn:UIButton) {
        let alert = UIAlertController(title: "Assignment Downloaded!", message: nil, preferredStyle: .alert)
        let dismiss = UIAlertAction(title: Constants.ok, style: .cancel, handler: nil)
        alert.addAction(dismiss)
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func showAssignmentDetails(btn:UIButton) {
        let alert = UIAlertController(title: "Assignment", message: arrAssignments[btn.tag][Constants.ServerKey.AssignmentKey.name] as? String, preferredStyle: .alert)
        let dismiss = UIAlertAction(title: Constants.ok, style: .cancel, handler: nil)
        alert.addAction(dismiss)
        self.present(alert, animated: true, completion: nil)
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        let doneToolBar : UIToolbar = UIToolbar(frame: CGRect(x: 0 ,y: 0 ,width: UIScreen.main.bounds.width,height: 50))
        var items = [UIBarButtonItem]()
        items.append(UIBarButtonItem(title: Constants.done, style: .plain, target: self, action: #selector(AssignmentViewController.dismissKeypad)))
        doneToolBar.items = items
        searchBar.inputAccessoryView = doneToolBar
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // arrAssignments = arrResult.filter{$0["desc"]?.range(of: searchText, options: .caseInsensitive) != nil}
        //arrAssignments = arrResult.filter{($0[Constants.ServerKey.AssignmentKey.name] as AnyObject).range(of: searchText, options: .caseInsensitive) != nil}
        arrResult = arrAssignments.filter{($0[Constants.ServerKey.AssignmentKey.name] as AnyObject).range(of: searchText, options: .caseInsensitive) != nil}
        
        if searchText.count == 0 {
            arrAssignments = arrResult
        }
        tblViewAssignment.reloadData()
    }
    
    @objc func dismissKeypad() {
        self.view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showMenu(_ sender: Any) {
        toggleSideMenuView()
        
    }
    
    @IBAction func toggleSideMenuBtn(_ sender: UIBarButtonItem) {
        toggleSideMenuView()
    }
    
    @IBAction func backbuttonClicked(_ sender: Any) {
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: Constants.Storybaord.MainStoryboard,bundle: nil)
        var destViewController : UIViewController
        // destViewController = mainStoryboard.instantiateViewController(withIdentifier: "dashboard")
        //sideMenuController()?.setContentViewController(destViewController)
        let selectedLogin = UserDefaults.standard.string(forKey: Constants.ServerKey.selectedLogin)
        
        //if (selectedLogin == "S") //Student
        if (selectedLogin == "1") //Student
        {
            destViewController = mainStoryboard.instantiateViewController(withIdentifier: Constants.Storybaord.Identifier.dashboard)
            sideMenuController()?.setContentViewController(destViewController)
        }
            //else if(selectedLogin == "E") //Teacher
        else if(selectedLogin == "2") //Teacher
        {
            destViewController = mainStoryboard.instantiateViewController(withIdentifier: Constants.Storybaord.Identifier.dashboard)
            sideMenuController()?.setContentViewController(destViewController)
        }
            //else if(selectedLogin == "G") //Parent
        else if(selectedLogin == "3") //Parent
        {
            destViewController = mainStoryboard.instantiateViewController(withIdentifier: Constants.Storybaord.Identifier.parentDashboard)
            sideMenuController()?.setContentViewController(destViewController)
        }
        
        hideSideMenuView()
    }
    
    func callAssignment()
    {
        ProgressLoader.shared.showLoader(withText: "Please wait... ")
        guard let studentID = kUserDefaults.value(forKey: "sis_studentid") as? String else { return }
        
        WebServices.shared.showAssignmentList(studentID: studentID, completion: { (response, error) in
            
            if error == nil, let responseDict = response
            {
                debugPrint(responseDict)
                print("Assignment List Responce: \(responseDict)")
                print("Assignment List Count: \(responseDict["value"].count)")
                self.arrAssignments = responseDict["value"].arrayObject as! [[String : Any]]
                //print(self.arrAssignments)
                DispatchQueue.main.async {
                    self.tblViewAssignment.reloadData()
                }
                ProgressLoader.shared.hideLoader()
            }
            else
            {
                ProgressLoader.shared.hideLoader()
                AlertManager.shared.showAlertWith(title: Constants.Alert.errorOccured, message: Constants.Alert.tryAfterSomeTime)
                debugPrint(error?.localizedDescription ?? "Getting user profile error")
            }
        })
        
    }
}
