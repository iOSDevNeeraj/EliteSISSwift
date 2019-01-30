//
//  Constants.swift
//  EliteSISSwift
//
//  Created by Neeraj Shukla on 19/11/18.
//  Copyright © 2018 Neeraj Shukla. All rights reserved.
//

import Foundation
import UIKit

let kAppDelegate = UIApplication.shared.delegate as! AppDelegate
let kUserDefaults = UserDefaults.standard


struct Constants {
    
    //static let BASE_URL = Constants.apiBaseURL()
    // let BASE_URL = "http://43.224.136.81:5015/" //Old base URL
    static let  BASE_URL = "http://104.211.88.67:5147/" //New Base URL //Neeraj_Nov_19
    static let appName = "EliteSIS"
    static let SchoolID = "MBLE_APP_00001"
    
    //Some constants for Change/Forgot Password:
    static let accessNumberForChangePassword = "2"
    static let accessNumberForForgotPassword = "1"
    static let mobile = "/mobile/"
    
    //Button names:
    static let ok = "OK"
    static let cancel = "CANCEL"
    static let done = "Done"
    static let submit = "Submit"
    static let success = "Success!"
    
    // UserDefaultsManager.sharedInstance.isLoggedIn = true
    // kUserDefaults.synchronize()
    
    /* static func apiBaseURL() -> String {
     return ConfigurationManager.sharedManager.APIEndpoint()
     } */
    
    
    //MARK: RGB Color Code
    struct AppColorRGBCode {
        static let appThemeColor  =  UIColor(red: 11/255, green: 77/255, blue: 173/255, alpha: 1.0) //App theme
        static let appThemeColorLight  = UIColor(red: 203/255, green: 179/255, blue: 152/255, alpha: 1.0)
        static let appBlackColor  = UIColor(red: 37/255, green: 33/255, blue: 30/255, alpha: 1.0)
        static let appGrayColor  = UIColor(red: 102/255, green: 102/255, blue: 102/255, alpha: 1.0)
        static let appGrayColorLight  = UIColor(red: 190/255, green: 195/255, blue: 198/255, alpha: 1.0)
        static let loginBtnBgColor = UIColor(red: 73/255, green: 69/255, blue: 96/255, alpha: 1.0)
    }
    
    //MARK: Nib
    struct Nib {
        
