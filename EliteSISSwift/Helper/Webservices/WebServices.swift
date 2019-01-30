//
//  WebServices.swift
//  EliteSISSwift
//
//  Created by Vivek on 12/08/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import SwiftHash
import Alamofire
import SwiftyJSON

class WebServices: NSObject {
    
    static var shared = WebServices()
    
    //MARK: Login API:
    func loginUserWith(username: String, password: String, completion: @escaping (_ success: JSON?, _ error: Error? ) -> Void )
    {
        //Encode the password:
        let md5EncodedPassword = MD5(password)
        //Login URL:
        // let requestURL = Constants.BASE_URL + "SIS_Student/Login/" + username + "/" + md5EncodedPassword + "/MBLE_APP_00001" //Change the School ID as dynamic by fetching it from the persistent storage.
        let requestURL = Constants.BASE_URL + Constants.API.login + username + "/" + md5EncodedPassword + "/" + Constants.SchoolID
        print("Login URL: \(requestURL)")
        
        //Encode the URL:
        let encodedURL = requestURL.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
        
        Alamofire.request(encodedURL!).responseJSON { (responseData) -> Void in
            
            if let result = responseData.result.value
            {
                let responseDict = JSON(result)
                debugPrint(responseDict)
                completion(responseDict, nil)
            }
            else
            {
                completion(nil, responseData.error)
            }
        }
    }
    
    //MARK: Get Profile API:
    func getProfile(forRegistrationID rID: String, completion: @escaping (_ success: JSON?, _ error: Error? ) -> Void )
    {
        // let requestURL = Constants.BASE_URL + "SIS_Student/GetProfile/" + rID + "/MBLE_APP_00001"
        let requestURL = Constants.BASE_URL + Constants.API.getProfile + rID + "/" + Constants.SchoolID
        //        let encodedURL = stringLoginCall.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
        
        print("Profile URL: \(requestURL)")
        
        Alamofire.request(requestURL).responseJSON { (responseData) -> Void in
            
            if let result = responseData.result.value
            {
                let responseDict = JSON(result)
                debugPrint(responseDict)
                completion(responseDict, nil)
            }
            else
            {
                completion(nil, responseData.error)
            }
        }
    }
    
    //MARK: Get Performance List for Student Login Role:
    func getPerformanceListForStudentLoginRole(StudentID: String, SessionID: String, SectionID: String, completion: @escaping (_ success: JSON?, _ error: Error? ) -> Void )
    {
        let requestURL = Constants.BASE_URL + Constants.API.getPerformanceListForStudentLoginRole + StudentID + "/" + SessionID + "/" + SectionID + "/" + Constants.SchoolID
        
        print("Get Performance List For Student Login Role URL: \(requestURL)")
        
        Alamofire.request(requestURL).responseJSON { (responseData) -> Void in
            
            if let result = responseData.result.value
            {
                let responseDict = JSON(result)
                debugPrint(responseDict)
                completion(responseDict, nil)
            }
            else
            {
                completion(nil, responseData.error)
            }
        }
    }
    
    //MARK: Get Dashboard API:
    func getDashboardDetailsFor(classSession: String, studentId: String, completion: @escaping (_ success: JSON?, _ error: Error? ) -> Void )
    {
        //let requestURL = Constants.BASE_URL + "SIS_Student/GetDashboardData/" + classSession + "/" + studentId + "/MBLE_APP_00001"
        let requestURL = Constants.BASE_URL + Constants.API.getDashboardDetails + classSession + "/" + studentId + "/" + Constants.SchoolID
        print("Dashboard URL: \(requestURL)")
        
        Alamofire.request(requestURL).responseJSON { (responseData) -> Void in
            if let result = responseData.result.value
            {
                let responseDict = JSON(result)
                debugPrint(responseDict)
                completion(responseDict, nil)
            }
            else
            {
                completion(nil, responseData.error)
            }
        }
    }
    
