//
//  StudyProgressViewController.swift
//  EliteSISSwift
//
//  Created by Vivek Garg on 26/02/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import UIKit
import DropDown

class StudyProgressViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tblViewStudyProgress: UITableView!
    @IBOutlet weak var lblSelectedOption: UILabel!
    
    var pickerData: [String] = [String]()
    var arrFA1 = [[String:String]]()
    var arrFA2 = [[String:String]]()
    var arrSA1 = [[String:String]]()
    var arrSA2 = [[String:String]]()
    var arrFinal = [[String:String]]()
    
    var arrValuesForTable = [[String:String]]()
    var dropDownClasses: DropDown!
    @IBOutlet weak var viewOptions: UIView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        tblViewStudyProgress.register(UINib(nibName:Constants.Nib.NibIdentifier.studyProgressTableViewCell, bundle: nil), forCellReuseIdentifier: Constants.Nib.ReusableIdentifier.studyProgressTableViewCell)
        tblViewStudyProgress.separatorStyle = .none
        
        let selectedLogin = UserDefaults.standard.string(forKey: Constants.ServerKey.selectedLogin)
        
        if  selectedLogin == LoginUserType.STUDENT.rawValue
        {
            self.callForGetPerformanceListForStudents()
        }
        else if(selectedLogin == LoginUserType.TEACHER.rawValue) //Teacher
        {
            
        }
        else if(selectedLogin == LoginUserType.PARENT.rawValue) //Parent
        {
            
        }
        
                if UserDefaults.standard.string(forKey: Constants.ServerKey.selectedLogin) == LoginUserType.TEACHER.rawValue
                {
                    pickerData = ["4th", "6th", "7th", "10th"]
                }
                else
                {
                    pickerData = ["FA1", "FA2", "SA1", "SA2", "Final"] //Start from here ...
                }
        
        //Dummy data:
        var dict1 = [String:String]()
        dict1["sub"] = "English"
        dict1["per"] = "88"
        
        var dict2 = [String:String]()
        dict2["sub"] = "Maths"
        dict2["per"] = "77"
        
        var dict3 = [String:String]()
        dict3["sub"] = "Hindi"
        dict3["per"] = "65"
        
        var dict4 = [String:String]()
        dict4["sub"] = "Art"
        dict4["per"] = "90"
        
        arrFA1.append(dict1)
        arrFA1.append(dict2)
        arrFA1.append(dict3)
        arrFA1.append(dict4)
        
        var dict11 = [String:String]()
        dict11["sub"] = "English"
        dict11["per"] = "55"
        
        var dict22 = [String:String]()
        dict22["sub"] = "Maths"
        dict22["per"] = "66"
        
        var dict33 = [String:String]()
        dict33["sub"] = "Hindi"
        dict33["per"] = "77"
        
        var dict44 = [String:String]()
        dict44["sub"] = "Art"
        dict44["per"] = "88"
        
        arrFA2.append(dict11)
        arrFA2.append(dict22)
        arrFA2.append(dict33)
        arrFA2.append(dict44)
        
        arrValuesForTable = arrFA1
        
        tblViewStudyProgress.delegate = self
        tblViewStudyProgress.dataSource = self
        
        
        // Do any additional setup after loading the view.
        
        self.configDropDown()
        self.onCategoryChange(withCategoryIndex: 0)
        self.lblSelectedOption.text = self.pickerData[0]
    }
    
    func configDropDown(){
        dropDownClasses = DropDown()
        
        // The view to which the drop down will appear on
        dropDownClasses.anchorView = viewOptions // UIView or UIBarButtonItem
        
        // The list of items to display. Can be changed dynamically
        dropDownClasses.dataSource = self.pickerData
        
        dropDownClasses.selectionAction = { [unowned self] (index: Int, item: String) in
            self.onCategoryChange(withCategoryIndex: index)
        }
    }
    
    //Get Performance List API: (For drop-down menu)
    func callForGetPerformanceListForStudents()
    {
        ProgressLoader.shared.showLoader(withText: "Please wait...")
        
        guard let studentID = UserDefaults.standard.object(forKey: Constants.ServerKey.StudentProfileKey.StudentID) as? String else { return }
        guard let sessionID = UserDefaults.standard.object(forKey: Constants.ServerKey.StudentProfileKey.SessionID) as? String else { return }
        guard let sectionID = UserDefaults.standard.object(forKey: Constants.ServerKey.StudentProfileKey.SectionID) as? String else { return }
        
        
        //Get Performance List API:
        WebServices.shared.getPerformanceListForStudentLoginRole(StudentID: studentID, SessionID: sessionID, SectionID: sectionID, completion: { (response, error) in
            
            if error == nil, let responseDict = response
            {
                print("Get Performance List for Student Login Role: \(responseDict)")
                
                //Work from here to create an array of picker data and append the same in pickerData array.....
                
//                var arrayOfValues = responseDict["value"].arrayObject
//
//                //Add the data in the drop-down picker:
//                for name in arrayOfValues!
//                {
//                   // var examName = arrayOfValues![name]
//                    //pickerData.append(examName)
//                }
//
//
//                //MarksID:
//                let MarksID = responseDict["value"][0][Constants.ServerKey.StudentGetPerformanceListKey.marksID].stringValue
                //UserDefaults.standard.set(classSession, forKey: Constants.ServerKey.StudentProfileKey.SessionID)
                
                ProgressLoader.shared.hideLoader()
            }
            else
            {
                ProgressLoader.shared.hideLoader()
                AlertManager.shared.showAlertWith(title: Constants.Alert.error, message: Constants.Alert.somethingWentWrongMsg)
                debugPrint(error?.localizedDescription ?? "Getting user profile error")
            }
        })
    }
    
    @IBAction func btnCategoryClick(_ sender: Any) {
        self.onStudentCategoryInfoClick()
    }
    
    func onStudentCategoryInfoClick() {
        
        if dropDownClasses.isHidden{
            dropDownClasses.show()
            hideSideMenuView()
        }
        else
        {
            dropDownClasses.hide()
        }
    }
    
    func onCategoryChange(withCategoryIndex row: Int)
    {
        //Implement API for Get Study Progress API with that marksid for fetching respective subjects...
        
        if row % 2 == 0 {
            arrValuesForTable = arrFA2
        }
        else
        {
            arrValuesForTable = arrFA1
        }
        
        tblViewStudyProgress.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrValuesForTable.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Nib.ReusableIdentifier.studyProgressTableViewCell) as! StudyProgressTableViewCell
        cell.lblSubject.text = arrValuesForTable[indexPath.row]["sub"]
        cell.lblPercentage.text = "\(String(describing: arrValuesForTable[indexPath.row]["per"]!))%"
        
        let count = Double(arrValuesForTable[indexPath.row]["per"]!)
        let newAngleValue = newAngle(count!)
        cell.circularProgress.animate(toAngle: newAngleValue, duration: 1.0, completion: nil)
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: Constants.Storybaord.MainStoryboard,bundle: nil)
        var destViewController : UIViewController
        destViewController = mainStoryboard.instantiateViewController(withIdentifier: Constants.Storybaord.Identifier.chapterStatusViewController)
        sideMenuController()?.setContentViewController(destViewController)
        hideSideMenuView()
    }
    
    func newAngle(_ currentCount:Double) -> Double {
        let maxCount = 100.0
        return 360 * (currentCount / maxCount)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showMenu(_ sender: Any) {
        
        toggleSideMenuView()
    }
    
    @IBAction func backbuttonClicked(_ sender: Any) {
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: Constants.Storybaord.MainStoryboard,bundle: nil)
        var destViewController : UIViewController
        // destViewController = mainStoryboard.instantiateViewController(withIdentifier: "dashboard")
        //sideMenuController()?.setContentViewController(destViewController)
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