        struct NibIdentifier {
            static let logoTableViewCell = "LogoTableViewCell"
            static let loginCredentialsTableViewCell = "LoginCredentialsTableViewCell"
            static let forgotPasswordTableViewCell = "ForgotPasswordTableViewCell"
            static let buttonWithBgTableViewCell = "ButtonWithBgTableViewCell"
            static let menuStudentInfoHeaderView = "MenuStudentInfoHeaderView"
            static let menuTeacherInfoHeaderView = "MenuTeacherInfoHeaderView"
            static let menuParentInfoHeaderView =  "MenuParentInfoHeaderView"
            static let menuHeadingTableViewCell = "MenuHeadingTableViewCell"
            static let simpleLabelTableViewCell = "SimpleLabelTableViewCell"
            static let assignmentTableViewCell = "AssignmentTableViewCell"
            static let assignmentHeaderReusableView = "AssignmentHeaderReusableView"
            static let studyProgressTableViewCell = "StudyProgressTableViewCell"
            static let chapterStatusHeaderReusableView = "ChapterStatusHeaderReusableView"
            static let chapterStatusTableViewCell = "ChapterStatusTableViewCell"
            static let notificationCollectionViewCell = "NotificationCollectionViewCell"
            static let feeDefaulterHeaderViewTableViewCell = "FeeDefaulterHeaderViewTableViewCell"
            static let feeDefaulterTableViewCell = "FeeDefaulterTableViewCell"
            static let holidaylistHeaderReusableviewTableViewCell = "HolidaylistHeaderReusableviewTableViewCell"
            static let holidayListTableViewCell = "HolidayListTableViewCell"
            static let notificationTableViewCell = "NotificationTableViewCell"
            static let galleryCollectionViewCell = "GalleryCollectionViewCell"
            static let galleryPhotosCollectionViewCell = "GalleryPhotosCollectionViewCell"
            static let studentCollectionViewCell = "StudentCollectionViewCell"
            static let studentAttendanceTableViewCell = "StudentAttendanceTableViewCell"
            static let studentAttendanceHeaderFooterView = "StudentAttendanceHeaderFooterView"
            static let teacherAssignmentDetailTableViewCell = "TeacherAssignmentDetailTableViewCell"
            static let teacherAssignmentHeaderFooterView = "TeacherAssignmentHeaderFooterView"
            static let teachersTableViewCell = "TeachersTableViewCell"
            static let teachersHeaderView = "TeachersHeaderView"
            static let textfieldTableViewCell = "TextfieldTableViewCell"
            static let textFieldWithCalendarTableViewCell = "TextFieldWithCalendarTableViewCell"
            static let dropDownTableViewCell = "DropDownTableViewCell"
            static let dateSelectionTableViewCell = "DateSelectionTableViewCell"
            static let receiverTableViewCell = "ReceiverTableViewCell"
            static let complaintsHeaderView = "ComplaintsHeaderView"
            static let complaintsListTableViewCell = "ComplaintsListTableViewCell"
            static let complaintHeadingTableViewCell = "ComplaintHeadingTableViewCell"
            static let complaintTextViewTableViewCell = "ComplaintTextViewTableViewCell"
            static let teacherAssignmentTableViewCell = "TeacherAssignmentTableViewCell"
            static let classInfoCollectionViewCell = "ClassInfoCollectionViewCell"
            static let parentDashboardHeaderView = "ParentDashboardHeaderView"
            static let feeInfoTableViewCell = "FeeInfoTableViewCell"
            static let feeInfoHeaderView = "FeeInfoHeaderView"
            static let feeTotalTableViewCell = "FeeTotalTableViewCell"
            static let feeItemsTableViewCell = "FeeItemsTableViewCell"
            static let eventCollectionViewCell = "EventCollectionViewCell"
            static let childCollectionViewCell = "ChildCollectionViewCell"
            static let scoreTableViewCell = "ScoreTableViewCell"
        }
        struct ReusableIdentifier {
            static let logoTableViewCell = "LogoTableViewCell"
            static let loginCredentialsTableViewCell = "LoginCredentialsTableViewCell"
            static let forgotPasswordTableViewCell = "ForgotPasswordTableViewCell"
            static let buttonWithBgTableViewCell = "ButtonWithBgTableViewCell"
            static let menuHeadingTableViewCell = "MenuHeadingTableViewCell"
            static let menuStudentInfoHeaderView = "MenuStudentInfoHeaderView"
            static let menuTeacherInfoHeaderView = "MenuTeacherInfoHeaderView"
            static let menuParentInfoHeaderView =  "MenuParentInfoHeaderView"
            static let simpleLabelTableViewCell = "SimpleLabelTableViewCell"
            static let assignmentTableViewCell = "AssignmentTableViewCell"
            static let assignmentHeaderReusableView = "AssignmentHeaderReusableView"
            static let studyProgressTableViewCell = "StudyProgressTableViewCell"
            static let chapterStatusHeaderReusableView = "ChapterStatusHeaderReusableView"
            static let chapterStatusTableViewCell = "ChapterStatusTableViewCell"
            static let notificationCollectionViewCell = "NotificationCollectionViewCell"
            static let feeDefaulterHeaderViewTableViewCell = "FeeDefaulterHeaderViewTableViewCell"
            static let feeDefaulterTableViewCell = "FeeDefaulterTableViewCell"
            static let holidaylistHeaderReusableviewTableViewCell = "HolidaylistHeaderReusableviewTableViewCell"
            static let holidayListTableViewCell = "HolidayListTableViewCell"
            static let notificationTableViewCell = "NotificationTableViewCell"
            static let galleryCollectionViewCell = "GalleryCollectionViewCell"
            static let galleryPhotosCollectionViewCell = "GalleryPhotosCollectionViewCell"
            static let studentCollectionViewCell = "StudentCollectionViewCell"
            static let studentAttendanceTableViewCell = "StudentAttendanceTableViewCell"
            static let studentAttendanceHeaderFooterView = "StudentAttendanceHeaderFooterView"
            static let teacherAssignmentDetailTableViewCell = "TeacherAssignmentDetailTableViewCell"
            static let teacherAssignmentHeaderFooterView = "TeacherAssignmentHeaderFooterView"
            static let teachersTableViewCell = "TeachersTableViewCell"
            static let teachersHeaderView = "TeachersHeaderView"
            static let textfieldTableCell = "textfieldTableCell"
            static let textfieldwithCalendarTableCell = "textfieldwithCalendarTableCell"
            static let dropDownTableViewCell = "DropDownTableViewCell"
            static let dateSelectionTableViewCell = "DateSelectionTableViewCell"
            static let receiverTableViewCell = "ReceiverTableViewCell"
            static let complaintsHeaderView = "ComplaintsHeaderView"
            static let complaintsListTableViewCell = "ComplaintsListTableViewCell"
            static let complaintHeadingTableViewCell = "ComplaintHeadingTableViewCell"
            static let complaintTextViewTableViewCell = "ComplaintTextViewTableViewCell"
            static let teacherAssignmentTableViewCell = "TeacherAssignmentTableViewCell"
            static let classInfoCollectionViewCell = "ClassInfoCollectionViewCell"
            static let parentDashboardHeaderView = "ParentDashboardHeaderView"
            static let feeInfoTableViewCell = "FeeInfoTableViewCell"
            static let feeInfoHeaderView = "FeeInfoHeaderView"
            static let feeTotalTableViewCell = "FeeTotalTableViewCell"
            static let feeItemsTableViewCell = "FeeItemsTableViewCell"
            static let eventCollectionViewCell = "EventCollectionViewCell"
            static let childCollectionViewCell = "ChildCollectionViewCell"
            static let scoreTableViewCell = "ScoreTableViewCell"
        }
    }
    
