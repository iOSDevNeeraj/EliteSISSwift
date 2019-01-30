
//
//  LoginViewController.swift
//  EliteSISSwift
//
//  Created by Vivek Garg on 19/02/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import UIKit
import SwiftHash
import Alamofire
import SwiftyJSON

/* //Old:
 enum LoginUserType: String {
 case STUDENT = "S"
 case TEACHER = "E"
 case PARENT = "G"
 } */

//New:
enum LoginUserType: String {
    case STUDENT = "1"
    case TEACHER = "2"
    case PARENT = "3"
}

class LoginViewController: UIViewController, LoginButtonDelegate, UITableViewDelegate, UITableViewDataSource {
    
    //IBOutlets
    @IBOutlet weak var tblViewLogin: UITableView!
    @IBOutlet weak var tblViewBottomConstraint: NSLayoutConstraint!
    
    //Variables
    var selectedLogin = LoginUserType.TEACHER.rawValue
    // var btnRememberTick:UIButton!
    var btnRememberTick = UIButton(type: UIButtonType.custom) as UIButton
//    var btnRememberTick = ForgotPasswordTableViewCell.btnRememberMe as UIButton //work from here....
    var boolRemember: Bool = false
    
    //MARK:- View's lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        //button.addTarget(self, action: "btnTouched:", forControlEvents:.TouchUpInside)
        
        btnRememberTick.frame = CGRect(x: 100, y: 100, width: 100, height: 50)
            
            CGSize(width: 100, height: 40)
        tblViewLogin.separatorStyle = .none
        tblViewLogin.register(UINib(nibName: Constants.Nib.NibIdentifier.logoTableViewCell, bundle:nil), forCellReuseIdentifier: Constants.Nib.ReusableIdentifier.logoTableViewCell)
        
        tblViewLogin.register(UINib(nibName: Constants.Nib.NibIdentifier.loginCredentialsTableViewCell, bundle:nil), forCellReuseIdentifier: Constants.Nib.ReusableIdentifier.loginCredentialsTableViewCell)
        
        tblViewLogin.register(UINib(nibName: Constants.Nib.NibIdentifier.forgotPasswordTableViewCell, bundle:nil), forCellReuseIdentifier: Constants.Nib.ReusableIdentifier.forgotPasswordTableViewCell)
        tblViewLogin.register(UINib(nibName: Constants.Nib.NibIdentifier.buttonWithBgTableViewCell, bundle:nil), forCellReuseIdentifier: Constants.Nib.ReusableIdentifier.buttonWithBgTableViewCell)
        
        tblViewLogin.delegate = self
        tblViewLogin.dataSource = self
        tblViewLogin.reloadData()
        //Access user credentials cells:
        let passwordCell1 = self.tblViewLogin.cellForRow(at: IndexPath(row: 2, section: 0)) as? LoginCredentialsTableViewCell
        let userNameCell1 = self.tblViewLogin.cellForRow(at: IndexPath(row: 1, section: 0)) as? LoginCredentialsTableViewCell
        
