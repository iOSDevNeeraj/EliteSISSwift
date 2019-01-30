//
//  ComplaintDetailViewController.swift
//  EliteSISSwift
//
//  Created by Vivek Garg on 14/04/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import UIKit

class ComplaintDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, LoginButtonDelegate {
    
    @IBOutlet weak var tblViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var tblViewCompliance: UITableView!
    var strSubject:String!
    var strCaseId:String!
    var strCaseDesc:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblViewCompliance.separatorStyle = .none
        
        tblViewCompliance.register(UINib(nibName: Constants.Nib.NibIdentifier.complaintHeadingTableViewCell, bundle:nil), forCellReuseIdentifier: Constants.Nib.ReusableIdentifier.complaintHeadingTableViewCell)
        
        tblViewCompliance.register(UINib(nibName: Constants.Nib.NibIdentifier.complaintTextViewTableViewCell, bundle:nil), forCellReuseIdentifier: Constants.Nib.ReusableIdentifier.complaintTextViewTableViewCell)
        
        tblViewCompliance.register(UINib(nibName: Constants.Nib.NibIdentifier.buttonWithBgTableViewCell, bundle:nil), forCellReuseIdentifier: Constants.Nib.ReusableIdentifier.buttonWithBgTableViewCell)
        
        tblViewCompliance.dataSource = self
        tblViewCompliance.delegate = self
        
        tblViewCompliance.rowHeight = UITableViewAutomaticDimension
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
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
            DispatchQueue.main.async {
                self.tblViewCompliance.scrollToRow(at: IndexPath(row: 2, section: 0), at: .middle, animated: true)
            }
        }
        if kbHeight == 0 {
            tblViewBottomConstraint.constant = 0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
            
            
        case 2:
            return 250
            
        case 3:
            return 90
            
        default:
            return UITableViewAutomaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Nib.ReusableIdentifier.complaintHeadingTableViewCell) as! ComplaintHeadingTableViewCell
            cell.backgroundColor = UIColor.clear
            cell.label.text = strSubject
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Nib.ReusableIdentifier.complaintHeadingTableViewCell) as! ComplaintHeadingTableViewCell
            cell.backgroundColor = UIColor.clear
            if self.strCaseDesc != ""{
                cell.label.text = self.strCaseDesc //"Text will be different, so not setting it as of now any constant, will set it once the data comes"
            }else{
                
                cell.label.text = "Message"
            }
            return cell
            
        case 2 :
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Nib.ReusableIdentifier.complaintTextViewTableViewCell) as! ComplaintTextViewTableViewCell
            cell.backgroundColor = UIColor.clear
            
            return cell
            
        case 3:
            let cellLoginBtn = tableView.dequeueReusableCell(withIdentifier: Constants.Nib.ReusableIdentifier.buttonWithBgTableViewCell) as! ButtonWithBgTableViewCell
            cellLoginBtn.backgroundColor = UIColor.clear
            cellLoginBtn.delegate = self
            cellLoginBtn.btnInCell.setTitle(Constants.submit, for: .normal)
            
            cellLoginBtn.selectionStyle = .none
            return cellLoginBtn
            
        default:
            return UITableViewCell()
        }
    }
    
    func buttonClicked() {
        
        let responseforComplaint = self.tblViewCompliance.cellForRow(at: IndexPath(row: 2, section: 0)) as! ComplaintTextViewTableViewCell
        print (responseforComplaint.textViewReason.text!)
        
        if  (responseforComplaint.textViewReason.text!.count) > 0
        {
            if  (responseforComplaint.textViewReason.text! == "Response to Complaints")
            {
                let alert = UIAlertController(title: Constants.Alert.error, message: Constants.Alert.blankResponseAlertMsg, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: Constants.ok, style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            else
            {
                let alert = UIAlertController(title: Constants.success, message: Constants.Alert.successResponseAlertMsg, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: Constants.ok, style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        else
        {
            let alert = UIAlertController(title: Constants.Alert.error, message: Constants.Alert.blankResponseAlertMsg, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: Constants.ok, style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showMenu(_ sender: Any)
    {
        toggleSideMenuView()
    }
    
    @IBAction func backbuttonClicked(_ sender: Any)
    {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: Constants.Storybaord.MainStoryboard,bundle: nil)
        var destViewController : UIViewController
        // destViewController = mainStoryboard.instantiateViewController(withIdentifier: "dashboard")
        //sideMenuController()?.setContentViewController(destViewController)
        let selectedLogin=UserDefaults.standard.string(forKey: Constants.ServerKey.selectedLogin)
        
       // if (selectedLogin == "S") //Student
        if (selectedLogin == "1") //Student
        {
            destViewController = mainStoryboard.instantiateViewController(withIdentifier: Constants.Storybaord.Identifier.dashboard)
            sideMenuController()?.setContentViewController(destViewController)
        }
        //else if(selectedLogin == "E") //Teacher
        else if(selectedLogin == "2") //Teacher
        {
            destViewController = mainStoryboard.instantiateViewController(withIdentifier: Constants.Storybaord.Identifier.teacherDashboard)
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
    
}
