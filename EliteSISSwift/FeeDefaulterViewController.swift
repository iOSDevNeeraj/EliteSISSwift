//
//  FeeDefaulterViewController.swift
//  EliteSISSwift
//
//  Created by Reetesh Bajpai on 03/04/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import UIKit

class FeeDefaulterViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tblViewFeeDefaulterList: UITableView!
    var arrStudentName = [String]()
    var arrClass = [String]()
    var arrDueAmount = [String]()
    var arrDueDate = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tblViewFeeDefaulterList.delegate = self
        tblViewFeeDefaulterList.dataSource = self
        tblViewFeeDefaulterList.separatorStyle = .none
        tblViewFeeDefaulterList.sectionHeaderHeight = 45
        tblViewFeeDefaulterList.rowHeight = UITableViewAutomaticDimension
        
        tblViewFeeDefaulterList.register(UINib(nibName: Constants.Nib.NibIdentifier.feeDefaulterHeaderViewTableViewCell, bundle: nil), forHeaderFooterViewReuseIdentifier: Constants.Nib.ReusableIdentifier.feeDefaulterHeaderViewTableViewCell)
        tblViewFeeDefaulterList.register(UINib(nibName:Constants.Nib.NibIdentifier.feeDefaulterTableViewCell, bundle:nil), forCellReuseIdentifier: Constants.Nib.ReusableIdentifier.feeDefaulterTableViewCell)
        
        arrStudentName = ["Rangoli Sharma","Shruti Pandey","Abhishek Tiwari","Waseem Ahmad","Shivam Gupta","Tarun Sarkar","Puneet Singh","Charu Sarkar","Akhlaque Ahmad","Christopher"]
        arrDueDate = ["30-Jan-2018", "30-Jan-2018", "30-Jan-2018", "30-Jan-2018", "30-Jan-2018", "30-Jan-2018","30-Jan-2018", "30-Jan-2018", "30-Jan-2018", "30-Jan-2018"]
        arrClass = ["8th", "4th", "9th", "6th", "10th", "11th","4th", "3rd", "6th", "9th"]
        arrDueAmount = ["₹5275", "₹5775", "₹2000", "₹1500", "₹1800", "₹2000","₹1000", "₹3500", "₹1000", "₹4000"]
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrStudentName.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let viewHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: Constants.Nib.ReusableIdentifier.feeDefaulterHeaderViewTableViewCell) as! FeeDefaulterHeaderViewTableViewCell
        viewHeader.contentView.backgroundColor = UIColor.init(red: 44.0/255.0, green: 154.0/255.0, blue: 243.0/255.0, alpha: 1.0)
        return viewHeader
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Nib.ReusableIdentifier.feeDefaulterTableViewCell) as! FeeDefaulterTableViewCell
        cell.lblFeeName.text = arrStudentName[indexPath.row]
        cell.lblFeeClass.text = arrClass[indexPath.row]
        cell.lblFeeDueAmount.text = arrDueAmount[indexPath.row]
        cell.lblFeeDueDate.text = arrDueDate[indexPath.row]
        cell.selectionStyle = .none
        return cell
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
        let selectedLogin=UserDefaults.standard.string(forKey: Constants.ServerKey.selectedLogin)
        
        //if (selectedLogin == "S")
        if (selectedLogin == "1") //Student
        {
            destViewController = mainStoryboard.instantiateViewController(withIdentifier: Constants.Storybaord.Identifier.dashboard)
            sideMenuController()?.setContentViewController(destViewController)
        }
        //else if(selectedLogin == "E")
        else if(selectedLogin == "2") //Teacher
        {
            destViewController = mainStoryboard.instantiateViewController(withIdentifier: Constants.Storybaord.Identifier.teacherDashboard)
            sideMenuController()?.setContentViewController(destViewController)
        }
        //else if(selectedLogin == "G")
        else if(selectedLogin == "3")
        {
            destViewController = mainStoryboard.instantiateViewController(withIdentifier: Constants.Storybaord.Identifier.parentDashboard)
            sideMenuController()?.setContentViewController(destViewController)
        }
        hideSideMenuView()
    }
}