        //Remember Me:
        btnRememberTick.addTarget(self, action: #selector(rememberMeClicked(sender:)), for: UIControl.Event.touchUpInside)
        //Check if defaults already saved the details
        if kUserDefaults.bool(forKey: Constants.RememberMeKey.rememberMe) {
            userNameCell1?.textField.text = kUserDefaults.value(forKey: Constants.RememberMeKey.savedUserName) as? String
            passwordCell1?.textField.text = kUserDefaults.value(forKey: Constants.RememberMeKey.savedPassword) as? String
            
            print(userNameCell1?.textField.text)
            print(passwordCell1?.textField.text)
            boolRemember = true
            btnRememberTick.setImage(#imageLiteral(resourceName: "confirmButton"), for: .normal)
        }
        else {
            boolRemember = false
            btnRememberTick.setImage(nil, for: .normal)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        if((self.navigationController) != nil){
            self.navigationController?.dismiss(animated: false, completion:nil)
            
        }
    }
    
    //MARK:- Selector methods
    @objc func keyboardWillShow(_ notification: Notification) {
        guard let kbSizeValue = (notification as NSNotification).userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue else { return }
        guard let kbDurationNumber = (notification as NSNotification).userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber else { return }
        animateToKeyboardHeight(kbSizeValue.cgRectValue.height, duration: kbDurationNumber.doubleValue)
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        guard let kbDurationNumber = (notification as NSNotification).userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber else { return }
        animateToKeyboardHeight(0, duration: kbDurationNumber.doubleValue)
    }
    
    /*  @objc func rememberMeClicked() {
     if boolRemember {
     boolRemember = false
     btnRememberTick.setImage(nil, for: .normal)
     } else {
     boolRemember = true
     btnRememberTick.setImage(UIImage(named:"ic_done"), for: .normal)
     }
     } */
    
    @objc func rememberMeClicked(sender: UIButton)
    {
        //Access user credentials cells:
        let passwordCell2 = self.tblViewLogin.cellForRow(at: IndexPath(row: 2, section: 0)) as! LoginCredentialsTableViewCell
        let userNameCell2 = self.tblViewLogin.cellForRow(at: IndexPath(row: 1, section: 0)) as! LoginCredentialsTableViewCell
        
        let remberCell = self.tblViewLogin.cellForRow(at: IndexPath(row: 3, section: 0)) as! ForgotPasswordTableViewCell
        
        if  boolRemember == true {
            boolRemember = false
            print(btnRememberTick.description)
            remberCell.btnRememberMe.setImage(nil, for: .normal)
            
            kUserDefaults.set(true, forKey: Constants.RememberMeKey.rememberMe)
            kUserDefaults.set(userNameCell2.textField.text, forKey: Constants.RememberMeKey.savedUserName)
            kUserDefaults.set(passwordCell2.textField.text, forKey: Constants.RememberMeKey.savedPassword)
            
            print(kUserDefaults.set(passwordCell2.textField.text, forKey: Constants.RememberMeKey.savedPassword))
            print(kUserDefaults.set(passwordCell2.textField.text, forKey: Constants.RememberMeKey.savedUserName))
        }
        else
        {
            boolRemember = true
            print(btnRememberTick.frame.size)
            remberCell.btnRememberMe.setImage(#imageLiteral(resourceName: "confirmButton"), for: .normal)
//            btnRememberTick.setBackgroundImage(#imageLiteral(resourceName: "confirmButton"), for: .normal)
            
            kUserDefaults.set(false, forKey: Constants.RememberMeKey.rememberMe)
        }
    }
    
    @objc func goToForgotPwdScreen()
    {
        if let vc = UIStoryboard(name: Constants.Storybaord.MainStoryboard, bundle: nil).instantiateViewController(withIdentifier: Constants.Storybaord.Identifier.forgotPasswordVC) as? ForgotPasswordViewController
        {
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    //MARK:- Custom methods
    
    func animateToKeyboardHeight(_ kbHeight: CGFloat, duration: Double) {
        if kbHeight > 0 {
            tblViewBottomConstraint.constant = kbHeight
        }
        if kbHeight == 0 {
            tblViewBottomConstraint.constant = 0
        }
    }
    
    /// This function is used to get the user name entered by user
    ///
    /// - Returns: User name as string
    func getUserName()->String {
        let userNameCell = self.tblViewLogin.cellForRow(at: IndexPath(row: 1, section: 0)) as! LoginCredentialsTableViewCell
        
        let LoginNameArr =  userNameCell.textField.text?.components(separatedBy: "|")
        // let size = LoginNameArr?.count
        var requiredLoginType = userNameCell.textField.text
        
        if LoginNameArr?.count ?? 0 > 1
        {
            // requiredLoginType = LoginNameArr![1]
            requiredLoginType = LoginNameArr![2] //Changed due to the change in the login credentials from backend.
            return requiredLoginType!
        }
        else
        {
            return requiredLoginType!
        }
    }
}

//MARK: - LoginButtonDelegate
extension LoginViewController {
    
    func buttonClicked() {
        
        //Access user credentials cells:
        let passwordCell = self.tblViewLogin.cellForRow(at: IndexPath(row: 2, section: 0)) as! LoginCredentialsTableViewCell
        // return passwordCell.textField.text ?? ""
        let userNameCell = self.tblViewLogin.cellForRow(at: IndexPath(row: 1, section: 0)) as! LoginCredentialsTableViewCell
        
        //Validations:
        guard let username = userNameCell.textField.text, username != ""  else {
            AlertManager.shared.showAlertWith(title: Constants.Alert.title, message: Constants.Alert.blankUserName)
            return
        }
        guard let password = passwordCell.textField.text, password != ""  else {
            AlertManager.shared.showAlertWith(title: Constants.Alert.title, message: Constants.Alert.blankPassword)
            return
        }
        
        ProgressLoader.shared.showLoader(withText: Constants.Alert.loaderLoginText)
        
        /* /****** Earlier method to get selected login type **********/
         //Get the required selected Login Type:
         self.selectedLogin = self.getUserName()
         UserDefaults.standard.set(self.selectedLogin, forKey: Constants.ServerKey.selectedLogin)
         /****** Earlier method to get selectec login type **********/ */
        
        WebServices.shared.loginUserWith(username: username, password: password, completion: {(response, error ) in
            
            if error == nil, let responseDict = response
            {
                print("Login Response: \(responseDict)")
                
                if(responseDict[Constants.ServerKey.Login.dataCount] == 1)
                {
                    print(responseDict[Constants.ServerKey.Login.value] [0][Constants.ServerKey.Login.registration_value])
                    
                    let sisName = responseDict[Constants.ServerKey.Login.value][0][Constants.ServerKey.Login.name].stringValue
                    
                    UserDefaults.standard.set(sisName, forKey: Constants.ServerKey.Login.name)
                    
                    let loginmasterID = responseDict[Constants.ServerKey.Login.value][0][Constants.ServerKey.Login.loginmasterID].stringValue
                    UserDefaults.standard.set(loginmasterID, forKey: Constants.ServerKey.Login.loginmasterID)
                    print("Login Master ID: \(loginmasterID)")
                    
                   
                    
                    let userID = responseDict[Constants.ServerKey.Login.value][0][Constants.ServerKey.Login.userID].stringValue
                    UserDefaults.standard.set(userID, forKey: Constants.ServerKey.Login.userID)
                    
                    let loginRole = responseDict[Constants.ServerKey.Login.value] [0][Constants.ServerKey.Login.new_rolecode].stringValue
                    print("Login Role: \(loginRole)")
                    
                    /****** New approach to get selected login type ********/
                    //Get the required selected Login Type:
                    self.selectedLogin = loginRole
                    UserDefaults.standard.set(self.selectedLogin, forKey: Constants.ServerKey.selectedLogin)
                    print("Selected Login Type: \(self.selectedLogin)")
                    
                    let regId = responseDict[Constants.ServerKey.Login.value] [0][Constants.ServerKey.Login.registration_value].stringValue
                    print("Reg. ID: \(regId)")
                    
                    ProgressLoader.shared.hideLoader()
                    
                    UserDefaults.standard.set(regId, forKey: Constants.ServerKey.Login.registration_value)
                    UserDefaults.standard.set(loginRole, forKey: Constants.ServerKey.Login.new_rolecode)
                    
                    if(loginRole == "1") //Student Role
                    {
                        if let vc = UIStoryboard(name: Constants.Storybaord.MainStoryboard, bundle: nil).instantiateViewController(withIdentifier: Constants.Storybaord.Identifier.myNavi) as? MyNavigationController
                        {
                            self.present(vc, animated: true, completion: nil)
                        }
                    }
                    else if(loginRole == "2") //Teacher Role
                    {
                        if let vc = UIStoryboard(name: Constants.Storybaord.MainStoryboard, bundle: nil).instantiateViewController(withIdentifier: Constants.Storybaord.Identifier.teacherNavi) as? TeacherNavigationController
                        {
                            self.present(vc, animated: true, completion: nil)
                        }
                        
                    }
                    else if(loginRole == "3") //Parent Role
                    {
                        if let vc = UIStoryboard(name: Constants.Storybaord.MainStoryboard, bundle: nil).instantiateViewController(withIdentifier: Constants.Storybaord.Identifier.parentNavi) as? ParentViewController
                        {
                            self.present(vc, animated: true, completion: nil)
                        }
                    }
                }
                else
                {
                    ProgressLoader.shared.hideLoader()
                    AlertManager.shared.showAlertWith(title: Constants.Alert.loginFailed, message: Constants.Alert.checkUsernamePassword)
                }
            }
            else
            {
                ProgressLoader.shared.hideLoader()
                AlertManager.shared.showAlertWith(title: Constants.Alert.errorOccured, message: Constants.Alert.tryAfterSomeTime)
            }
        })
    }
    
}

// MARK:- UITableView Delegates

extension LoginViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 300
            
        case 1,2:
            return 70
            
        case 3:
            return 50
            
        case 4:
            return 100
            
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
            let cellUsername = tableView.dequeueReusableCell(withIdentifier: Constants.Nib.ReusableIdentifier.loginCredentialsTableViewCell) as! LoginCredentialsTableViewCell
            cellUsername.backgroundColor = UIColor.clear
            cellUsername.textField.placeholder = Constants.PlaceholderText.enterUsername
            //cellUsername.textField.text = "SISK12|S|1819|1173"//LoginUserType.PARENT.rawValue //Change username here
            cellUsername.selectionStyle = .none
            //cellUsername.imgView.image = UIImage(named: "ic_user.png")
            cellUsername.imageView?.image = UIImage(named:"ic_user.png")!.withRenderingMode(.alwaysTemplate)
            //UIImage(named: arrMenuImages[indexPath.row])
            cellUsername.imageView?.tintColor = UIColor.init(red: 44.0/255.0, green: 154.0/255.0, blue: 243.0/255.0, alpha: 1.0)
            return cellUsername
            
        case 2:
            let cellPassword = tableView.dequeueReusableCell(withIdentifier: Constants.Nib.ReusableIdentifier.loginCredentialsTableViewCell) as! LoginCredentialsTableViewCell
            cellPassword.backgroundColor = UIColor.clear
            cellPassword.textField.placeholder = Constants.PlaceholderText.enterPassword
            //cellPassword.textField.text = "apar@1234" //Change password here
            cellPassword.textField.isSecureTextEntry = true
            cellPassword.selectionStyle = .none
            //cellPassword.imgView.image = UIImage(named: "ic_lock.png")
            cellPassword.imageView?.image = UIImage(named:"ic_lock.png")!.withRenderingMode(.alwaysTemplate)
            //UIImage(named: arrMenuImages[indexPath.row])
            cellPassword.imageView?.tintColor = UIColor.init(red: 44.0/255.0, green: 154.0/255.0, blue: 243.0/255.0, alpha: 1.0)
            return cellPassword
            
        case 3:
            let cellForgotPwd = tableView.dequeueReusableCell(withIdentifier: Constants.Nib.ReusableIdentifier.forgotPasswordTableViewCell) as! ForgotPasswordTableViewCell
            cellForgotPwd.backgroundColor = UIColor.clear
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.goToForgotPwdScreen))
            cellForgotPwd.lblForgotPassword.addGestureRecognizer(tapGesture)
            
            let tapgestureRememberMe = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.rememberMeClicked))
            cellForgotPwd.lblRememberMe.addGestureRecognizer(tapgestureRememberMe)
            cellForgotPwd.btnRememberMe.addTarget(self, action: #selector(LoginViewController.rememberMeClicked), for: .touchUpInside)
            cellForgotPwd.selectionStyle = .none
            
            if btnRememberTick == nil {
                btnRememberTick = cellForgotPwd.btnRememberMe
            }
            return cellForgotPwd
            
        case 4:
            let cellLoginBtn = tableView.dequeueReusableCell(withIdentifier: Constants.Nib.ReusableIdentifier.buttonWithBgTableViewCell) as! ButtonWithBgTableViewCell
            cellLoginBtn.backgroundColor = UIColor.clear
            cellLoginBtn.delegate = self
            cellLoginBtn.btnInCell.setTitle("Login", for: .normal)
            cellLoginBtn.selectionStyle = .none
            return cellLoginBtn
            
            
        default:
            return UITableViewCell()
        }
    }
}
