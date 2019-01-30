//
//  UserDefaults.swift
//  EliteSISSwift
//
//  Created by Neeraj Shukla on 19/11/18.
//  Copyright © 2018 Neeraj Shukla. All rights reserved.
//

import UIKit
import Foundation

class UserDefaultsManager: NSObject {
    
    static let sharedInstance = UserDefaultsManager()
    
    var isLoggedIn:Bool {
        get {
            if kUserDefaults.value(forKey: Constants.UserDefaultsKey.isLoggedIn) != nil {
                return kUserDefaults.value(forKey: Constants.UserDefaultsKey.isLoggedIn) as! Bool
            }
            //Default is not logged in
            return false
        }
        set {
            kUserDefaults.setValue(newValue, forKey: Constants.UserDefaultsKey.isLoggedIn)
            kUserDefaults.synchronize()
        }
    }
    
    var accessToken:String {
        get {
            if kUserDefaults.value(forKey: Constants.UserDefaultsKey.accessToken) != nil {
                return kUserDefaults.value(forKey: Constants.UserDefaultsKey.accessToken) as! String
            }
            return ""
        }
        set {
            kUserDefaults.setValue(newValue, forKey: Constants.UserDefaultsKey.accessToken)
            kUserDefaults.synchronize()
        }
    }
    
    func clearCache() {
        UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        kUserDefaults.synchronize()
    }
    
    var schoolID:String {
        get {
            if kUserDefaults.value(forKey: Constants.UserDefaultsKey.schoolID) != nil {
                return kUserDefaults.value(forKey: Constants.UserDefaultsKey.schoolID) as! String
            }
            return ""
        }
        set {
            kUserDefaults.setValue(newValue, forKey: Constants.UserDefaultsKey.schoolID)
            kUserDefaults.synchronize()
        }
    }
}
