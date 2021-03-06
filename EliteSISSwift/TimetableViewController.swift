//
//  TimetableViewController.swift
//  EliteSISSwift
//
//  Created by Reetesh Bajpai on 01/03/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import UIKit
import DropDownMenuKit
import WRCalendarView


class TimetableViewController: UIViewController,FSCalendarDataSource, FSCalendarDelegate,FSCalendarDelegateAppearance,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var MonthViewTimetable: UIView!
    @IBOutlet weak var weekView: WRWeekView!
    @IBOutlet weak var segmentDayWeekMonth: UISegmentedControl!
    
    var titleView: DropDownTitleView!
    var navigationBarMenu: DropDownMenu!
    
    
    @IBOutlet
    weak var calendar: FSCalendar!
    fileprivate let gregorian: Calendar = Calendar(identifier: .gregorian)
    fileprivate lazy var dateFormatter1: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter
    }()
    fileprivate lazy var dateFormatter2: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    //    let fillSelectionColors = ["2018/02/08": UIColor.green, "2018/02/06": UIColor.purple, "2018/02/17": UIColor.gray, "2018/02/21": UIColor.cyan, "2018/02/08": UIColor.green, "2018/02/06": UIColor.purple, "2018/02/17": UIColor.gray, "2018/02/21": UIColor.cyan, "2015/12/08": UIColor.green, "2015/12/06": UIColor.purple, "2015/12/17": UIColor.gray, "2015/12/21": UIColor.cyan]
    
    
    var fillDefaultColors = ["2018/05/14": UIColor.init(red: 153.0/255.0, green: 152/255.0, blue: 255.0/255.0, alpha: 1.0), "2018/05/16": UIColor.init(red: 153.0/255.0, green: 152/255.0, blue: 255.0/255.0, alpha: 1.0), "2018/05/17": UIColor.init(red: 153.0/255.0, green: 152/255.0, blue: 255.0/255.0, alpha: 1.0), "2018/05/18": UIColor.init(red: 153.0/255.0, green: 152/255.0, blue: 255.0/255.0, alpha: 1.0),  "2018/05/21": UIColor.init(red: 153.0/255.0, green: 152/255.0, blue: 255.0/255.0, alpha: 1.0), "2018/05/22": UIColor.init(red: 153.0/255.0, green: 152/255.0, blue: 255.0/255.0, alpha: 1.0) ]
    var selectedRow = "Assignment"
    
    
    // Data model: These strings will be the data for the table view cells
    let eventsToShow: [String] = ["Assignment", "Events", "Games", "Exams"]
    
    // cell reuse id (cells that scroll out of view can be reused)
    let cellReuseIdentifier = "cell"
    
    // don't forget to hook this up from the storyboard
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        
        setupCalendarData()
        MonthViewTimetable.isHidden = true;
        let title = prepareNavigationBarMenuTitleView()
        prepareNavigationBarMenu(title)
        updateMenuContentOffsets()
        
        //add today button
        let rightButton = UIBarButtonItem(title: "Today", style: .plain, target: self, action: #selector(moveToToday))
        navigationItem.rightBarButtonItem = rightButton
        
        //add events
        weekView.addEvent(event: WREvent.make(date: Date(), chunk: 1.hours, title: "Lunch"))
        //        weekView.addEvent(event: WREvent.make(date: Date(), chunk: 1.hours, title: ""))
        //        weekView.addEvent(event: WREvent.make(date: Date().add(90.minutes), chunk: 1.hours, title: "#3"))
        //        weekView.addEvent(event: WREvent.make(date: Date().add(110.minutes), chunk: 1.hours, title: "#4"))
        
        weekView.addEvent(event: WREvent.make(date: Date().add(1.days), chunk: 1.hours, title: "Lunch"))
        weekView.addEvent(event: WREvent.make(date: Date().add(2.days), chunk: 1.hours, title: "Lunch"))
        weekView.addEvent(event: WREvent.make(date: Date().add(3.days), chunk: 1.hours, title: "Lunch"))
        weekView.addEvent(event: WREvent.make(date: Date().add(4.days), chunk: 1.hours, title: "Lunch"))
        weekView.addEvent(event: WREvent.make(date: Date().add(5.days), chunk: 1.hours, title: "Lunch"))
        weekView.addEvent(event: WREvent.make(date: Date().add(6.days), chunk: 1.hours, title: "Lunch"))
        
        calendar.dataSource = self
        calendar.delegate = self
        //calendar.allowsMultipleSelection = true
        calendar.swipeToChooseGesture.isEnabled = true
        calendar.backgroundColor = UIColor.white
        calendar.appearance.caseOptions = [.headerUsesUpperCase,.weekdayUsesSingleUpperCase]
        //        self.view.addSubview(calendar)
        //        self.calendar = calendar
        
        let date = Date()
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyy/MM/dd"
        calendar.select(self.dateFormatter1.date(from: formatter.string(from: date)))
        let todayItem = UIBarButtonItem(title: "TODAY", style: .plain, target: self, action: #selector(self.todayItemClicked(sender:)))
        self.navigationItem.rightBarButtonItem = todayItem
        
        // For UITest
        self.calendar.accessibilityIdentifier = "calendar"
        
        
        
        // Register the table view cell class and its reuse id
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        // (optional) include this line if you want to remove the extra empty cell divider lines
        // self.tableView.tableFooterView = UIView()
        
        // This view controller itself will provide the delegate methods and row data for the table view.
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
    }
    
    
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.eventsToShow.count
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create a new cell if needed or reuse an old one
        let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell!
        
        // set the text from the data model
        cell.textLabel?.text = self.eventsToShow[indexPath.row]
        
        //        let image : UIImage = UIImage(named: "circleEvent.png")!
        //
        //        cell.imageView?.image = image
        cell.imageView?.image = UIImage(named:"circleEvent.png")!.withRenderingMode(.alwaysTemplate)
        //UIImage(named: arrMenuImages[indexPath.row])
        
        if(indexPath.row == 0){
            cell.imageView?.tintColor = UIColor.init(red: 153.0/255.0, green: 152/255.0, blue: 255.0/255.0, alpha: 1.0)
        }
        else if(indexPath.row == 1){
            cell.imageView?.tintColor = UIColor.init(red: 0.0/255.0, green: 204/255.0, blue: 102.0/255.0, alpha: 1.0)
        }
        else if(indexPath.row == 2){
            cell.imageView?.tintColor = UIColor.init(red: 102.0/255.0, green: 0/255.0, blue: 51.0/255.0, alpha: 1.0)
        }
        else if(indexPath.row == 3){
            cell.imageView?.tintColor = UIColor.init(red: 102.0/255.0, green: 102/255.0, blue: 0.0/255.0, alpha: 1.0)
        }
        cell.backgroundColor = .clear
        
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
        
        if(indexPath.row == 0){
            selectedRow = "Assignment"
            fillDefaultColors = ["2018/05/14": UIColor.init(red: 153.0/255.0, green: 152/255.0, blue: 255.0/255.0, alpha: 1.0), "2018/05/16": UIColor.init(red: 153.0/255.0, green: 152/255.0, blue: 255.0/255.0, alpha: 1.0), "2018/05/17": UIColor.init(red: 153.0/255.0, green: 152/255.0, blue: 255.0/255.0, alpha: 1.0), "2018/05/18": UIColor.init(red: 153.0/255.0, green: 152/255.0, blue: 255.0/255.0, alpha: 1.0),  "2018/05/21": UIColor.init(red: 153.0/255.0, green: 152/255.0, blue: 255.0/255.0, alpha: 1.0), "2018/05/22": UIColor.init(red: 153.0/255.0, green: 152/255.0, blue: 255.0/255.0, alpha: 1.0) ]
            //calendar.dataSource = self
            calendar .reloadData()
        }
        else if(indexPath.row == 1){
            selectedRow = "Events"
            fillDefaultColors = ["2018/05/01": UIColor.init(red: 0.0/255.0, green: 204/255.0, blue: 102.0/255.0, alpha: 1.0),  "2018/05/03": UIColor.init(red: 0.0/255.0, green: 204/255.0, blue: 102.0/255.0, alpha: 1.0), "2018/05/13": UIColor.init(red: 0.0/255.0, green: 204/255.0, blue: 102.0/255.0, alpha: 1.0), "2018/05/05": UIColor.init(red: 0.0/255.0, green: 204/255.0, blue: 102.0/255.0, alpha: 1.0), "2018/05/07": UIColor.init(red: 0.0/255.0, green: 204/255.0, blue: 102.0/255.0, alpha: 1.0), "2018/05/09": UIColor.init(red: 0.0/255.0, green: 204/255.0, blue: 102.0/255.0, alpha: 1.0) ]
            calendar .reloadData()
            
        }
        else if(indexPath.row == 2){
            selectedRow = "Games"
            fillDefaultColors = [ "2018/05/02": UIColor.init(red: 102.0/255.0, green: 0/255.0, blue: 51.0/255.0, alpha: 1.0),  "2018/05/06": UIColor.init(red: 102.0/255.0, green: 0/255.0, blue: 51.0/255.0, alpha: 1.0), "2018/05/08": UIColor.init(red: 102.0/255.0, green: 0/255.0, blue: 51.0/255.0, alpha: 1.0), "2018/05/10": UIColor.init(red: 102.0/255.0, green: 0/255.0, blue: 51.0/255.0, alpha: 1.0) ]
            calendar .reloadData()
            //   cell.imageView?.tintColor = UIColor.init(red: 102.0/255.0, green: 0/255.0, blue: 51.0/255.0, alpha: 1.0)
        }
        else if(indexPath.row == 3){
            selectedRow = "Exams"
            fillDefaultColors = ["2018/05/23": UIColor.init(red: 102.0/255.0, green: 102/255.0, blue: 0.0/255.0, alpha: 1.0), "2018/05/24": UIColor.init(red: 102.0/255.0, green: 102/255.0, blue: 0.0/255.0, alpha: 1.0), "2018/05/25": UIColor.init(red: 102.0/255.0, green: 102/255.0, blue: 0.0/255.0, alpha: 1.0), "2018/05/26": UIColor.init(red: 102.0/255.0, green: 102/255.0, blue: 0.0/255.0, alpha: 1.0), "2018/05/28": UIColor.init(red: 102.0/255.0, green: 102/255.0, blue: 0.0/255.0, alpha: 1.0) ]
            calendar .reloadData()
            //cell.imageView?.tintColor = UIColor.init(red: 102.0/255.0, green: 102/255.0, blue: 0.0/255.0, alpha: 1.0)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    @objc func moveToToday() {
        weekView.setCalendarDate(Date(), animated: true)
    }
    
    // MARK: - WRCalendarView
    func setupCalendarData() {
        weekView.setCalendarDate(Date())
        weekView.delegate = self as! WRWeekViewDelegate
    }
    
    // MARK: - DropDownMenu
    func prepareNavigationBarMenuTitleView() -> String {
        titleView = DropDownTitleView(frame: CGRect(x: 0, y: 0, width: 150, height: 40))
        titleView.addTarget(self,
                            action: #selector(willToggleNavigationBarMenu(_:)),
                            for: .touchUpInside)
        titleView.addTarget(self,
                            action: #selector(didToggleNavigationBarMenu(_:)),
                            for: .valueChanged)
        titleView.titleLabel.textColor = UIColor.black
        titleView.title = "Week"
        
        navigationItem.titleView = titleView
        
        return titleView.title!
    }
    
    func prepareNavigationBarMenu(_ currentChoice: String) {
        navigationBarMenu = DropDownMenu(frame: view.bounds)
        navigationBarMenu.delegate = self as! DropDownMenuDelegate
        
        let firstCell = DropDownMenuCell()
        
        firstCell.textLabel!.text = "Week"
        firstCell.menuAction = #selector(choose(_:))
        firstCell.menuTarget = self
        if currentChoice == "Week" {
            firstCell.accessoryType = .checkmark
        }
        
        let secondCell = DropDownMenuCell()
        
        secondCell.textLabel!.text = "Day"
        secondCell.menuAction = #selector(choose(_:))
        secondCell.menuTarget = self
        if currentChoice == "Day" {
            firstCell.accessoryType = .checkmark
        }
        
        navigationBarMenu.menuCells = [firstCell, secondCell]
        navigationBarMenu.selectMenuCell(firstCell)
        
        // If we set the container to the controller view, the value must be set
        // on the hidden content offset (not the visible one)
        //        navigationBarMenu.visibleContentOffset =
        //            navigationController!.navigationBar.frame.size.height + statusBarHeight()
        
        // For a simple gray overlay in background
        navigationBarMenu.backgroundView = UIView(frame: navigationBarMenu.bounds)
        navigationBarMenu.backgroundView!.backgroundColor = UIColor.black
        navigationBarMenu.backgroundAlpha = 0.7
    }
    
    @objc func willToggleNavigationBarMenu(_ sender: DropDownTitleView) {
        if sender.isUp {
            navigationBarMenu.hide()
        } else {
            navigationBarMenu.show()
        }
    }
    
    func updateMenuContentOffsets() {
        //        navigationBarMenu.visibleContentOffset =
        //            navigationController!.navigationBar.frame.size.height + statusBarHeight()
    }
    
    @objc func didToggleNavigationBarMenu(_ sender: DropDownTitleView) {
    }
    
    @objc func choose(_ sender: AnyObject) {
        if let sender = sender as? DropDownMenuCell {
            titleView.title = sender.textLabel!.text
            
            switch titleView.title! {
            case "Week":
                weekView.calendarType = .week
            case "Day":
                weekView.calendarType = .day
            default:
                break
            }
        }
        
        if titleView.isUp {
            titleView.toggleMenu()
        }
    }
    
    func statusBarHeight() -> CGFloat {
        let statusBarSize = UIApplication.shared.statusBarFrame.size
        return min(statusBarSize.width, statusBarSize.height)
    }
    
    @IBAction func DayViewClick(_ sender: Any) {
        
        weekView.calendarType = .day
    }
    
    @IBAction func WeekView(_ sender: Any) {
        weekView.calendarType = .week
    }
    
    @IBAction func segmentselected(_ sender: Any) {
        
        switch segmentDayWeekMonth.selectedSegmentIndex
        {
        case 0:
            weekView.calendarType = .day
            MonthViewTimetable.isHidden = true;
        case 1:
            weekView.calendarType = .week
            MonthViewTimetable.isHidden = true;
        case 2:
            // weekView.calendarType = .week
            MonthViewTimetable.isHidden = false;
        default:
            break
        }        
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
        
        //if (selectedLogin == "student")
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
        //else if(selectedLogin == "parent")
        //else if(selectedLogin == "G")
        else if(selectedLogin == "3") //Parent
        {
            destViewController = mainStoryboard.instantiateViewController(withIdentifier: Constants.Storybaord.Identifier.parentDashboard)
            sideMenuController()?.setContentViewController(destViewController)
        }
        hideSideMenuView()
    }
}

