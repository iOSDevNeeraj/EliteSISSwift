//
//  TeacherProfileViewController.swift
//  EliteSISSwift
//
//  Created by Reetesh Bajpai on 16/03/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import UIKit
import DropDown
import Alamofire
import SwiftyJSON
import ALLoadingView

class TeacherProfileViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var lblTeacherName: UILabel!
    @IBOutlet weak var tblViewInfo: UITableView!
    var generalDatasource: GeneralInfoDatasource!
    var contactDatasource: ContactInfoDatasource!
    var classAppliedDatasource = ClassAppliedDatasource()
    var qualificationDatasource = QualificationDatasource()
    var addressDatasource: AddressDatasource!
    var identityCardDatasource: IdentityCardDatasource!
    var pickerData: [String] = [String]()
    var dropDownClasses: DropDown!
    
    @IBOutlet weak var imgViewProfile: UIImageView!
    @IBOutlet weak var stackViewProfileChangeOptions: UIStackView!
    let regid = UserDefaults.standard.string(forKey: "_sis_registration_value")!
    var isEditableView = true
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        generalDatasource = GeneralInfoDatasource(isDetailEditable: isEditableView)
        contactDatasource = ContactInfoDatasource(isDetailEditable: isEditableView)
        classAppliedDatasource = ClassAppliedDatasource(isDetailEditable: isEditableView)
        qualificationDatasource = QualificationDatasource(isDetailEditable: isEditableView)
        addressDatasource = AddressDatasource(isDetailEditable: isEditableView)
        identityCardDatasource = IdentityCardDatasource(isDetailEditable: isEditableView)
        
        tblViewInfo.separatorStyle = .none
        
        tblViewInfo.register(UINib(nibName: Constants.Nib.NibIdentifier.textfieldTableViewCell, bundle:nil), forCellReuseIdentifier: Constants.Nib.ReusableIdentifier.textfieldTableCell)
        tblViewInfo.register(UINib(nibName: Constants.Nib.NibIdentifier.textFieldWithCalendarTableViewCell, bundle:nil), forCellReuseIdentifier: Constants.Nib.ReusableIdentifier.textfieldwithCalendarTableCell)
        tblViewInfo.register(UINib(nibName: Constants.Nib.NibIdentifier.dropDownTableViewCell, bundle:nil), forCellReuseIdentifier: Constants.Nib.ReusableIdentifier.dropDownTableViewCell)
        tblViewInfo.register(UINib(nibName: Constants.Nib.NibIdentifier.dateSelectionTableViewCell, bundle:nil), forCellReuseIdentifier: Constants.Nib.ReusableIdentifier.dateSelectionTableViewCell)
        
        pickerData = ["General Info", "Contact Info", "Qualification Detail", "Address Detail"]
        
        self .showLoader()
        DispatchQueue.global().async {
            //Change the base URL here:
            // Alamofire.request("http://43.224.136.81:5015/SIS/GetProfiledetails/" + self.regid).responseJSON { (responseData) -> Void in
            let requestURL = Constants.BASE_URL + Constants.API.getTeacherProfile + self.regid
            print("Teacher Profile URL: \(requestURL)")
            Alamofire.request(requestURL).responseJSON { (responseData) -> Void in
                
                if((responseData.result.value) != nil)
                {
                    self .hideLoader()
                    let swiftyJsonVar = JSON(responseData.result.value!)
                    let profileDataMain = swiftyJsonVar.dictionaryObject! as! [String: String]
                    self.generalDatasource.profileData = profileDataMain
                    self.contactDatasource.profileData = profileDataMain
                    self.classAppliedDatasource.profileData = profileDataMain
                    self.qualificationDatasource.profileData = profileDataMain
                    self.addressDatasource.profileData = profileDataMain
                    self.identityCardDatasource.profileData = profileDataMain
                    // print(swiftyJsonVar)
                    print("Response: \(swiftyJsonVar)")
                    self.tblViewInfo.dataSource = self.generalDatasource
                    self.tblViewInfo.delegate = self
                    self.tblViewInfo.reloadData()
                    self.lblTeacherName.text = profileDataMain["ApplicantFullName"]
                    let decodedData = NSData(base64Encoded: profileDataMain["Entityimage"]!, options: NSData.Base64DecodingOptions(rawValue: 0) )
                    
                    let decodedimage = UIImage(data: decodedData! as Data)
                    self.imgViewProfile.image = decodedimage
                    
                    // Do any additional setup after loading the view.
                    self.configDropDown()
                    self.onInfoCategoryChange(withCategoryIndex: 0)
                }
                else
                {
                    self .hideLoader()
                    let alert = UIAlertController(title: Constants.Alert.errorOccured, message: Constants.Alert.tryAfterSomeTime, preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: Constants.ok, style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
        
        
        // Do any additional setup after loading the view.
        self.configDropDown()
        self.onInfoCategoryChange(withCategoryIndex: 0)
        
        generalDatasource.delegate = self
        
        //Make profile image circular
        self.imgViewProfile.layer.cornerRadius = self.imgViewProfile.bounds.width/2.0
        self.imgViewProfile.clipsToBounds = true
        
        //Hide profile change options
        stackViewProfileChangeOptions.isHidden = true
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configDropDown()
    {
        dropDownClasses = DropDown()
        
        // The view to which the drop down will appear on
        let studentInfoCategoryCell = self.tblViewInfo.cellForRow(at: IndexPath(row: 0, section: 0))
        dropDownClasses.anchorView = studentInfoCategoryCell // UIView or UIBarButtonItem
        
        // The list of items to display. Can be changed dynamically
        dropDownClasses.dataSource = self.pickerData
        
        dropDownClasses.selectionAction = { [unowned self] (index: Int, item: String) in
            self.onInfoCategoryChange(withCategoryIndex: index)
        }
    }
    
    func onTeacherCategoryInfoClick()
    {
        if dropDownClasses.isHidden
        {
            dropDownClasses.show()
            hideSideMenuView()
        }
        else
        {
            dropDownClasses.hide()
        }
    }
    
    func onInfoCategoryChange(withCategoryIndex row: Int)
    {
        if row == 0
        {
            tblViewInfo.dataSource = generalDatasource
            tblViewInfo.reloadData()
        }
        else if row == 1
        {
            tblViewInfo.dataSource = contactDatasource
            tblViewInfo.reloadData()
            
        }
        else if row == 2
        {
            tblViewInfo.dataSource = qualificationDatasource
            tblViewInfo.reloadData()
        }
        else if row == 3
        {
            tblViewInfo.dataSource = addressDatasource
            tblViewInfo.reloadData()
            
        }
        //else if row == 4 {
        //            tblViewInfo.dataSource = addressDatasource
        //            tblViewInfo.reloadData()
        //
        //        }else if row == 5 {
        //            tblViewInfo.dataSource = identityCardDatasource
        //            tblViewInfo.reloadData()
        //
        //        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 45
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if indexPath.row == 0
        {
            self.onTeacherCategoryInfoClick()
        }
    }
    
    @IBAction func showMenu(_ sender: Any)
    {
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
            destViewController = mainStoryboard.instantiateViewController(withIdentifier: Constants.Storybaord.Identifier.teachersviewcontroller)
            sideMenuController()?.setContentViewController(destViewController)
        }
        //else if(selectedLogin == "E") //Teacher
        else if(selectedLogin == "2") //Teacher
        {
            destViewController = mainStoryboard.instantiateViewController(withIdentifier: Constants.Storybaord.Identifier.teacherDashboard)
            sideMenuController()?.setContentViewController(destViewController)
        }
        //else if(selectedLogin == "G") //Parents
        else if(selectedLogin == "3") //Parents
        {
            destViewController = mainStoryboard.instantiateViewController(withIdentifier: Constants.Storybaord.Identifier.parentDashboard)
            sideMenuController()?.setContentViewController(destViewController)
        }
        
        hideSideMenuView()
    }
    
    @IBAction func btnProfilePicClick(_ sender: Any)
    {
        self.stackViewProfileChangeOptions.isHidden = !self.stackViewProfileChangeOptions.isHidden
    }
    
    @IBAction func btnOpenCameraClick(_ sender: Any)
    {
        self.openCamera(vc: self)
    }
    
    @IBAction func btnOpenGalleryClick(_ sender: Any)
    {
        self.openGallery(vc: self)
    }
    
    @IBAction func saveBtnClicked(_ sender: Any)
    {
        
    }
}

extension TeacherProfileViewController: GeneralInfoDelegate, DatePickerProtocol
{
    func showDatePicker()
    {
        let vcPicker = self.storyboard?.instantiateViewController(withIdentifier: Constants.Storybaord.Identifier.datePickerViewController) as! DatePickerViewController
        vcPicker.modalPresentationStyle = .overCurrentContext
        vcPicker.delegate = self
        self.present(vcPicker, animated: true, completion: nil)
    }
    
    func calendarClicked()
    {
        self.showDatePicker()
    }
    
    func dateSelected(date: Date)
    {
        self.setSelectedDate(date: date.format(with: "dd-MMM-yyyy"))
    }
    
    func datePickerCancel()
    {
        
    }
    
    func setSelectedDate(date: String)
    {
        let cell = tblViewInfo.cellForRow(at: IndexPath(row: 2, section: 0)) as! DateSelectionTableViewCell
        cell.lblDate.text = date
    }
}

extension TeacherProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func openGallery(vc: UIViewController) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        vc.present(imagePicker, animated: true, completion: nil)
    }
    
    func openCamera(vc: UIViewController)  {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .camera
        vc.present(imagePicker, animated: true, completion: nil)
    }
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerEditedImage]
        self.imgViewProfile.image = image as? UIImage
        self.dismiss(animated: true, completion: nil)
        self.stackViewProfileChangeOptions.isHidden = true
    }
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
        self.stackViewProfileChangeOptions.isHidden = true
    }
    
    func showLoader()
    {
        // https://www.cocoacontrols.com/controls/alloadingview
        
        ALLoadingView.manager.resetToDefaults()
        ALLoadingView.manager.blurredBackground = true
        ALLoadingView.manager.animationDuration = 1.0
        ALLoadingView.manager.itemSpacing = 30.0
        ALLoadingView.manager.messageText = "Loading...."
        ALLoadingView.manager.showLoadingView(ofType: .messageWithIndicator, windowMode: .fullscreen)
    }
    
    func hideLoader()
    {
        ALLoadingView.manager.hideLoadingView(withDelay: 0.0)
        ALLoadingView.manager.resetToDefaults()
        
    }
}

