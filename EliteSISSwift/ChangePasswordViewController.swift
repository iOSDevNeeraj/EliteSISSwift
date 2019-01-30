//
//  ChangePasswordViewController.swift
//  EliteSISSwift
//
//  Created by Reetesh Bajpai on 23/03/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import UIKit
import SwiftHash
import Alamofire

class ChangePasswordViewController: UIViewController , UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tblViewChangePwd: UITableView!
    @IBOutlet weak var tblViewBottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tblViewChangePwd.separatorStyle = .none
        tblViewChangePwd.register(UINib(nibName: Constants.Nib.NibIdentifier.logoTableViewCell, bundle:nil), forCellReuseIdentifier: Constants.Nib.ReusableIdentifier.logoTableViewCell)
        tblViewChangePwd.register(UINib(nibName: Constants.Nib.NibIdentifier.buttonWithBgTableViewCell, bundle:nil), forCellReuseIdentifier: Constants.Nib.ReusableIdentifier.buttonWithBgTableViewCell)
        tblViewChangePwd.register(UINib(nibName: Constants.Nib.NibIdentifier.loginCredentialsTableViewCell, bundle:nil), forCellReuseIdentifier: Constants.Nib.ReusableIdentifier.loginCredentialsTableViewCell)
        tblViewChangePwd.register(UINib(nibName: Constants.Nib.NibIdentifier.simpleLabelTableViewCell, bundle:nil), forCellReuseIdentifier: Constants.Nib.ReusableIdentifier.simpleLabelTableViewCell)
        
        tblViewChangePwd.delegate = self
        tblViewChangePwd.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
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
        }
        if kbHeight == 0 {
            tblViewBottomConstraint.constant = 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.row {
            
        case 0:
            return 250
            
        case 1:
            return UITableViewAutomaticDimension
            
        case 2,3,4:
            return 60
            
        case 5:
            return 70
            
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
            
        case 0:
            let cellLogo = tableView.dequeueReusableCell(withIdentifier: Constants.Nib.ReusableIdentifier.logoTableViewCell) as! LogoTableViewCell
            cellLogo.backgroundColor = UIColor.clear
            cellLogo.selectionStyle = .none
            return cellLogo
            
        case 1:
            let cellDesc = tableView.dequeueReusableCell(withIdentifier: Constants.Nib.ReusableIdentifier.simpleLabelTableViewCell) as! SimpleLabelTableViewCell
            cellDesc.lblContent.text = "Create a new password that is at least 6 Characters long. A strong password has a combination  of letters, digit and punctuation marks."
            cellDesc.lblContent.font = UIFont.systemFont(ofSize: 15)
            cellDesc.backgroundColor = UIColor.clear
            cellDesc.selectionStyle = .none
            return cellDesc
            
        case 2:
            let cellUserTxtFld = tableView.dequeueReusableCell(withIdentifier: Constants.Nib.ReusableIdentifier.loginCredentialsTableViewCell) as! LoginCredentialsTableViewCell
            cellUserTxtFld.backgroundColor = UIColor.clear
            cellUserTxtFld.textField.placeholder = Constants.PlaceholderText.oldPasswordPlaceholder
            cellUserTxtFld.textField.isSecureTextEntry = true
            cellUserTxtFld.selectionStyle = .none
            // cellUserTxtFld.imgView.image = UIImage(named: "ic_user.png")
            cellUserTxtFld.imageView?.image = UIImage(named:"ic_lock.png")!.withRenderingMode(.alwaysTemplate)
            //UIImage(named: arrMenuImages[indexPath.row])
            cellUserTxtFld.imageView?.tintColor = UIColor.init(red: 44.0/255.0, green: 154.0/255.0, blue: 243.0/255.0, alpha: 1.0)
            return cellUserTxtFld
            
        case 3:
            let cellUserTxtFld = tableView.dequeueReusableCell(withIdentifier: Constants.Nib.ReusableIdentifier.loginCredentialsTableViewCell) as! LoginCredentialsTableViewCell
            cellUserTxtFld.backgroundColor = UIColor.clear
            cellUserTxtFld.textField.placeholder = Constants.PlaceholderText.newPasswordPlaceholder
            cellUserTxtFld.textField.isSecureTextEntry = true
            cellUserTxtFld.selectionStyle = .none
            // cellUserTxtFld.imgView.image = UIImage(named: "ic_user.png")
            cellUserTxtFld.imageView?.image = UIImage(named:"ic_lock.png")!.withRenderingMode(.alwaysTemplate)
            //UIImage(named: arrMenuImages[indexPath.row])
            cellUserTxtFld.imageView?.tintColor = UIColor.init(red: 44.0/255.0, green: 154.0/255.0, blue: 243.0/255.0, alpha: 1.0)
            return cellUserTxtFld
            
        case 4:
            let cellUserTxtFld = tableView.dequeueReusableCell(withIdentifier: Constants.Nib.ReusableIdentifier.loginCredentialsTableViewCell) as! LoginCredentialsTableViewCell
            cellUserTxtFld.backgroundColor = UIColor.clear
            cellUserTxtFld.textField.placeholder = Constants.PlaceholderText.confirmPasswordPlaceholder
            cellUserTxtFld.textField.isSecureTextEntry = true
            cellUserTxtFld.selectionStyle = .none
            // cellUserTxtFld.imgView.image = UIImage(named: "ic_user.png")
            cellUserTxtFld.imageView?.image = UIImage(named:"ic_lock.png")!.withRenderingMode(.alwaysTemplate)
            //UIImage(named: arrMenuImages[indexPath.row])
            cellUserTxtFld.imageView?.tintColor = UIColor.init(red: 44.0/255.0, green: 154.0/255.0, blue: 243.0/255.0, alpha: 1.0)
            return cellUserTxtFld
            
            
        case 5:
            let cellLoginBtn = tableView.dequeueReusableCell(withIdentifier: Constants.Nib.ReusableIdentifier.buttonWithBgTableViewCell) as! ButtonWithBgTableViewCell
            cellLoginBtn.backgroundColor = UIColor.clear
            //            cellLoginBtn.protocolButtonClickImplementation = self
            cellLoginBtn.btnInCell.setTitle("SUBMIT", for: .normal)
            cellLoginBtn.delegate = self
            cellLoginBtn.selectionStyle = .none
            return cellLoginBtn
            
        default:
            return UITableViewCell()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func onSubmitClick()
    {
        let oldPassword = (self.tblViewChangePwd.cellForRow(at: IndexPath(row: 2, section: 0)) as! LoginCredentialsTableViewCell).textField.text
        let newPassword = self.tblViewChangePwd.cellForRow(at: IndexPath(row: 3, section: 0)) as! LoginCredentialsTableViewCell
        let confirmPassword = self.tblViewChangePwd.cellForRow(at: IndexPath(row: 4, section: 0)) as! LoginCredentialsTableViewCell
        
        if (validPassword(newPassword: newPassword.textField.text ?? "", confirmPassword: confirmPassword.textField.text ?? ""))
        {
            //Implement API here to change password:
            self.callForChangePassword(oldPassword: oldPassword ?? "", changedPassword: newPassword.textField.text ?? "")
        }
        else
        {
            print("Password can't be submitted")
        }
    }
    
    /* func callForChangePassword(oldPassword: String, changedPassword: String)
     {
     ProgressLoader.shared.showLoader(withText: "Please wait...")
     
     // guard let regID = UserDefaults.standard.object(forKey: "_sis_registration_value") as? String else { return }
     // let loginmasterID = UserDefaults.standard.string(forKey: Constants.ServerKey.Login.loginmasterID)
     guard let loginmasterID = UserDefaults.standard.object(forKey: Constants.ServerKey.Login.loginmasterID) as? String else { return }
     
     //Encode the changed/new password:
     let md5EncodedPassword = MD5(changedPassword)
     
     //Creating JSON payload:
     /* let payload = [
     Constants.ServerKey.ChangePassword.oldPasswordKey: md5EncodedPassword,
     Constants.ServerKey.ChangePassword.changePasswordKey: "true"
     ]
     let payload = JSON(payload)  */
     
     
     let payload: Parameters = [Constants.ServerKey.ChangePassword.oldPasswordKey: md5EncodedPassword, Constants.ServerKey.ChangePassword.changePasswordKey: "true"]
     /*  let tempdict = NSMutableDictionary()
     tempdict.setValue(Constants.ServerKey.ChangePassword.oldPasswordKey, forKey: md5EncodedPassword)
     tempdict.setValue(Constants.ServerKey.ChangePassword.changePasswordKey, forKey: "true")
     
     let jsonData = try? JSONSerialization.data(withJSONObject: tempdict, options: [])
     let jsonString = String(data: jsonData!, encoding: .utf8)
     print("JSON data: \(jsonString)") */
     
     WebServices.shared.changePassword(loginmasterID: loginmasterID, payloadData: payload, completion: { (response, error) in
     if error == nil, let responseDict = response
     {
     print("Response: \(responseDict)")
     
     /*     let className1 = responseDict["value"][0]["sis_currentclasssession"]["sis_name"].stringValue
     let fullNameArr = className1.split(separator: " ")
     self.classNameValue = "\(fullNameArr[1])(\(responseDict["value"][0]["sis_section"]["sis_name"]))"
     // UserDefaults.standard.set(self.classNameValue, forKey: "_sis_class_value")
     print("Class Name Value: \(self.classNameValue)")
     let classSession = responseDict["value"][0]["_sis_currentclasssession_value"].stringValue
     UserDefaults.standard.set(classSession, forKey: "_sis_currentclasssession_value")
     
     let studentID = responseDict["value"][0]["sis_studentid"].stringValue
     UserDefaults.standard.set(studentID, forKey: "sis_studentid")
     
     let parentsName = responseDict["value"][0]["sis_fathername"].stringValue
     UserDefaults.standard.set(parentsName, forKey: "sis_fathername")
     //  ProgressLoader.shared.hideLoader()
     self.setupDisplay()   */
     
     //Show alert for success response:
     print("Password can be submitted")
     let alert = UIAlertController(title: Constants.done, message: Constants.Alert.passwordChangedMsg, preferredStyle: UIAlertControllerStyle.alert)
     alert.addAction(UIAlertAction(title: Constants.ok, style: UIAlertActionStyle.default, handler: nil))
     self.present(alert, animated: true, completion: nil)
     
     ProgressLoader.shared.hideLoader()
     }
     else
     {
     ProgressLoader.shared.hideLoader()
     AlertManager.shared.showAlertWith(title: Constants.Alert.error, message: Constants.Alert.somethingWentWrongMsg)
     debugPrint(error?.localizedDescription ?? "Change password error")
     }
     })
     } */
    
    func callForChangePassword(oldPassword: String, changedPassword: String)
    {
        ProgressLoader.shared.showLoader(withText: "Please wait...")
        // guard let regID = UserDefaults.standard.object(forKey: "_sis_registration_value") as? String else { return }
        // let loginmasterID = UserDefaults.standard.string(forKey: Constants.ServerKey.Login.loginmasterID)
        guard let loginmasterID = UserDefaults.standard.object(forKey: Constants.ServerKey.Login.loginmasterID) as? String else { return }
        //Encode the changed/new password:
        let md5EncodedPassword = MD5(changedPassword)
        
        let requestURL = Constants.BASE_URL + Constants.API.changePassword + loginmasterID + "/" + Constants.accessNumberForChangePassword + "/" + Constants.SchoolID
        print("Change Password URL: \(requestURL)")
        
        let url = URL(string: requestURL)!
        var request = URLRequest(url: url)
        
       // var request = URLRequest(url: NSURL(string: "API URL")! as URL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("MobileApp", forHTTPHeaderField: "UserName") //Constant values for headers
        request.setValue("7b3639a4ab39765739a5e0ed75bc8016", forHTTPHeaderField: "Pwd") //Constant values for headers
        //let bodyDic = ["sis_oldpassword" : "13f44a636a897372014412a04201eabf", "sis_changepassowrd" : "true"]
        let bodyDic = [Constants.ServerKey.ChangePassword.oldPasswordKey : md5EncodedPassword, Constants.ServerKey.ChangePassword.changePasswordKey : "true"]
        let data = try! JSONSerialization.data(withJSONObject: bodyDic, options: JSONSerialization.WritingOptions.prettyPrinted)
        let json = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
        
        if let json = json
        {
            print("Request body for change password: \(json)")
        }
        
       request.httpBody = json!.data(using: String.Encoding.utf8.rawValue);
      let r =  Alamofire.request(request as URLRequestConvertible).responseJSON { response in
            print("Response: \(response.result.value)")
            switch response.result
            {
            case .success:
                if let result = response.result.value
                {
                    //Show alert for success response:
                    print("Password can be submitted")
                    let alert = UIAlertController(title: Constants.done, message: Constants.Alert.passwordChangedMsg, preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: Constants.ok, style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    ProgressLoader.shared.hideLoader()
                }
            case .failure(let error):
                ProgressLoader.shared.hideLoader()
                AlertManager.shared.showAlertWith(title: Constants.Alert.error, message: Constants.Alert.somethingWentWrongMsg)
                debugPrint(error.localizedDescription ?? "Change password error")
                print(error)
                ProgressLoader.shared.hideLoader()
            }
        }
        
        debugPrint(r)
        
        /*Alamofire.request(request).responseJSON(completionHandler: { (response) in
            switch response.result {
            case .success(let value):
                break
                
            case .failure(let error):
                print("\n\n===========Error===========")
                print("Error Code: \(error._code)")
                print("Error Messsage: \(error.localizedDescription)")
                if let data = response.data, let str = String(data: data, encoding: String.Encoding.utf8){
                    print("Server Error: " + str)
                }
                debugPrint(error as Any)
                print("===========================\n\n")
            }
            
        }) */
    }
    
    func validateOldPassword()
    {
        
    }
    
    @IBAction func submitClicked(_ sender: Any)
    {
        
    }
    
    func first()
    {
        print("Hello World")
    }
    
    func validPassword(newPassword: String, confirmPassword: String) -> Bool {
        
        if  (newPassword.count) < 6
        {
            print("Please enter more than 5 characters in New Password field")
            let alert = UIAlertController(title: Constants.Alert.title, message: "Please enter more than 5 characters in New Password field", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: Constants.ok, style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return false
        }
        
        if(newPassword != confirmPassword )
        {
            let alert = UIAlertController(title: Constants.Alert.title, message: "New password and confirm password don't match.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: Constants.ok, style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return false
        }
        
        return true
    }
    
    @IBAction func showMenu(_ sender: Any) {
        
        toggleSideMenuView()
    }
    
    @IBAction func backbuttonClicked(_ sender: Any) {
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: Constants.Storybaord.MainStoryboard,bundle: nil)
        var destViewController : UIViewController
        
        //        destViewController = mainStoryboard.instantiateViewController(withIdentifier: "dashboard")
        //        sideMenuController()?.setContentViewController(destViewController)
        
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

extension ChangePasswordViewController: LoginButtonDelegate {
    
    func buttonClicked() {
        self.onSubmitClick()
    }
}