extension TimetableViewController: DropDownMenuDelegate {
    func didTapInDropDownMenuBackground(_ menu: DropDownMenu) {
        titleView.toggleMenu()
    }
}

extension TimetableViewController: WRWeekViewDelegate {
    func view(startDate: Date, interval: Int) {
        print(startDate, interval)
    }
    
    func tap(date: Date) {
        print(date)
    }
    
    func selectEvent(_ event: WREvent) {
        print(event.title)
    }
    
    
    @objc
    func todayItemClicked(sender: AnyObject) {
        self.calendar.setCurrentPage(Date(), animated: false)
    }
    
    //    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
    //        let dateString = self.dateFormatter2.string(from: date)
    //        if self.datesWithEvent.contains(dateString) {
    //            return 1
    //        }
    //
    //        return 0
    //    }
    
    //    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventColorFor date: Date) -> UIColor? {
    //        let dateString = self.dateFormatter2.string(from: date)
    //        if self.datesWithEvent.contains(dateString) {
    //            return UIColor.purple
    //        }
    //        return nil
    //    }
    //
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventDefaultColorsFor date: Date) -> [UIColor]? {
        //   let key = self.dateFormatter2.string(from: date)
        //        if self.datesWithMultipleEvents.contains(key) {
        //            return [UIColor.magenta, appearance.eventDefaultColor, UIColor.black]
        //        }
        return nil
    }
    
    //    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillSelectionColorFor date: Date) -> UIColor? {
    //        let key = self.dateFormatter1.string(from: date)
    //        if let color = self.fillSelectionColors[key] {
    //            return color
    //        }
    //        return appearance.selectionColor
    //    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
        let key = self.dateFormatter1.string(from: date)
        if let color = self.fillDefaultColors[key] {
            return color
        }
        return nil
    }
    
    //    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, borderDefaultColorFor date: Date) -> UIColor? {
    //        let key = self.dateFormatter1.string(from: date)
    //        if let color = self.borderDefaultColors[key] {
    //            return color
    //        }
    //        return appearance.borderDefaultColor
    //    }
    
    //    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, borderSelectionColorFor date: Date) -> UIColor? {
    //        let key = self.dateFormatter1.string(from: date)
    //        if let color = self.borderSelectionColors[key] {
    //            return color
    //        }
    //        return appearance.borderSelectionColor
    //    }
    
    //    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, borderRadiusFor date: Date) -> CGFloat {
    //        if [8, 17, 21, 25].contains((self.gregorian.component(.day, from: date))) {
    //            return 0.0
    //        }
    //        return 1.0
    //    }
    
    func calendar(calendar: FSCalendar!, didSelectDate date: NSDate!) {
        
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        print("did select date \(formatter.string(from: date))")
        
        let myStringafd = formatter.string(from: date)
        
        print(myStringafd)
        //
        
        if (selectedRow == "Assignment" )
        {
            let   dict = ["2018/05/14": "Counting 1 to 10", "2018/05/16": "Counting 10 to 50", "2018/05/17":"Counting 50 to 100", "2018/05/18": "Write A-Z",  "2018/05/21": "Write a-z", "2018/05/22": "Learn Hindi letters"]
            //var dict = ["key1": "value1", "key2": "value2"]
            if dict.keys.contains(myStringafd)
            {
                // contains key
                let alert = UIAlertController(title: "Assignment", message: dict[myStringafd], preferredStyle: .alert)
                let dismiss = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alert.addAction(dismiss)
                self.present(alert, animated: true, completion: nil)
            }
            else
            {
                print("No, it doesn't")
            }
        }
        else if (selectedRow == "Events" )
        {
            let   dict = ["2018/05/01": "Parents teacher meeting", "2018/05/03": "Sports Day","2018/05/13": "Exhibition", "2018/05/05": "Science day", "2018/05/07": "Founders day", "2018/05/09": "Orientation"]
            if dict.keys.contains(myStringafd)
            {
                // contains key
                let alert = UIAlertController(title: "Event", message: dict[myStringafd], preferredStyle: .alert)
                let dismiss = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alert.addAction(dismiss)
                self.present(alert, animated: true, completion: nil)
            }
            else
            {
                print("No, it doesn't")
            }
        }
        else if (selectedRow == "Games" )
        {
            let   dict =   [ "2018/05/02" : "Cricket",  "2018/05/06": "Badminton", "2018/05/08" : "Volleyball", "2018/05/10": "Football" ]
            if dict.keys.contains(myStringafd)
            {
                // contains key
                let alert = UIAlertController(title: "Games", message: dict[myStringafd], preferredStyle: .alert)
                let dismiss = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alert.addAction(dismiss)
                self.present(alert, animated: true, completion: nil)
            }
            else
            {
                print("No, it doesn't")
            }
        }
        else if (selectedRow == "Exams" )
        {
            let   dict =   ["2018/05/23" : "Maths", "2018/05/24" :"Science", "2018/05/25" : "Hindi", "2018/05/26": "English", "2018/05/28":"Sanskrit" ]
            if dict.keys.contains(myStringafd)
            {
                // contains key
                let alert = UIAlertController(title: "Exams", message: dict[myStringafd], preferredStyle: .alert)
                let dismiss = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alert.addAction(dismiss)
                self.present(alert, animated: true, completion: nil)
            }
            else
            {
                print("No, it doesn't")
            }
        }
    }
}