    //MARK: Storyboards
    struct Storybaord {
        static let MainStoryboard = "Main"
        
        struct Identifier {
            //Students:
            static let forgotPasswordVC = "ForgotPasswordViewController"
            static let myNavi = "myNavi"
            static let teacherNavi = "TeacherNavi"
            static let parentNavi = "ParentNavi"
            static let dashboard = "dashboard"
            static let pinboardViewController = "PinboardViewController"
            static let parentChatViewController = "ParentChatViewController"
            static let notificationViewController = "NotificationViewController"
            static let timetableview = "timetableview"
            static let assignmentViewController = "AssignmentViewController"
            static let performancescoreview = "performancescoreview"
            static let studyProgressViewController = "StudyProgressViewController"
            static let teachersviewcontroller = "teachersviewcontroller"
            static let attendanceview = "attendanceview"
            static let eventGalleryListViewController = "EventGalleryListViewController"
            static let healthReportViewController = "HealthReportViewController"
            static let holidayListViewController = "HolidayListViewController"
            static let studentProfileViewController = "StudentProfileViewController"
            static let changePasswordViewController = "ChangePasswordViewController"
            static let loginviewcontroller = "loginviewcontroller"
            static let viewController4 = "ViewController4"
            static let studentProfileListingViewController = "StudentProfileListingViewController"
            static let chapterStatusViewController = "ChapterStatusViewController"
            static let galleryPhotosViewController = "GalleryPhotosViewController"
            // static let studentProfileViewController = "StudentProfileViewController"
            static let teacherChatViewController = "TeacherChatViewController"
            static let addAssignmentViewController = "AddAssignmentViewController"
            static let datePickerViewController = "DatePickerViewController"
            static let complaintDetailViewController = "ComplaintDetailViewController"
            static let studentAttendanceViewController = "StudentAttendanceViewController"
            static let assignmentContainerViewController = "AssignmentContainerViewController"
            static let feeInformationViewController = "FeeInformationViewController"
            
            //Teachers:
            static let teacherDashboard = "teacherdashboard"
            static let teacherDailySchedule = "teacherDailySchedule"
            // static let studentAttendanceViewController = "StudentAttendanceViewController"
            // static let assignmentContainerViewController = "AssignmentContainerViewController"
            static let feeDefaulterViewController = "FeeDefaulterViewController"
            static let teacherProfileViewController = "teacherprofileviewcontroller"
            static let complaintsListViewController = "ComplaintsListViewController"
            static let teacherAssignmentViewController = "TeacherAssignmentViewController"
            
            //Parents:
            static let parentDashboard = "parentdashboard"
            static let parentprofileviewcontroller = "parentprofileviewcontroller"
            static let parentComplaintDetailViewController = "ParentComplaintDetailViewController"
            
        }
        struct ReusableIdentifier {
            static let collectionViewCell = "CollectionViewCell"
            static let reviewTblViewCell = "ReviewTableViewCell"
            static let popupReasonTableViewCell = "PopupReasonTableViewCell"
            static let popupReasonHeaderTableViewCell = "PopupReasonHeaderTableViewCell"
            static let myProfileTableViewCell = "MyProfileTableViewCell"
            static let visitorMgmntTableViewCell = "VisitorMgmntTableViewCell"
            static let notificationsTableViewCell = "NotificationsTableViewCell"
            static let datePickerViewController = "DatePickerViewController"
            
        }
    }
    
