//
//  QualificationDatasource.swift
//  EliteSISSwift
//
//  Created by Vivek Garg on 22/03/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import UIKit

class QualificationDatasource: NSObject, UITableViewDataSource {
    var profileData = [String: String]()
    var isDetailEditable = true
    
    convenience init(isDetailEditable editable: Bool = true) {
        self.init()
        isDetailEditable = editable
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Nib.ReusableIdentifier.dropDownTableViewCell) as! DropDownTableViewCell
            cell.selectionStyle = .none
            cell.lblTitle.text = "Qualification Detail"
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Nib.ReusableIdentifier.textfieldTableCell) as! TextfieldTableViewCell
            cell.textField.placeholder = Constants.PlaceholderText.qualificationPlaceholder
            cell.textField.text = profileData["QualificationName"]
            cell.selectionStyle = .none
            cell.backgroundColor = UIColor.clear
            cell.isUserInteractionEnabled = isDetailEditable
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Nib.ReusableIdentifier.textfieldTableCell) as! TextfieldTableViewCell
            cell.textField.placeholder = Constants.PlaceholderText.yearPlaceholder
            cell.textField.text = profileData["Year"]
            cell.selectionStyle = .none
            cell.backgroundColor = UIColor.clear
            cell.isUserInteractionEnabled = isDetailEditable
            return cell
            
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Nib.ReusableIdentifier.textfieldTableCell) as! TextfieldTableViewCell
            cell.textField.placeholder = Constants.PlaceholderText.percentagePlaceholder
            cell.textField.text = profileData["CGPA"]
            cell.selectionStyle = .none
            cell.backgroundColor = UIColor.clear
            cell.isUserInteractionEnabled = isDetailEditable
            return cell
            
            
        default:
            return UITableViewCell()
        }
        
        return UITableViewCell()
    }
}
