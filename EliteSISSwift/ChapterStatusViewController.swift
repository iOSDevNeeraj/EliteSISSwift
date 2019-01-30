//
//  ChapterStatusViewController.swift
//  EliteSISSwift
//
//  Created by Vivek Garg on 28/02/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import UIKit

class ChapterStatusViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tblViewChapterStatus: UITableView!
    var arrChapter = [String]()
    var arrStatus = [String]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        tblViewChapterStatus.delegate = self
        tblViewChapterStatus.dataSource = self
        tblViewChapterStatus.separatorStyle = .none
        tblViewChapterStatus.sectionHeaderHeight = 45
        tblViewChapterStatus.rowHeight = 45
        
        tblViewChapterStatus.register(UINib(nibName:Constants.Nib.NibIdentifier.chapterStatusHeaderReusableView, bundle: nil), forHeaderFooterViewReuseIdentifier: Constants.Nib.ReusableIdentifier.chapterStatusHeaderReusableView)
        tblViewChapterStatus.register(UINib(nibName:Constants.Nib.NibIdentifier.chapterStatusTableViewCell, bundle:nil), forCellReuseIdentifier: Constants.Nib.ReusableIdentifier.chapterStatusTableViewCell)
        
        arrChapter = ["Chapter 1","Chapter 2","Chapter 3","Chapter 4","Chapter 5","Chapter 6","Chapter 7","Chapter 8","Chapter 9","Chapter 10"]
        arrStatus = ["Completed", "Completed", "Completed", "In Progress", "Completed", "Completed","Not Started", "Completed", "Completed", "In Progress"]
        
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrChapter.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let viewHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: Constants.Nib.ReusableIdentifier.chapterStatusHeaderReusableView) as! ChapterStatusHeaderReusableView
        viewHeader.contentView.backgroundColor = UIColor.init(red: 44.0/255.0, green: 154.0/255.0, blue: 243.0/255.0, alpha: 1.0)
        return viewHeader
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Nib.ReusableIdentifier.chapterStatusTableViewCell) as! ChapterStatusTableViewCell
        cell.lblChapter.text = arrChapter[indexPath.row]
        cell.lblStatus.text = arrStatus[indexPath.row]
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
        destViewController = mainStoryboard.instantiateViewController(withIdentifier: Constants.Storybaord.Identifier.studyProgressViewController)
        sideMenuController()?.setContentViewController(destViewController)
        //destsideMenuAnimationType = 0
        // sideMenuController()
        
        hideSideMenuView()
    }
}