    //MARK: Alerts
    struct Alert {
        static let title = "Alert"
        static let blankUserName = "Username cannot be left blank"
        static let blankPassword = "Password can't be left blank"
        static let loaderLoginText = "Login! Please wait..."
        static let loginFailed = "Login failed!"
        static let errorOccured = "Error Occured!"
        static let checkUsernamePassword = "Please check your Username and Password"
        static let tryAfterSomeTime = "Please try after sometime"
        static let error = "Error!"
        static let somethingWentWrongMsg = "Something went wrong"
        static let invalidMobileNumberMsg = "Please enter a valid mobile number"
        static let otpSentMsg = "OTP sent on provided phone number"
        static let passwordChangedMsg = "Password changed successfully."
        static let blankResponseAlertMsg = "Response can't be left blank"
        static let successResponseAlertMsg = "Response sent succesfully"
        static let blankMessageField = "Message field can't be left blank"
        static let successComplaintMsg = "Complaint sent successfully!"
        static let blankSubjectFieldMsg = "Subject field can't be left blank"
    }
    
    //MARK: Logout
    struct Logout {
        static let logout = "Logout"
        static let logoutMsg = "Do you really want to logout?"
    }
    
    //MARK: Textfields Placeholder Texts
    struct PlaceholderText {
        static let enterUsername = "Enter Username"
        static let enterPassword = "Enter Password"
        static let mobilePlaceholder = "Enter mobile number"
        static let oldPasswordPlaceholder = "Enter old password"
        static let newPasswordPlaceholder = "Enter new password"
        static let confirmPasswordPlaceholder = "Confirm new password"
        static let genderPlaceholder = "Gender"
        static let fathersNamePlaceholder = "Enter your Father's name"
        static let mothersNamePlaceholder = "Enter your Mother's name"
        static let emailPlaceholder = "Enter your email address"
        static let qualificationPlaceholder = "Enter your Qualification"
        static let yearPlaceholder = "Enter the year"
        static let percentagePlaceholder = "Enter the CGPA/Percentage"
        static let addressTypePlaceholder = "Enter the address type"
        static let cityPlaceholder = "Enter the city"
        static let statePlacehlder = "Enter the state"
        static let countryPlaceholder = "Enter the country"
        static let postalCodePlaceholder = "Enter the postal code"
        static let cardTypePlaceholder = "Enter the card type"
        static let cardNumberPlaceholder = "Enter the card number"
        static let issuedDatePlaceholder = "Enter the issued date"
        static let expiryDatePlaceholder = "Enter the expiry date"
        static let licensePlaceholder = "Enter the licensing authority"
        static let cardDescriptionPlaceholder = "Enter the card description"
        static let iDPlaceholder = "Enter the id for"
        
    }
    
    //MARK:- API Urls
    /*  struct API {
     
     //APIs
     //static let registration = Constants.API.apiURL("user")
     static let login = Constants.API.apiURL("/webservices/user/authuser")
     
     static func apiURL(_ methodName: String) -> String {
     return BASE_URL + methodName
     }
     
     struct AccountPutAction {
     static let follow = "follow"
     }
     } */
    
    //MARK:- API Urls
    struct API {
        
        //APIs
        //static let registration = Constants.API.apiURL("user")
        static let login = "SIS_Student/Login/"
        static let getProfile = "SIS_Student/GetProfile/"
        static let getDashboardDetails = "SIS_Student/GetDashboardData/"
        static let getMenuListItems = "SIS/GetConfigurations/"
        static let chooseTeacherDiscussion = "SIS_Student/GetLessonPlan/"
        static let getHolidayList = "SIS_Student/Holidays/"
        static let getAssignmentList = "SIS_Student/GetAssignmentList/"
        static let getAttendance = "SIS/getAttendenceClasses/"
        static let getTeacherProfile = "SIS/GetProfiledetails/"
        static let compliance = "SIS/Compliance/"
        static let getFacultyDashboard = "SIS/GetFacultydashboard/"
        static let getDailySchedule = "SIS/DailySchedule/"
        static let getFacultyFromRegistrationID = "SIS/GetFacultyFromRegistrationID/"
        static let changePassword = "SIS_Student/ChangePass/"
        static let forgotPassword = "SIS_Student/GetOtp/"
        static let postOTP = "SIS_Student/PostOtp/"
        static let discussion = "SIS_Student/CreateDiscussion/"
        static let getPerformanceListForStudentLoginRole = "SIS_Student/getPerformanceList/"
    }
    
    //MARK:- User Default Keys
    struct UserDefaultsKey {
        static let isLoggedIn = "isLoggedIn"
        static let isLoggedOut = "kIsLoggedOut"
        static let accessToken = "kDeviceToken"
        static let schoolID = "schoolID"
    }
    