    //MARK: Menu List Items API:
    func MenuListItem(role: String, completion: @escaping (_ success: JSON?, _ error:Error? ) -> Void )
    {
        //let requestURL = Constants.BASE_URL + "SIS/GetConfigurations/" + role + "/MBLE_APP_00001"
        let requestURL = Constants.BASE_URL + Constants.API.getMenuListItems + role + "/" + Constants.SchoolID
        print("Menu List URL: \(requestURL)")
        
        let encodedURL = requestURL.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
        
        Alamofire.request(encodedURL!).responseJSON { (responseData) -> Void in
            if let result = responseData.result.value
            {
                let responseDict = JSON(result)
                debugPrint(responseDict)
                completion(responseDict, nil)
            }
            else
            {
                completion(nil, responseData.error)
            }
        }
    }
    
    //MARK: Choose Teacher for Discussion API:
    func ChooseTeacherForDiscussion(classSession: String, completion: @escaping (_ success: JSON?, _ error:Error? ) -> Void )
    {
        //let requestURL = Constants.BASE_URL + "SIS_Student/GetLessonPlan/" + classSession + "/MBLE_APP_00001"
        let requestURL = Constants.BASE_URL + Constants.API.chooseTeacherDiscussion + classSession + "/" + Constants.SchoolID
        print("Choose Teacher Dicussion URL: \(requestURL)")
        
        let encodedURL = requestURL.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        
        Alamofire.request(encodedURL!).responseJSON { (responseData) -> Void in
            if let result = responseData.result.value
            {
                let responseDict = JSON(result)
                debugPrint(responseDict)
                completion(responseDict, nil)
            }
            else
            {
                completion(nil, responseData.error)
            }
        }
    }
    
    //MARK: Show Holiday List API:
    func showHolidayList(completion: @escaping (_ success: JSON?, _ error:Error? ) -> Void )
    {
        //let requestURL = Constants.BASE_URL + "SIS_Student/Holidays/MBLE_APP_00001"
        let requestURL = Constants.BASE_URL + Constants.API.getHolidayList + Constants.SchoolID
        print("Holiday List URL: \(requestURL)")
        
        let encodedURL = requestURL.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
        
        Alamofire.request(encodedURL!).responseJSON { (responseData) -> Void in
            if let result = responseData.result.value
            {
                let responseDict = JSON(result)
                debugPrint(responseDict)
                completion(responseDict, nil)
            }
            else
            {
                completion(nil, responseData.error)
            }
        }
    }
    
    //MARK: Show Assignment API:
    func showAssignmentList(studentID: String, completion: @escaping (_ success: JSON?, _ error:Error? ) -> Void )
    {
        // let requestURL = Constants.BASE_URL + "SIS_Student/GetAssignmentList/" + studentID + "/MBLE_APP_00001"
        let requestURL = Constants.BASE_URL + Constants.API.getAssignmentList + studentID + "/" + Constants.SchoolID
        print("Assignment List URL: \(requestURL)")
        
        let encodedURL = requestURL.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
        
        Alamofire.request(encodedURL!).responseJSON { (responseData) -> Void in
            
            if let result = responseData.result.value
            {
                let responseDict = JSON(result)
                debugPrint(responseDict)
                completion(responseDict, nil)
            }
            else
            {
                completion(nil, responseData.error)
            }
        }
    }
    
    
    //MARK: Change Password API:
    /*  func changePassword(loginmasterID: String, payloadData: JSON, completion: @escaping (_ success: JSON?, _ error: Error? ) -> Void )
     {
     let requestURL = Constants.BASE_URL + Constants.API.changePassword + loginmasterID + "/" + Constants.accessNumberForChangePassword + "/" + Constants.SchoolID
     print("Change Password URL: \(requestURL)")
     //Convert payloadData to Data form:
     let payloadData = Data(payloadData)
     // Alamofire.request(requestURL).responseJSON { (responseData) -> Void in
     Alamofire.upload(payloadData, to: requestURL).responseJSON { (responseData) -> Void in
     if let result = responseData.result.value
     {
     let responseDict = JSON(result)
     debugPrint(responseDict)
     completion(responseDict, nil)
     }
     else
     {
     completion(nil, responseData.error)
     }
     }
     } */
    
    
    //MARK: Change Password API:
    /* func changePassword(loginmasterID: String, payloadData: String, completion: @escaping (_ success: JSON?, _ error: Error? ) -> Void )
     {
     let requestURL = Constants.BASE_URL + Constants.API.changePassword + loginmasterID + "/" + Constants.accessNumberForChangePassword + "/" + Constants.SchoolID
     print("Change Password URL: \(requestURL)")
     //Convert payloadData to Data form:
     //let payloadData = Data(payloadData)
     /* Alamofire.request(requestURL).responseJSON { (responseData) -> Void in
     if let result = responseData.result.value
     {
     let responseDict = JSON(result)
     debugPrint(responseDict)
     completion(responseDict, nil)
     }
     else
     {
     completion(nil, responseData.error)
     }
     } */
     
