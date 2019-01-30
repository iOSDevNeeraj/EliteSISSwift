//
//  ForgotPasswordViewController.swift
//  EliteSISSwift
//
//  Created by Vivek Garg on 13/04/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import UIKit
import SwiftHash
import Alamofire

class ForgotPasswordViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, LoginButtonDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var tblView: UITableView!
    
    @IBOutlet weak var btnBack: UIButton!
    
    @IBOutlet weak var tblViewBottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        tblView.separatorStyle = .none
        // Do any additional setup after loading the view.
        tblView.register(UINib(nibName: Constants.Nib.NibIdentifier.logoTableViewCell, bundle:nil), forCellReuseIdentifier: Constants.Nib.ReusableIdentifier.logoTableViewCell)
        tblView.register(UINib(nibName: Constants.Nib.NibIdentifier.simpleLabelTableViewCell, bundle:nil), forCellReuseIdentifier: Constants.Nib.NibIdentifier.simpleLabelTableViewCell)
        tblView.register(UINib(nibName: Constants.Nib.NibIdentifier.buttonWithBgTableViewCell, bundle:nil), forCellReuseIdentifier: Constants.Nib.ReusableIdentifier.buttonWithBgTableViewCell)
        tblView.register(UINib(nibName: Constants.Nib.NibIdentifier.loginCredentialsTableViewCell, bundle:nil), forCellReuseIdentifier: Constants.Nib.ReusableIdentifier.loginCredentialsTableViewCell)
        tblView.register(UINib(nibName: Constants.Nib.NibIdentifier.loginCredentialsTableViewCell, bundle:nil), forCellReuseIdentifier: Constants.Nib.ReusableIdentifier.loginCredentialsTableViewCell)
        tblView.delegate = self
        tblView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(ForgotPasswordViewController.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ForgotPasswordViewController.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
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
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 280
            
        case 1:
            return UITableViewAutomaticDimension
            
        case 2:
            return 50
      
        case 3:
            return 50
            
        case 4:
            return 80
            
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cellLogo = tableView.dequeueReusableCell(withIdentifier: Constants.Nib.NibIdentifier.logoTableViewCell) as! LogoTableViewCell
            cellLogo.backgroundColor = UIColor.clear
            cellLogo.selectionStyle = .none
            return cellLogo
            
        case 1:
            let cellDesc = tableView.dequeueReusableCell(withIdentifier: Constants.Nib.NibIdentifier.simpleLabelTableViewCell) as! SimpleLabelTableViewCell
            cellDesc.lblContent.text = "Enter your mobile number and we will send you OTP to reset password."
            cellDesc.lblContent.font = UIFont.systemFont(ofSize: 15)
            cellDesc.backgroundColor = UIColor.clear
            cellDesc.selectionStyle = .none
            return cellDesc
            
        case 2:
            let cellUserTxtFld = tableView.dequeueReusableCell(withIdentifier: Constants.Nib.NibIdentifier.loginCredentialsTableViewCell) as! LoginCredentialsTableViewCell
            cellUserTxtFld.backgroundColor = UIColor.clear
            cellUserTxtFld.textField.placeholder = Constants.PlaceholderText.enterUsername
            cellUserTxtFld.textField.keyboardType = .numberPad
            cellUserTxtFld.selectionStyle = .none
            cellUserTxtFld.imageView?.image = UIImage(named:"ic_user.png")!.withRenderingMode(.alwaysTemplate)
            cellUserTxtFld.imageView?.tintColor = UIColor.init(red: 44.0/255.0, green: 154.0/255.0, blue: 243.0/255.0, alpha: 1.0)
            
            let numberToolbar = UIToolbar(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 50))
            numberToolbar.barStyle = .default
            
            numberToolbar.items = [
                UIBarButtonItem(title: Constants.done, style: .plain, target: self, action: #selector(ForgotPasswordViewController.closeKeyPad))
            ]
            numberToolbar.sizeToFit()
            cellUserTxtFld.textField.inputAccessoryView = numberToolbar
            
            return cellUserTxtFld
            
        case 3:
            let cellUserTxtFld = tableView.dequeueReusableCell(withIdentifier: Constants.Nib.NibIdentifier.loginCredentialsTableViewCell) as! LoginCredentialsTableViewCell
            cellUserTxtFld.backgroundColor = UIColor.clear
            cellUserTxtFld.textField.placeholder = Constants.PlaceholderText.mobilePlaceholder
            cellUserTxtFld.textField.keyboardType = .numberPad
            cellUserTxtFld.selectionStyle = .none
            cellUserTxtFld.imageView?.image = UIImage(named:"ic_user.png")!.withRenderingMode(.alwaysTemplate)
            cellUserTxtFld.imageView?.tintColor = UIColor.init(red: 44.0/255.0, green: 154.0/255.0, blue: 243.0/255.0, alpha: 1.0)
            
            let numberToolbar = UIToolbar(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 50))
            numberToolbar.barStyle = .default
            
            numberToolbar.items = [
                UIBarButtonItem(title: Constants.done, style: .plain, target: self, action: #selector(ForgotPasswordViewController.closeKeyPad))
            ]
            numberToolbar.sizeToFit()
            cellUserTxtFld.textField.inputAccessoryView = numberToolbar
            
            return cellUserTxtFld
            
        case 4:
            let cellLoginBtn = tableView.dequeueReusableCell(withIdentifier: Constants.Nib.NibIdentifier.buttonWithBgTableViewCell) as! ButtonWithBgTableViewCell
            cellLoginBtn.backgroundColor = UIColor.clear
            cellLoginBtn.delegate = self
            cellLoginBtn.btnInCell.setTitle(Constants.submit, for: .normal)
            
            cellLoginBtn.selectionStyle = .none
            return cellLoginBtn
            
        default:
            return UITableViewCell()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be
    }
    
    @IBAction func btnBackClicked() {
        self.view.endEditing(true)
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func closeKeyPad() {
        self.view.endEditing(true)
    }
    
    func buttonClicked() {
        let userNameCell = self.tblView.cellForRow(at: IndexPath(row: 2, section: 0)) as! LoginCredentialsTableViewCell
        let mobileCell = self.tblView.cellForRow(at: IndexPath(row: 3, section: 0)) as! LoginCredentialsTableViewCell
        print (mobileCell.textField.text!)
        print (userNameCell.textField.text!)
        
//        print(randomString(length: 8))
        
        let md5EncodedPassword = MD5("apar@1234")
        
        if validate(value: mobileCell.textField.text!) {
            
             ProgressLoader.shared.showLoader(withText: "Please wait...")
            
            ActivitiesGetService.executeRequest(username: userNameCell.textField.text!, mobile: mobileCell.textField.text!) { (json, error) in
                
                if let json = json {
                  
                let id = json["value"][0]["sis_registrationid"].stringValue
                print(id)
                   let payload: Parameters = [Constants.ServerKey.ChangePassword.oldPasswordKey: md5EncodedPassword, Constants.ServerKey.ChangePassword.changePasswordKey: true]
                    
                    ActivitiesGetService.executeRequestForRegistration(registrationId: id, parmeter: payload, completionHandler: { (json, error) in
                        print(json)
                    
                        
                        if let error = error {
                            
                            let payload: Parameters = [Constants.ServerKey.ChangePassword.subject: "Subject", Constants.ServerKey.ChangePassword.description: "Your OTP for your request to change password is apar@1234", Constants.ServerKey.ChangePassword.sisContactNo: "\(8416886776)"]
                            
                            ActivitiesGetService.executeRequestPostOTP(parmeter: payload, completionHandler: { (json, error) in
                                
                                print(json)
                                
                                
                                 if let json = json {
                                    
                                }
                                
                            })
                            
                        }
                            
                    })
                
                }
            }
            
//            testApi(username: userNameCell.textField.text!, mobile: mobileCell.textField.text!)
//            WebServices.shared.forgotPassword(username: userNameCell.textField.text!, mobile: mobileCell.textField.text!) { (json, error) in
//                print(json)
//            }
            let alert = UIAlertController(title: Constants.success, message: Constants.Alert.otpSentMsg, preferredStyle: .alert)
            //let dismiss = UIAlertAction(title: "OK", style: .cancel, handler: nil)

            let okAction = UIAlertAction(title: Constants.ok, style: UIAlertActionStyle.default)
            {
                UIAlertAction in
                self.dismiss(animated: true, completion: nil)
            }
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
        else {
            print("Invalid Number")
            let alert = UIAlertController(title: Constants.Alert.error, message: Constants.Alert.invalidMobileNumberMsg, preferredStyle: .alert)
            let dismiss = UIAlertAction(title: Constants.ok, style: .cancel, handler: nil)
            alert.addAction(dismiss)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func validate(value: String) -> Bool {
        let PHONE_REGEX = "[0-9]{10}"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@",PHONE_REGEX)
        let result =  phoneTest.evaluate(with: value)
        return result
    }
    
    func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0...length-1).map{ _ in letters.randomElement()! })
    }
    
//    func testApi(username: String, mobile: String) {
//
////        let token = LoginUtils.getCurrentUserToken()!
//
////        let header: HTTPHeaders = [
//////            "Authorization": "Bearer \(token)",
////            "Content-Type": "application/json"
////        ]
//
//    let requestURL = Constants.BASE_URL + Constants.API.forgotPassword + "\(username)/" + "\(mobile)/" + Constants.SchoolID
//
//        print(requestURL)
//
//        let manager = Alamofire.SessionManager.default
//        manager.session.configuration.timeoutIntervalForRequest = 60
//
//
//        let r = manager.request( requestURL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
//
//            print(response.result.value)
//            switch response.result {
//            case .success(let value) :
//                break
////                let json = value as! JSON
////                completionHandler(json,nil)
//
//            case .failure(let error):
//                break
////                Utilities.hideLoader()
////                Alert.showAlertWithMessage(Controller: vc, title: Constants.appName, message: error.localizedDescription)
//
//            }
//
//        }
//
//    }
}
