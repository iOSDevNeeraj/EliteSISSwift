//
//  HealthReportViewController.swift
//  EliteSISSwift
//
//  Created by Vivek Garg on 03/03/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import UIKit


class HealthReportViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var lblHeading: UILabel!
    @IBOutlet weak var lblStudentName: UILabel!
    @IBOutlet weak var lblBloodGroup: UILabel!
    @IBOutlet weak var lblClass: UILabel!
    @IBOutlet weak var lblWeight: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblHeight: UILabel!
    @IBOutlet weak var lblRecommendations: UILabel!
    @IBOutlet weak var tblViewDetails: UITableView!
    
    var arrProperties = [String]()
    var arrValues = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblViewDetails.register(UINib(nibName:Constants.Nib.NibIdentifier.chapterStatusTableViewCell, bundle:nil), forCellReuseIdentifier: Constants.Nib.ReusableIdentifier.chapterStatusTableViewCell)
        tblViewDetails.separatorStyle = .none
        tblViewDetails.rowHeight = 50
        
        
        arrProperties = ["Vision Index","Behaviour Index","Body Mass Index","Cleanliness Index","Nutrition Index","Smile Index", "Hygiene Index"]
        arrValues = ["6/6","Good", "Normal", "Good", "Good", "Happy", "Good"]
        
        tblViewDetails.dataSource = self
        tblViewDetails.delegate = self
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrProperties.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Nib.ReusableIdentifier.chapterStatusTableViewCell) as! ChapterStatusTableViewCell
        cell.lblChapter.text = arrProperties[indexPath.row]
        cell.lblStatus.text = arrValues[indexPath.row]
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.clear
        cell.lblChapter.font = UIFont.boldSystemFont(ofSize: 16.0)
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
