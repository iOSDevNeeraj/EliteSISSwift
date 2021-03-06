//
//  ForgotPasswordTableViewCell.swift
//  EliteSISSwift
//
//  Created by Vivek Garg on 19/02/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import UIKit

class ForgotPasswordTableViewCell: UITableViewCell {

    @IBOutlet weak var btnRememberMe: UIButton!
    @IBOutlet weak var lblRememberMe: UILabel!
    @IBOutlet weak var lblForgotPassword: UILabel!
    var isRememberSelected:Bool = false
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
        btnRememberMe.layer.borderWidth = 1
        btnRememberMe.layer.borderColor = UIColor.black.cgColor
        lblForgotPassword.text = "Forgot password?"
        lblRememberMe.text = "Remember me"
        lblForgotPassword.isUserInteractionEnabled = true
        lblRememberMe.isUserInteractionEnabled = true
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ForgotPasswordTableViewCell.rememberMeClicked))
//        lblRememberMe.isUserInteractionEnabled = true
     //  btnRememberMe.addTarget(self, action: #selector(ForgotPasswordTableViewCell.rememberMeClicked), for: .touchUpInside)
//        lblRememberMe.addGestureRecognizer(tapGesture)
    }
    
  /*  @objc func rememberMeClicked(sender: UIButton)
    {
        //Access user credentials cells:
        let passwordCell2 = self.tblViewLogin.cellForRow(at: IndexPath(row: 2, section: 0)) as! LoginCredentialsTableViewCell
        let userNameCell2 = self.tblViewLogin.cellForRow(at: IndexPath(row: 1, section: 0)) as! LoginCredentialsTableViewCell
        
        if  isRememberSelected == true
        {
            isRememberSelected = false
            btnRememberMe.setImage(nil, for: .normal)
            
            kUserDefaults.set(true, forKey: Constants.RememberMeKey.rememberMe)
            kUserDefaults.set(userNameCell2.textField.text, forKey: Constants.RememberMeKey.savedUserName)
            kUserDefaults.set(passwordCell2.textField.text, forKey: Constants.RememberMeKey.savedPassword)
        }
        else
        {
            isRememberSelected = true
            btnRememberMe.setImage(UIImage(named:"ic_done"), for: .normal)
            
            kUserDefaults.set(false, forKey: Constants.RememberMeKey.rememberMe)
        }
        
        //        bRec = !bRec
        //        if bRec {
        //            btnRememberTick.setImage(UIImage(named: "ic_done"), for: .normal)
        //        } else {
        //            btnRememberTick.setImage(nil, for: .normal)
        //        }
    } */
    
   override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
