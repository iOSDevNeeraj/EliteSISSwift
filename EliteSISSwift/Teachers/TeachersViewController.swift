//
//  TeachersViewController.swift
//  EliteSISSwift
//
//  Created by Reetesh Bajpai on 16/03/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import UIKit

class TeachersViewController: UIViewController, UITableViewDelegate,UITableViewDataSource, TeachersViewActionMethods {
    
    @IBOutlet weak var tblViewTeachers: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tblViewTeachers.separatorStyle = .none
        tblViewTeachers.register(UINib(nibName: Constants.Nib.NibIdentifier.teachersTableViewCell, bundle:nil), forCellReuseIdentifier: Constants.Nib.ReusableIdentifier.teachersTableViewCell)
        tblViewTeachers.register(UINib(nibName:Constants.Nib.NibIdentifier.teachersHeaderView, bundle: nil), forHeaderFooterViewReuseIdentifier: Constants.Nib.ReusableIdentifier.teachersHeaderView)
        tblViewTeachers.sectionHeaderHeight = 50
        tblViewTeachers.rowHeight = UITableViewAutomaticDimension
        tblViewTeachers.delegate = self
        tblViewTeachers.dataSource = self
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Nib.ReusableIdentifier.teachersTableViewCell) as! TeachersTableViewCell
        cell.delegateTeachersMethods = self
        cell.backgroundColor = UIColor.clear
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let viewHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: Constants.Nib.ReusableIdentifier.teachersHeaderView) as! TeachersHeaderView
        viewHeader.contentView.backgroundColor = UIColor.init(red: 44.0/255.0, green: 154.0/255.0, blue: 243.0/255.0, alpha: 1.0)
        return viewHeader
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showTeachersProfile() {
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: Constants.Storybaord.MainStoryboard,bundle: nil)
        var destViewController : TeacherProfileViewController
        destViewController = mainStoryboard.instantiateViewController(withIdentifier: Constants.Storybaord.Identifier.teacherProfileViewController) as! TeacherProfileViewController
        destViewController.isEditableView = false
        sideMenuController()?.setContentViewController(destViewController)
        hideSideMenuView()
    }
    
    func showTeachersChat() {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: Constants.Storybaord.MainStoryboard,bundle: nil)
        var destViewController : UIViewController
        destViewController = mainStoryboard.instantiateViewController(withIdentifier: Constants.Storybaord.Identifier.teacherChatViewController)
        sideMenuController()?.setContentViewController(destViewController)
        hideSideMenuView()
        
        
        //        TeacherChatViewController
    }
    
    func showTeachersSendMsg()
    {
        let alertController = UIAlertController(title: "Write message", message: "", preferredStyle: .alert)
        alertController.addTextField { (textField : UITextField!) -> Void in
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: { alert -> Void in
            
        })
        
        let okAction = UIAlertAction(title: Constants.ok, style: .default, handler: {
            alert -> Void in
            
        })
        
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
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
       // else if(selectedLogin == "G")
        else if(selectedLogin == "3") //Parent
        {
            destViewController = mainStoryboard.instantiateViewController(withIdentifier: Constants.Storybaord.Identifier.parentDashboard)
            sideMenuController()?.setContentViewController(destViewController)
        }
        
        hideSideMenuView()
    }
}
