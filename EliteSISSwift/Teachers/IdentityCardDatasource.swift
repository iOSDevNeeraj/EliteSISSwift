//
//  IdentityCardDatasource.swift
//  EliteSISSwift
//
//  Created by Vivek Garg on 22/03/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import UIKit

class IdentityCardDatasource: NSObject, UITableViewDataSource {
    var profileData = [String: String]()
    var isDetailEditable = true
    
    convenience init(isDetailEditable editable: Bool = true) {
        self.init()
        
        isDetailEditable = editable
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Nib.ReusableIdentifier.dropDownTableViewCell) as! DropDownTableViewCell
            cell.selectionStyle = .none
            cell.lblTitle.text = "Identity Card Details"
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Nib.ReusableIdentifier.textfieldTableCell) as! TextfieldTableViewCell
            cell.textField.placeholder = Constants.PlaceholderText.cardTypePlaceholder
            cell.selectionStyle = .none
            cell.backgroundColor = UIColor.clear
            cell.isUserInteractionEnabled = isDetailEditable
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Nib.ReusableIdentifier.textfieldTableCell) as! TextfieldTableViewCell
            cell.textField.placeholder = Constants.PlaceholderText.cardNumberPlaceholder
            cell.selectionStyle = .none
            cell.backgroundColor = UIColor.clear
            cell.isUserInteractionEnabled = isDetailEditable
            return cell
            
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Nib.ReusableIdentifier.textfieldwithCalendarTableCell) as! TextFieldWithCalendarTableViewCell
            cell.textfield.placeholder = Constants.PlaceholderText.issuedDatePlaceholder
            cell.selectionStyle = .none
            cell.backgroundColor = UIColor.clear
            cell.isUserInteractionEnabled = isDetailEditable
            return cell
            
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Nib.ReusableIdentifier.textfieldwithCalendarTableCell) as! TextFieldWithCalendarTableViewCell
            cell.textfield.placeholder = Constants.PlaceholderText.expiryDatePlaceholder
            cell.selectionStyle = .none
            cell.backgroundColor = UIColor.clear
            cell.isUserInteractionEnabled = isDetailEditable
            return cell
            
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Nib.ReusableIdentifier.textfieldTableCell) as! TextfieldTableViewCell
            cell.textField.placeholder = Constants.PlaceholderText.licensePlaceholder
            cell.selectionStyle = .none
            cell.backgroundColor = UIColor.clear
            cell.isUserInteractionEnabled = isDetailEditable
            return cell
            
        case 6:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Nib.ReusableIdentifier.textfieldTableCell) as! TextfieldTableViewCell
            cell.textField.placeholder = Constants.PlaceholderText.cardDescriptionPlaceholder
            cell.selectionStyle = .none
            cell.backgroundColor = UIColor.clear
            cell.isUserInteractionEnabled = isDetailEditable
            return cell
            
        case 7:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Nib.ReusableIdentifier.textfieldTableCell) as! TextfieldTableViewCell
            cell.textField.placeholder = Constants.PlaceholderText.iDPlaceholder
            cell.selectionStyle = .none
            cell.backgroundColor = UIColor.clear
            cell.isUserInteractionEnabled = isDetailEditable
            return cell
            
        default:
            return UITableViewCell()
        }
    }
}
