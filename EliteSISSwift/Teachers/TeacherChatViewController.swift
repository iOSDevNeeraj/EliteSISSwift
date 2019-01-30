//
//  TeacherChatViewController.swift
//  EliteSISSwift
//
//  Created by Vivek Garg on 26/03/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import UIKit
import DropDown
import Alamofire
import SwiftyJSON
import ALLoadingView

class TeacherChatViewController: UIViewController, UITableViewDelegate,UITableViewDataSource, UITextViewDelegate {
    var dataSourceClassses = [String]()
    var selectedTeacher = "Vasudha Mishra"
    var dropDownTeachers: DropDown!
    
    @IBOutlet weak var btnSend: UIButton!
    @IBOutlet weak var textViewMsg: UITextView!
    @IBOutlet weak var textViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var viewTeacherSelection: UIView!
    @IBOutlet weak var lblTeacherName: UILabel!
    @IBOutlet weak var tblViewDiscussion: UITableView!
    @IBOutlet weak var lblSelectedClass: UILabel!
    var teacherId: String = ""
    
    var nameString:String!
    var arrMsgData = [String]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.configDropDown()
        //lblTeacherName.layer.borderWidth = 1.0
        //lblTeacherName.layer.borderColor = UIColor.black.cgColor
        tblViewDiscussion.separatorStyle = .none
        tblViewDiscussion.register(UINib(nibName: Constants.Nib.NibIdentifier.receiverTableViewCell, bundle: nil), forCellReuseIdentifier: Constants.Nib.ReusableIdentifier.receiverTableViewCell)
        tblViewDiscussion.rowHeight = UITableViewAutomaticDimension
        tblViewDiscussion.delegate = self
        tblViewDiscussion.dataSource = self
        textViewMsg.delegate = self
        
        if nameString != nil {
            lblTeacherName.text = nameString
        }
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    //MARK: Configure Drop-down
    func configDropDown()
    {
        dropDownTeachers = DropDown()
        // The view to which the drop down will appear on
        dropDownTeachers.anchorView = self.viewTeacherSelection
        // call API here
        ProgressLoader.shared.showLoader(withText: "Please wait...")
        guard let ClassSession = UserDefaults.standard.object(forKey: "_sis_currentclasssession_value") as? String else { return }
        WebServices.shared.ChooseTeacherForDiscussion(classSession: ClassSession, completion: { (response, error) in
            
            if error == nil, let responseDict = response
            {
                debugPrint(responseDict)
                print("Response: \(responseDict)")
                
                //  for dic in responseDict["value"] {
                for index in 0..<4 {
                    let SubjectName = responseDict["value"][index]["new_subject"]["sis_name"].stringValue
                    let FacultyName = responseDict["value"][index]["new_faculty"]["sis_name"].stringValue
                    let Facultyid = responseDict["value"][index]["new_faculty"]["sis_facultyid"].stringValue
                    
                    self.teacherId = Facultyid
                    print("\(FacultyName), \(SubjectName)")
                    print(SubjectName)
                    self.dataSourceClassses.append("\(FacultyName), \(SubjectName), \(Facultyid)")
                }
                
                
                ProgressLoader.shared.hideLoader()
                print(self.dataSourceClassses)
                // The list of items to display. Can be changed dynamically
                self.dropDownTeachers.dataSource = self.dataSourceClassses
                
                self.dropDownTeachers.selectionAction = { [unowned self] (index: Int, item: String) in
                    self.showTeacherClass(classSelected: item)
                    
                }
            }
            else
            {
                ProgressLoader.shared.hideLoader()
                AlertManager.shared.showAlertWith(title: Constants.Alert.error, message: Constants.Alert.somethingWentWrongMsg)
                debugPrint(error?.localizedDescription ?? "Getting user profile error")
            }
        })
    }
    
    func showTeacherClass(classSelected: String)
    {
        self.lblSelectedClass.text = classSelected
        self.selectedTeacher = classSelected
        
        
    }
    
    //MARK: Table View Delegate Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMsgData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Nib.NibIdentifier.receiverTableViewCell) as! ReceiverTableViewCell
        cell.lblMsg.text = arrMsgData[indexPath.row]
        cell.backgroundColor = UIColor.clear
        cell.selectionStyle = .none
        return cell
    }
    
    @IBAction func btnSendClicked(_ sender: UIButton) {
        if textViewMsg.text != nil && textViewMsg.text.count != 0 {
            
            arrMsgData.append(textViewMsg.text!)
            tblViewDiscussion.reloadData()
            tblViewDiscussion.scrollToRow(at: IndexPath(row:arrMsgData.count - 1 , section: 0), at: .bottom, animated: false)
            
//         let payload =    {"new_Sender@odata.bind": "/contacts(288884a8-e8f9-e811-a971-000d3af288b3)", "new_Recipient@odata.bind": "/contacts(db414274-77fc-e811-a974-000d3af2837b)", "new_message": "hi"}
            
            
            let payload: Parameters = [Constants.ServerKey.Discussion.new_Sender: "contacts\(teacherId)", Constants.ServerKey.Discussion.new_Recipient: "contacts\("SIS|K12|S|1819|0008")",Constants.ServerKey.Discussion.new_message: textViewMsg.text!]
            
            ActivitiesGetService.executeRequestForPostDiscussion( parmeter: payload) { (json, error) in
                print(json)
            
            }
            textViewMsg.text = ""
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n"
        {
            textView.resignFirstResponder()
            return false
        }
        return true
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
            textViewBottomConstraint.constant = kbHeight
        }
        if kbHeight == 0 {
            textViewBottomConstraint.constant = 15
        }
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showMenu(_ sender: Any)
    {
        toggleSideMenuView()
    }
    
    @IBAction func backbuttonClicked(_ sender: Any) {
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: Constants.Storybaord.MainStoryboard,bundle: nil)
        var destViewController : UIViewController
        // destViewController = mainStoryboard.instantiateViewController(withIdentifier: "dashboard")
        //sideMenuController()?.setContentViewController(destViewController)
        // let selectedLogin = UserDefaults.standard.string(forKey: "selectedLogin")
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
            self.navigationController?.popViewController(animated: true)
            //            destViewController = mainStoryboard.instantiateViewController(withIdentifier: "teacherdashboard")
            //            sideMenuController()?.setContentViewController(destViewController)
        }
            //else if(selectedLogin == "G") //Parent
        else if(selectedLogin == "3") //Parent
        {
            destViewController = mainStoryboard.instantiateViewController(withIdentifier: Constants.Storybaord.Identifier.parentDashboard)
            sideMenuController()?.setContentViewController(destViewController)
        }
        
        hideSideMenuView()
    }
    
    @IBAction func selectTeacherBtnClicked(_ sender: Any)
    {
        if dropDownTeachers.isHidden
        {
            dropDownTeachers.show()
            hideSideMenuView()
        }
        else
        {
            dropDownTeachers.hide()
        }
    }
}