     /* Alamofire.request(.POST, "http://myserver.com", parameters: nil, encoding: URLEncoding.default)
     .responseJSON { request, response, JSON, error in
     print(response)
     print(JSON)
     print(error)
     } */
     
     Alamofire.request(requestURL, method: .post, parameters: payloadData, encoding: URLEncoding.default, headers: nil).responseJSON { response in
     if let result = response.result.value
     {
     let responseDict = JSON(result)
     debugPrint(responseDict)
     completion(responseDict, nil)
     }
     else
     {
     completion(nil, response.error)
     }
     }
     
     }*/
    
    /*  func changePassword(loginmasterID: String, payloadData: NSMutableDictionary, completion: @escaping (_ success: JSON?, _ error: Error? ) -> Void )
     {
     let requestURL = Constants.BASE_URL + Constants.API.changePassword + loginmasterID + "/" + Constants.accessNumberForChangePassword + "/" + Constants.SchoolID
     print("Change Password URL: \(requestURL)")
     
     let url = URL(string: requestURL)!
     var request = URLRequest(url: url)
     request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
     request.httpMethod = "POST"
     let postString = "sis_oldpassword=\(String(describing: payloadData.value(forKey: "sis_oldpassword")))&sis_changepassword=\(String(describing: payloadData.value(forKey: "sis_changepassword")))" // which is your parameters
     request.httpBody = postString.data(using: .utf8)
     
     
     // Getting response for POST Method
     DispatchQueue.main.async {
     let task = URLSession.shared.dataTask(with: request) { data, response, error in
     guard let data = data, error == nil else {
     return // check for fundamental networking error
     }
     
     
     // Getting values from JSON Response
     let responseString = String(data: data, encoding: .utf8)
     print("responseString = \(String(describing: responseString))")
     do {
     let jsonResponse = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions()) as? NSDictionary
     }catch _ {
     print ("OOps not good JSON formatted response")
     }
     }
     task.resume()
     }
     } */
    
    //MARK: Forgot Password API:
    func forgotPassword(username: String, mobile: String, completion: @escaping (_ success: JSON?, _ error: Error? ) -> Void )
    {
        let requestURL = Constants.BASE_URL + Constants.API.forgotPassword + "\(username)/" + "\(mobile)/" + Constants.SchoolID
        print("Forgot Password URL: \(requestURL)")
        
        let r =   Alamofire.request(requestURL).responseJSON { (responseData) -> Void in
            
            print(responseData.result.value)
            
            if let result = responseData.result.value
            {
                let responseDict = JSON(result)
                debugPrint(responseDict)
                completion(responseDict, nil)
            }
            else
            {
                completion(nil, responseData.error)
            }
        }
        debugPrint(request)
    }
}