    //MARK:- Remember Me Keys
    struct RememberMeKey {
        static let rememberMe = "RememberMe"
        static let savedUserName = "SavedUserName"
        static let savedPassword = "SavedPassword"
    }
    
    //MARK:- Server Keys
    struct ServerKey {
        
        //Server Authentication Token Parameter Key
        static let Authorization = "Authorization"
        
        //Server Request Keys
        static let userId = "userId"
        static let Password = "password"
        static let MessageType = "messageType"
        static let DeviceType = "deviceType"
        static let DeviceToken = "deviceToken"
        static let selectedLogin = "selectedLogin"
        
        //Server Authentication Token Response Key
        static let token = "token"
        
        //ChangePassword Parameter Keys
        static let UserId = "userId"
        static let OldPassword = "oldPassword"
        static let NewPassword = "newPassword"
        static let ConfirmPassword = "confirmPassword"
        
        // Response Keys
        static let statusCode = "status"
        static let meta = "meta"
        static let data = "data"
        static let url = "url"
        static let error = "error"
        static let message = "message"
        //static let statusSuccessMessage = "SUCCESS"
        //static let statusFailureMessage = "FAIL"
        
        struct UserInfo {
            static let userId = "userId"
            static let userName  = "userName"
            static let name = "name"
            static let clientId = "clientId"
            static let securityToken = "securityToken"
            static let emailId = "emailId"
            static let password = "password"
            static let firstName = "firstName"
            static let lastName = "lastName"
            static let userType = "userType"
            static let signupMode = "signupMode"
            static let mobile = "mobile"
            static let gender = "gender"
            static let dob = "dob"
            static let lat = "lat"
            static let lng = "lng"
            static let tags = "tags"
            static let picture = "picture"
            static let deviceToken = "deviceToken"
        }
        
        struct Login {
            static let value = "value"
            static let dataCount = "@odata.count"
            static let loginmasterID = "sis_loginmasterid"
            static let registration_value = "_sis_registration_value"
            static let name = "sis_name"
            static let userID = "sis_user_id"
            static let new_rolecode = "new_rolecode"
            
        }
        
        struct Discussion {
            static let new_Sender = "new_Sender@odata.bind"
            static let new_Recipient = "new_Recipient"
            static let new_message = "new_message"
            
        }
        
        struct ChangePassword {
            static let oldPasswordKey = "sis_oldpassword"
            static let changePasswordKey = "sis_changepassword"
            
            static let subject = "subject"
            static let description = "description"
            static let sisContactNo = "sis_contactnumber"
        }
        
        struct SideMenuItemsKey { //Total: 14
            static let student = "Student"
            static let pinboard = "PinBoard"
            static let discussion = "Discussion"
            static let notification = "Notification"
            static let timeTable = "TimeTable"
            static let assignment = "Assignment"
            static let performanceScore = "PerformanceScore"
            static let studyProcess = "StudyProcess"
            static let teachers = "Teachers"
            static let attendance = "Attendance"
            static let eventGallery = "EventGallery"
            static let healthReport = "HealthReport"
            static let holidayList = "HolidayList"
            static let myProfile = "MyProfile"
        }
        //Neeraj_Jan_21
        struct AssignmentKey {
            static let name = "new_name"
            static let issueDate = "new_tat"
            static let dueDate = "new_duedate"
        }
        
        //Neeraj_Jan_22
        struct StudentProfileKey {
            static let SessionID = "_sis_currentclasssession_value"
            static let SectionID = "_sis_section_value"
            static let StudentID = "sis_studentid"
            static let FatherName = "sis_fathername"
        }
        
        //Neeraj_Jan_22
        struct StudentGetPerformanceListKey {
            static let marksID = "sis_classsessionwisemarksid"
        }
        
    }
    
    struct SetMenuItems { //Total: 16
        static let dashboard = "Dashboard"
        static let pinboard = "Pinboard"
        static let discussion = "Discussion"
        static let notification = "Notification"
        static let timeTable = "Time Table"
        static let assignment = "Assignment"
        static let performanceScore = "Performance / Score"
        static let studyProcess = "Study Process"
        static let teachers = "Teachers"
        static let attendance = "Attendance"
        static let eventGallery = "Event / Gallery"
        static let healthReport = "Health Report"
        static let holidayList = "Holiday List"
        static let myProfile = "My Profile"
        static let changePassword = "Change Password"
        static let complaints = "Complaints"
        static let logout = "Logout"
    }
    
}

