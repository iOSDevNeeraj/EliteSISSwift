//
//  MyMenuTableViewController.swift
//  SwiftSideMenu
//
//  Created by Evgeny Nazarov on 29.09.14.
//  Copyright (c) 2014 Evgeny Nazarov. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import ALLoadingView

class MyMenuTableViewController: UITableViewController {
    
    //VAriables
    var selectedMenuItem : Int = 0
    var arrMenuValues = [String]()
    var sideMenuItems = [String]()
    var arrMenuImages = [String]()
    var selectedLogin = UserDefaults.standard.string(forKey: Constants.ServerKey.selectedLogin)
    var arrUserProfile = [String:String]()
    var classNameValue:String = ""
    
    // MARK:- View's Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = nil
        tableView.dataSource = nil
        
        if (!(arrUserProfile.count > 0))
        {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0)
            {
                //                            self.callForUserProfileData()
                self.MenuListItems()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        // if (selectedLogin == "S") //For Student
        if (selectedLogin == "1") //For Student
        {
            let viewHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: Constants.Nib.NibIdentifier.menuStudentInfoHeaderView) as! MenuStudentInfoHeaderView
            viewHeader.contentView.backgroundColor = UIColor.init(red: 44.0/255.0, green: 154.0/255.0, blue: 243.0/255.0, alpha: 1.0) //44 154 243
            
            viewHeader.lblClass.text = "Class: " + self.classNameValue
            
            if let userID = UserDefaults.standard.string(forKey: "sis_user_id") {
                viewHeader.lblId.text = "ID: " + userID
            }
            if let fatherName = UserDefaults.standard.string(forKey: "sis_fathername") {
                viewHeader.lblParentName.text = "Parent Name: Mr. " + fatherName
            }
            if let sisName = UserDefaults.standard.string(forKey: "sis_name") {
                viewHeader.lblStudentName.text = "Student Name: " + sisName
            }
            
            return viewHeader
        }
            //else if (selectedLogin == "E") //For Teacher
        else if (selectedLogin == "2") //For Teacher
        {
            let viewHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: Constants.Nib.NibIdentifier.menuTeacherInfoHeaderView) as! MenuTeacherInfoHeaderView
            // let FacultyName = UserDefaults.standard.string(forKey: "FacultyName")!
            viewHeader.lblName.text = UserDefaults.standard.string(forKey: "FacultyName")!
            viewHeader.contentView.backgroundColor = UIColor.init(red: 44.0/255.0, green: 154.0/255.0, blue: 243.0/255.0, alpha: 1.0) //44 154 243
            /*
             print(self.arrUserProfile)
             //  viewHeader.lblName.text = self.arrUserProfile ["ApplicantFullName"]!
             let strClassName = self.arrUserProfile["className"]!
             let strSection = self.arrUserProfile["Section"]!
             
             viewHeader.lblMotherClass.text = " Mother teacher of - " + strClassName + " (" + strSection + ")"
             
             let decodedData = NSData(base64Encoded: self.arrUserProfile["Entityimage"]!, options: NSData.Base64DecodingOptions(rawValue: 0) )
             
             let decodedimage = UIImage(data: decodedData! as Data)
             
             viewHeader.imgView.image = decodedimage
             viewHeader.imgView.layer.cornerRadius = viewHeader.imgView.frame.size.width/2
             viewHeader.imgView.clipsToBounds = true
             //   */
            return viewHeader
        }
        else //For Parent
        {
            let viewHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: Constants.Nib.NibIdentifier.menuParentInfoHeaderView) as! MenuParentInfoHeaderView
            viewHeader.contentView.backgroundColor = UIColor.init(red: 44.0/255.0, green: 154.0/255.0, blue: 243.0/255.0, alpha: 1.0) //44 154 243
            return viewHeader
        }
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        //if (selectedLogin == "G")
        if (selectedLogin == "3") //Parent
        {
            return 70
        }
        else
        {
            return 100
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        // Return the number of rows in the section.
        return sideMenuItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var cell = tableView.dequeueReusableCell(withIdentifier: "CELL")
        
        if (cell == nil)
        {
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "CELL")
            cell!.backgroundColor = UIColor.clear
            cell!.textLabel?.textColor = UIColor.init(red: 44.0/255.0, green: 154.0/255.0, blue: 243.0/255.0, alpha: 1.0)///44 154 243blue
            let selectedBackgroundView = UIView(frame: CGRect(x: 0, y: 0, width: cell!.frame.size.width, height: cell!.frame.size.height))
            selectedBackgroundView.backgroundColor = UIColor.gray.withAlphaComponent(0.2)
            cell!.selectedBackgroundView = selectedBackgroundView
            
        }
        //        let theImageView = UIImageView(image: UIImage(named:"progress.png")!.withRenderingMode(.alwaysTemplate))
        //        theImageView.tintColor = UIColor.blue
        //
        cell?.imageView?.image = UIImage(named:(arrMenuImages[indexPath.row]))!.withRenderingMode(.alwaysTemplate)
        //UIImage(named: arrMenuImages[indexPath.row])
        cell?.imageView?.tintColor = UIColor.init(red: 44.0/255.0, green: 154.0/255.0, blue: 243.0/255.0, alpha: 1.0)
        cell!.textLabel?.text = sideMenuItems[indexPath.row] //"ViewController #\(indexPath.row+1)"
        return cell!
        
        //        switch indexPath.row {
        //        case 0:
        //            let cell = tableView.dequeueReusableCell(withIdentifier: "MenuHeadingTableViewCell") as! MenuHeadingTableViewCell
        //            return cell
        //        default:
        //            var cell = tableView.dequeueReusableCell(withIdentifier: "CELL")
        //
        //            if (cell == nil) {
        //                cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "CELL")
        //                cell!.backgroundColor = UIColor.clear
        //                cell!.textLabel?.textColor = UIColor.darkGray
        //                let selectedBackgroundView = UIView(frame: CGRect(x: 0, y: 0, width: cell!.frame.size.width, height: cell!.frame.size.height))
        //                selectedBackgroundView.backgroundColor = UIColor.gray.withAlphaComponent(0.2)
        //                cell!.selectedBackgroundView = selectedBackgroundView
        //            }
        //
        //            cell!.textLabel?.text = "ViewController #\(indexPath.row+1)"
        //
        //            return cell!
        //        }
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        print("did select row: \(indexPath.row)")
        
        if (indexPath.row == selectedMenuItem)
        {
            //return
        }
        selectedMenuItem = indexPath.row
        //Present new view controller
        
        // if (selectedLogin == "S") //Student
        if (selectedLogin == "1") //Student
        {
            if (indexPath.row == 14) //15>14 //This indexing totally depends upon the APIs, if the indexing for the items is changed or else if the items are less or more than current no. of items, then this index may shift according to the new menu items.
            {
                hideSideMenuView()
                let alert = UIAlertController(title: Constants.Logout.logout, message: Constants.Logout.logoutMsg, preferredStyle: UIAlertControllerStyle.alert)
                // add the actions (buttons)
                alert.addAction(UIAlertAction(title: Constants.cancel, style: UIAlertActionStyle.default, handler: nil))
                alert.addAction(UIAlertAction(title: Constants.ok, style: UIAlertActionStyle.destructive, handler: { action in
                    
                    UserDefaults.standard.removeObject(forKey: Constants.ServerKey.Login.loginmasterID)
                    let mainStoryboard: UIStoryboard = UIStoryboard(name: Constants.Storybaord.MainStoryboard,bundle: nil)
                    var destViewController : UIViewController
                    destViewController = mainStoryboard.instantiateViewController(withIdentifier: Constants.Storybaord.Identifier.loginviewcontroller)
                    self.sideMenuController()?.setContentViewController(destViewController)
                }))
                
                // show the alert
                self.present(alert, animated: true, completion: nil)
            }
            else
            {
                let mainStoryboard: UIStoryboard = UIStoryboard(name: Constants.Storybaord.MainStoryboard,bundle: nil)
                var destViewController : UIViewController
                
                switch (indexPath.row)
                {
                case 0: //Dashboard
                    destViewController = mainStoryboard.instantiateViewController(withIdentifier: Constants.Storybaord.Identifier.dashboard)
                    break
                    
                case 1: //Pinboard
                    destViewController = mainStoryboard.instantiateViewController(withIdentifier: Constants.Storybaord.Identifier.pinboardViewController)
                    break
                    
                case 2: //Discussion : Redirect to teacher chat VC // change here from parent chat to teacher chat
                    //destViewController = mainStoryboard.instantiateViewController(withIdentifier: Constants.Storybaord.Identifier.parentChatViewController)
                    destViewController = mainStoryboard.instantiateViewController(withIdentifier: Constants.Storybaord.Identifier.teacherChatViewController)
                    break
                    
                case 3: //Notification
                    destViewController = mainStoryboard.instantiateViewController(withIdentifier: Constants.Storybaord.Identifier.notificationViewController)
                    break
                    
                case 4: //Time Table
                    destViewController = mainStoryboard.instantiateViewController(withIdentifier: Constants.Storybaord.Identifier.timetableview)
                    break
                    
                case 5: //Assignment
                    destViewController = mainStoryboard.instantiateViewController(withIdentifier: Constants.Storybaord.Identifier.assignmentViewController)
                    break
                    
                case 6: //Performance/Score
                    destViewController = mainStoryboard.instantiateViewController(withIdentifier: Constants.Storybaord.Identifier.performancescoreview)
                    break
                    
                    /* case 7: //Study Progress
                     destViewController = mainStoryboard.instantiateViewController(withIdentifier: Constants.Storybaord.Identifier.studyProgressViewController)
                     break */
                    
                case 7: //Teachers List
                    destViewController = mainStoryboard.instantiateViewController(withIdentifier: Constants.Storybaord.Identifier.teachersviewcontroller)
                    break
                    
                case 8: //Attendance
                    destViewController = mainStoryboard.instantiateViewController(withIdentifier: Constants.Storybaord.Identifier.attendanceview)
                    break
                    
                case 9: //Event/Gallery
                    destViewController = mainStoryboard.instantiateViewController(withIdentifier: Constants.Storybaord.Identifier.eventGalleryListViewController)
                    break
                    
                case 10: //Health Report
                    destViewController = mainStoryboard.instantiateViewController(withIdentifier: Constants.Storybaord.Identifier.healthReportViewController)
                    break
                    
                case 11: //Holiday List
                    destViewController = mainStoryboard.instantiateViewController(withIdentifier: Constants.Storybaord.Identifier.holidayListViewController)
                    break
                    
                case 12: //My Profile
                    destViewController = mainStoryboard.instantiateViewController(withIdentifier: Constants.Storybaord.Identifier.studentProfileViewController)
                    break
                    
                case 13: //Change Password
                    destViewController = mainStoryboard.instantiateViewController(withIdentifier: Constants.Storybaord.Identifier.changePasswordViewController)
                    break
                    
                    /* case 14: //Logout
                     destViewController = mainStoryboard.instantiateViewController(withIdentifier: Constants.Storybaord.Identifier.loginviewcontroller)
                     break */
                    
                    //                case 15: //Move to MyProfile screen.
                    //                    destViewController = mainStoryboard.instantiateViewController(withIdentifier: Constants.Storybaord.Identifier.loginviewcontroller)
                    //                    break
                    
                default:
                    destViewController = mainStoryboard.instantiateViewController(withIdentifier: Constants.Storybaord.Identifier.viewController4)
                    break
                }
                
                sideMenuController()?.setContentViewController(destViewController)
            }
        }
            //else if (selectedLogin == "E")  //Teacher
        else if (selectedLogin == "2")  //Teacher
        {
            if (indexPath.row == 15)
            {
                hideSideMenuView()
                let alert = UIAlertController(title: Constants.Logout.logout, message: Constants.Logout.logoutMsg, preferredStyle: UIAlertControllerStyle.alert)
                // add the actions (buttons)
                alert.addAction(UIAlertAction(title: Constants.cancel, style: UIAlertActionStyle.default, handler: nil))
                alert.addAction(UIAlertAction(title: Constants.ok, style: UIAlertActionStyle.destructive, handler: { action in
                    let mainStoryboard: UIStoryboard = UIStoryboard(name: Constants.Storybaord.MainStoryboard,bundle: nil)
                    var destViewController : UIViewController
                    destViewController = mainStoryboard.instantiateViewController(withIdentifier: Constants.Storybaord.Identifier.loginviewcontroller)
                    self.sideMenuController()?.setContentViewController(destViewController)
                }))
                
                // show the alert
                self.present(alert, animated: true, completion: nil)
            }
            else
            {
                let mainStoryboard: UIStoryboard = UIStoryboard(name: Constants.Storybaord.MainStoryboard,bundle: nil)
                var destViewController : UIViewController
                
                switch (indexPath.row)
                {
                case 0:
                    destViewController = mainStoryboard.instantiateViewController(withIdentifier: Constants.Storybaord.Identifier.teacherDashboard)
                    break
                    
                case 1:
                    destViewController = mainStoryboard.instantiateViewController(withIdentifier: Constants.Storybaord.Identifier.teacherDailySchedule)
                    break
                    
                case 2:
                    destViewController = mainStoryboard.instantiateViewController(withIdentifier: Constants.Storybaord.Identifier.studentAttendanceViewController)
                    break
                    
                case 3:
                    destViewController = mainStoryboard.instantiateViewController(withIdentifier: Constants.Storybaord.Identifier.pinboardViewController)
                    break
                    
                case 4:
                    destViewController = self.getStudentProfileListingWithAction(actionType: .DISCUSSION)
                    break
                    
                case 5:
                    destViewController = mainStoryboard.instantiateViewController(withIdentifier: Constants.Storybaord.Identifier.assignmentContainerViewController)
                    break
                    
                case 6:
                    destViewController = mainStoryboard.instantiateViewController(withIdentifier: Constants.Storybaord.Identifier.studyProgressViewController)
                    break
                    
                case 7:
                    destViewController = self.getStudentProfileListingWithAction(actionType: .DASHBOARD)
                    break
                    
                case 8:
                    destViewController = self.getStudentProfileListingWithAction(actionType: .PROFILE)
                    break
                    
                case 9:
                    destViewController = mainStoryboard.instantiateViewController(withIdentifier: Constants.Storybaord.Identifier.feeDefaulterViewController)
                    break
                    
                case 10:
                    destViewController = mainStoryboard.instantiateViewController(withIdentifier: Constants.Storybaord.Identifier.eventGalleryListViewController)
                    break
                    
                case 11:
                    destViewController = mainStoryboard.instantiateViewController(withIdentifier: Constants.Storybaord.Identifier.holidayListViewController)
                    break
                    
                case 12:
                    destViewController =  mainStoryboard.instantiateViewController(withIdentifier: Constants.Storybaord.Identifier.teacherProfileViewController)
                    break
                    
                case 13:
                    destViewController = mainStoryboard.instantiateViewController(withIdentifier: Constants.Storybaord.Identifier.changePasswordViewController)
                    break
                    
                case 14:
                    destViewController = mainStoryboard.instantiateViewController(withIdentifier: Constants.Storybaord.Identifier.complaintsListViewController)
                    break
                    
                case 15:
                    destViewController = mainStoryboard.instantiateViewController(withIdentifier: Constants.Storybaord.Identifier.loginviewcontroller)
                    break
                    
                default:
                    destViewController = mainStoryboard.instantiateViewController(withIdentifier: Constants.Storybaord.Identifier.teacherDashboard)
                    break
                }
                
                sideMenuController()?.setContentViewController(destViewController)
            }
        }
            //else if (selectedLogin == "G")  //Parents
        else if (selectedLogin == "3")  //Parents
        {
            if (indexPath.row == 8)
            {
                hideSideMenuView()
                let alert = UIAlertController(title: Constants.Logout.logout, message: Constants.Logout.logoutMsg, preferredStyle: UIAlertControllerStyle.alert)
                // add the actions (buttons)
                alert.addAction(UIAlertAction(title: Constants.cancel, style: UIAlertActionStyle.default, handler: nil))
                alert.addAction(UIAlertAction(title: Constants.ok, style: UIAlertActionStyle.destructive, handler: { action in
                    let mainStoryboard: UIStoryboard = UIStoryboard(name: Constants.Storybaord.MainStoryboard,bundle: nil)
                    var destViewController : UIViewController
                    destViewController = mainStoryboard.instantiateViewController(withIdentifier: Constants.Storybaord.Identifier.loginviewcontroller)
                    self.sideMenuController()?.setContentViewController(destViewController)
                }))
                
                // show the alert
                self.present(alert, animated: true, completion: nil)
            }
            else
            {
                let mainStoryboard: UIStoryboard = UIStoryboard(name: Constants.Storybaord.MainStoryboard,bundle: nil)
                var destViewController : UIViewController
                
                switch (indexPath.row)
                {
                case 0:
                    destViewController = mainStoryboard.instantiateViewController(withIdentifier: Constants.Storybaord.Identifier.parentDashboard)
                    break
                    
                case 1:
                    destViewController = mainStoryboard.instantiateViewController(withIdentifier: Constants.Storybaord.Identifier.pinboardViewController)
                    break
                    
                case 2:
                    destViewController = mainStoryboard.instantiateViewController(withIdentifier: Constants.Storybaord.Identifier.parentChatViewController)
                    break
                    
                case 3:
                    destViewController = mainStoryboard.instantiateViewController(withIdentifier: Constants.Storybaord.Identifier.eventGalleryListViewController)
                    break
                    
                case 4:
                    destViewController = mainStoryboard.instantiateViewController(withIdentifier: Constants.Storybaord.Identifier.holidayListViewController)
                    break
                    
                case 5:
                    destViewController = mainStoryboard.instantiateViewController(withIdentifier: Constants.Storybaord.Identifier.parentprofileviewcontroller)
                    break
                    
                case 6:
                    destViewController = mainStoryboard.instantiateViewController(withIdentifier: Constants.Storybaord.Identifier.changePasswordViewController)
                    break
                    
                case 7:
                    destViewController = mainStoryboard.instantiateViewController(withIdentifier: Constants.Storybaord.Identifier.parentComplaintDetailViewController)
                    break
                    
                case 8:
                    destViewController = mainStoryboard.instantiateViewController(withIdentifier: Constants.Storybaord.Identifier.loginviewcontroller)
                    break
                    
                default:
                    destViewController = mainStoryboard.instantiateViewController(withIdentifier: Constants.Storybaord.Identifier.viewController4)
                    break
                }
                
                sideMenuController()?.setContentViewController(destViewController)
            }
            
        }
    }
    
    func getStudentProfileListingWithAction(actionType: StudentProfileActionType)->StudentProfileListingViewController {
        
        let vc = UIStoryboard(name: Constants.Storybaord.MainStoryboard, bundle: nil).instantiateViewController(withIdentifier: Constants.Storybaord.Identifier.studentProfileListingViewController) as! StudentProfileListingViewController
        vc.screenActionType = actionType
        return vc
    }
    
    func callForUserProfileData()
    {
        //  ProgressLoader.shared.showLoader(withText: "Please wait...")
        
        guard let regID = UserDefaults.standard.object(forKey: Constants.ServerKey.Login.registration_value) as? String else { return }
        
        // Getting USer profile
        WebServices.shared.getProfile(forRegistrationID: regID, completion: { (response, error) in
            
            if error == nil, let responseDict = response
            {
                //debugPrint(responseDict)
                print("Student Profile Response: \(responseDict)")
                //App crashing here as responseDict["value"] is giving no data elements and so we can't fetch corresponding below data elements. //Neeraj_Nov_05
                
                let className1 = responseDict["value"][0]["sis_currentclasssession"]["sis_name"].stringValue
                let fullNameArr = className1.split(separator: " ")
                self.classNameValue = "\(fullNameArr[1])(\(responseDict["value"][0]["sis_section"]["sis_name"]))"
                // UserDefaults.standard.set(self.classNameValue, forKey: "_sis_class_value")
                print("Class Name Value: \(self.classNameValue)")
                
                //SessionID:
                let classSession = responseDict["value"][0][Constants.ServerKey.StudentProfileKey.SessionID].stringValue
                UserDefaults.standard.set(classSession, forKey: Constants.ServerKey.StudentProfileKey.SessionID)
                
                //StudentID:
                let studentID = responseDict["value"][0][Constants.ServerKey.StudentProfileKey.StudentID].stringValue
                UserDefaults.standard.set(studentID, forKey: Constants.ServerKey.StudentProfileKey.StudentID)
                
                //ParentName:
                let parentsName = responseDict["value"][0][Constants.ServerKey.StudentProfileKey.FatherName].stringValue
                UserDefaults.standard.set(parentsName, forKey: Constants.ServerKey.StudentProfileKey.FatherName)
                
                //SectionID:
                let sectionID = responseDict["value"][0][Constants.ServerKey.StudentProfileKey.SectionID].stringValue
                UserDefaults.standard.set(sectionID, forKey: Constants.ServerKey.StudentProfileKey.SectionID)
                
                //  ProgressLoader.shared.hideLoader()
                self.setupDisplay()
            }
            else
            {
                // ProgressLoader.shared.hideLoader()
                AlertManager.shared.showAlertWith(title: Constants.Alert.error, message: Constants.Alert.somethingWentWrongMsg)
                debugPrint(error?.localizedDescription ?? "Getting user profile error")
            }
        })
    }
    
    func setupDisplay()
    {
        // if (self.selectedLogin == "S") //Earlier
        if (self.selectedLogin == "1")
        {
            /* If Study Progress is there in the menu then use below array else last one for icons array
             self.arrMenuImages = ["dashboard.png", "pinboard.png", "discussion.png", "notification.png", "calendar.png", "assignment.png", "performance.png", "progress.png", "teacher.png", "attendance.png", "event.png", "health.png", "holiday.png", "s_profile.png", "key.png", "logout.png"] */
            self.arrMenuImages = ["dashboard.png", "pinboard.png", "discussion.png", "notification.png", "calendar.png", "assignment.png", "performance.png", "teacher.png", "attendance.png", "event.png", "health.png", "holiday.png", "s_profile.png", "key.png", "logout.png"]
        }
        
        
        //        else if(self.selectedLogin == "E"){
        //            // for Teacher Login
        //            self.arrMenuValues = ["Dashboard", "Daily Schedule", "Attendance", "Pinboard", "Discussion", "Assignment",  "Study Progress", "Student Dashboard", "Student Information","Fee Defaulter", "Event/Gallery", "Holiday List", "My Profile", "Change Password","Complaints", "Logout"]
        //
        //            self.arrMenuImages = ["dashboard.png", "calendar.png", "attendance.png", "pinboard.png", "discussion.png", "assignment.png", "progress.png", "s_dashboard.png", "s_info.png", "fee.png", "event.png", "holiday.png",  "profile.png", "key.png","compliance.png", "logout.png"]
        //        }
        //
        //        else if(self.selectedLogin == "G"){
        //            // for Teacher Login
        //            self.arrMenuValues = ["Dashboard", "Pinboard", "Discussion", "Event/ Gallery", "Holiday List", "My Profile",  "Change Password", "Complaints","Logout"]
        //
        //            self.arrMenuImages = ["dashboard.png", "pinboard.png", "discussion.png", "event.png", "holiday.png", "profile.png", "key.png", "compliance.png", "logout.png"]
        //        }
        
        self.tableView = UITableView.init(frame: .zero, style: .grouped)
        let statusBarHeight = UIApplication.shared.keyWindow!.safeAreaInsets.top
        self.tableView.frame.origin = CGPoint(x: 0, y: statusBarHeight)
        self.tableView.separatorStyle = .none
        self.tableView.backgroundColor = UIColor.clear
        self.tableView.scrollsToTop = false
        self.tableView.bounces = false
        // Preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false
        
        self.tableView.sectionHeaderHeight = UITableViewAutomaticDimension
        //self.tableView.estimatedSectionHeaderHeight = 100
        
        self.tableView.selectRow(at: IndexPath(row: self.selectedMenuItem, section: 0), animated: false, scrollPosition: .middle)
        self.tableView.register(UINib(nibName:Constants.Nib.NibIdentifier.menuHeadingTableViewCell, bundle: nil), forCellReuseIdentifier: Constants.Nib.ReusableIdentifier.menuHeadingTableViewCell)
        self.tableView.register(UINib(nibName:Constants.Nib.NibIdentifier.menuStudentInfoHeaderView, bundle: nil), forHeaderFooterViewReuseIdentifier: Constants.Nib.ReusableIdentifier.menuStudentInfoHeaderView)
        self.tableView.register(UINib(nibName:Constants.Nib.NibIdentifier.menuTeacherInfoHeaderView, bundle: nil), forHeaderFooterViewReuseIdentifier: Constants.Nib.ReusableIdentifier.menuTeacherInfoHeaderView)
        self.tableView.register(UINib(nibName:Constants.Nib.NibIdentifier.menuParentInfoHeaderView, bundle: nil), forHeaderFooterViewReuseIdentifier: Constants.Nib.ReusableIdentifier.menuParentInfoHeaderView)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.reloadData()
        self.tableView.frame.origin.y = self.tableView.frame.origin.y - 35
        
        //        if let userProfileCell = self.tableView.headerView(forSection: 0) as? MenuStudentInfoHeaderView {
        //            let studentID = dict["value"][0]["sis_studentid"].stringValue
        //            userProfileCell.lblId.text = studentID
        //            let parentsName = dict["value"][0]["sis_fathername"].stringValue
        //            userProfileCell.lblParentName.text = parentsName
        //        }
        
    }
    
    //["Student", "PinBoard", "Discussion", "Notification", "Time Table", "Assignment", "Performance Score", "Teachers", "Attendance", "Event Gallery", "Health Report", "Holiday List", "My Profile"]
    func MenuListItems()
    {
        ProgressLoader.shared.showLoader(withText: "")
        
        guard let roleCode = UserDefaults.standard.string(forKey: "new_rolecode") else { return }
        print("Role Code: \(roleCode)")
        
        WebServices.shared.MenuListItem(role: roleCode, completion: {(response,error) in
            ProgressLoader.shared.hideLoader()
            
            if error == nil, let responceDict = response
            {
                // print(responceDict)
                let swiftyJsonVar = responceDict
                print("Side Menu Items from Response: \(swiftyJsonVar)")
                
                if (responceDict[Constants.ServerKey.SideMenuItemsKey.student] == true) {
                    self.sideMenuItems.append(Constants.SetMenuItems.dashboard)
                }
                
                if (responceDict[Constants.ServerKey.SideMenuItemsKey.pinboard] == true) {
                    self.sideMenuItems.append(Constants.SetMenuItems.pinboard) 
                }
                
                if (responceDict[Constants.ServerKey.SideMenuItemsKey.discussion] == true) {
                    self.sideMenuItems.append(Constants.SetMenuItems.discussion)
                }
                
                if (responceDict[Constants.ServerKey.SideMenuItemsKey.notification] == true) {
                    self.sideMenuItems.append(Constants.SetMenuItems.notification)
                }
                
                if (responceDict[Constants.ServerKey.SideMenuItemsKey.timeTable] == true) {
                    self.sideMenuItems.append(Constants.SetMenuItems.timeTable)
                }
                
                if (responceDict[Constants.ServerKey.SideMenuItemsKey.assignment] == true) {
                    self.sideMenuItems.append(Constants.SetMenuItems.assignment)
                }
                if (responceDict[Constants.ServerKey.SideMenuItemsKey.performanceScore] == true) {
                    self.sideMenuItems.append(Constants.SetMenuItems.performanceScore) 
                }
                
                if (responceDict[Constants.ServerKey.SideMenuItemsKey.studyProcess] == true) {
                    self.sideMenuItems.append(Constants.SetMenuItems.studyProcess) //Delete this
                }
                
                if (responceDict[Constants.ServerKey.SideMenuItemsKey.teachers] == true) {
                    self.sideMenuItems.append(Constants.SetMenuItems.teachers)
                }
                
                if (responceDict[Constants.ServerKey.SideMenuItemsKey.attendance] == true) {
                    self.sideMenuItems.append(Constants.SetMenuItems.attendance)
                }
                
                if (responceDict[Constants.ServerKey.SideMenuItemsKey.eventGallery] == true) {
                    self.sideMenuItems.append(Constants.SetMenuItems.eventGallery)
                }
                
                if (responceDict[Constants.ServerKey.SideMenuItemsKey.healthReport] == true) {
                    self.sideMenuItems.append(Constants.SetMenuItems.healthReport)
                }
                
                if (responceDict[Constants.ServerKey.SideMenuItemsKey.holidayList] == true) {
                    self.sideMenuItems.append(Constants.SetMenuItems.holidayList)
                }
                if (responceDict[Constants.ServerKey.SideMenuItemsKey.myProfile] == true) {
                    self.sideMenuItems.append(Constants.SetMenuItems.myProfile)
                }
                //Add more menu options if available from API //Neeraj_Oct_30
                //Add more menu options for Teacher login and Parent Login checking the API response. //Neeraj_Nov_05
                
                //Add Change Password
                //Add Logout
                
                // if (self.selectedLogin == "S") //Earlier
                if (self.selectedLogin == "1") //For Student
                {
                    self.sideMenuItems.append(Constants.SetMenuItems.changePassword)
                    self.sideMenuItems.append(Constants.SetMenuItems.logout)
                }
                    //else if (self.selectedLogin == "E") //For Teacher
                else if (self.selectedLogin == "2") //For Teacher
                {
                    self.sideMenuItems.append(Constants.SetMenuItems.changePassword)
                    self.sideMenuItems.append(Constants.SetMenuItems.complaints)
                    self.sideMenuItems.append(Constants.SetMenuItems.logout)
                }
                    //else if (self.selectedLogin == "G") //For Parent
                else if (self.selectedLogin == "3") //For Parent
                {
                    self.sideMenuItems.append(Constants.SetMenuItems.changePassword)
                    self.sideMenuItems.append(Constants.SetMenuItems.complaints)
                    self.sideMenuItems.append(Constants.SetMenuItems.logout)
                }
                
                print("Side Menu Items: \(self.sideMenuItems)")
                self.callForUserProfileData()
            }
            else
            {
                ProgressLoader.shared.hideLoader()
                AlertManager.shared.showAlertWith(title: Constants.Alert.errorOccured, message: Constants.Alert.tryAfterSomeTime)
            }
            
        })
    }
    
}