class ActivitiesGetService {
    static func executeRequest (username: String, mobile: String,completionHandler: @escaping (JSON?, NSError?) -> Void) {
        
        let startString =  Constants.BASE_URL + Constants.API.forgotPassword + "\(username)/" + "\(mobile)/" + Constants.SchoolID
        let allowedCharacterSet = NSCharacterSet.urlQueryAllowed
        let URLString = startString.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet)
        
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 60
        
        let request = manager.request( URLString!, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            
            print(response.result.value)
            switch response.result {
            case .success(let value) :
                
                if let result = response.result.value
                {
                    let responseDict = JSON(result)
                    completionHandler(responseDict,nil)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        debugPrint(request)
    }
    
    static func executeRequestForRegistration (registrationId: String, parmeter: Parameters,completionHandler: @escaping (JSON?, NSError?) -> Void) {
        
        let startString =  Constants.BASE_URL + Constants.API.changePassword + "\(registrationId)/" + "\(Constants.accessNumberForForgotPassword)/" + Constants.SchoolID
        
        
        //        let startString = "http://upload.wikimedia.org/wikipedia/commons/a/a9/Rösti_mit_Bratwurst.jpg"
        let allowedCharacterSet = NSCharacterSet.urlQueryAllowed
        let URLString = startString.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet)
        
        //        stringByAddingPercentEncodingWithAllowedCharacters(allowedCharacterSet) ?? startString
        
        
        
        print(URLString)
        
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 60
        
        let request = manager.request( URLString!, method: .post, parameters: parmeter, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            
            print(response.result.value)
            switch response.result {
            case .success(let value) :
                
                if let result = response.result.value
                {
                    let responseDict = JSON(result)
                    completionHandler(responseDict,nil)
                }
                
                //                let json = value as! JSON
                //
                
            case .failure(let error):
                print(error.localizedDescription)
                completionHandler(nil, error as! NSError)
            }
        }
        debugPrint(request)
    }
    
    static func executeRequestPostOTP (parmeter: Parameters,completionHandler: @escaping (JSON?, NSError?) -> Void) {
        
        let startString =  Constants.BASE_URL + Constants.API.postOTP + Constants.SchoolID
        
        let allowedCharacterSet = NSCharacterSet.urlQueryAllowed
        let URLString = startString.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet)
        
        print(URLString)
        
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 60
        
        let request = manager.request( URLString!, method: .post, parameters: parmeter, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            
            print(response.result.value)
            switch response.result {
            case .success(let value) :
                
                if let result = response.result.value
                {
                    let responseDict = JSON(result)
                    completionHandler(responseDict,nil)
                }
                
                //                let json = value as! JSON
                //
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        debugPrint(request)
    }
    
    
    //    http://104.211.88.67:5147/SIS_Student/CreateDiscussion/SchoolID
    
    static func executeRequestForPostDiscussion (parmeter: Parameters,completionHandler: @escaping (JSON?, NSError?) -> Void) {
        
        let startString =  Constants.BASE_URL + Constants.API.discussion + Constants.SchoolID
        
        
        //        let startString = "http://upload.wikimedia.org/wikipedia/commons/a/a9/Rösti_mit_Bratwurst.jpg"
        let allowedCharacterSet = NSCharacterSet.urlQueryAllowed
        let URLString = startString.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet)
        
        //        stringByAddingPercentEncodingWithAllowedCharacters(allowedCharacterSet) ?? startString
        
        
        //
        
        print(URLString)
        
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 60
        
        let request = manager.request( URLString!, method: .post, parameters: parmeter, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            
            print(response.result.value)
            switch response.result {
            case .success(let value) :
                
                if let result = response.result.value
                {
                    let responseDict = JSON(result)
                    completionHandler(responseDict,nil)
                }
                
                //                let json = value as! JSON
                //
                
            case .failure(let error):
                print(error.localizedDescription)
                completionHandler(nil, error as! NSError)
            }
        }
        debugPrint(request)
    }
    
    
}
