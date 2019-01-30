//
//  AddressDatasource.swift
//  EliteSISSwift
//
//  Created by Vivek Garg on 22/03/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import UIKit

class AddressDatasource: NSObject, UITableViewDataSource {
    var profileData = [String: String]()
    var isDetailEditable = true
    
    convenience init(isDetailEditable editable: Bool = true) {
        self.init()
        
        isDetailEditable = editable
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Nib.ReusableIdentifier.dropDownTableViewCell) as! DropDownTableViewCell
            cell.selectionStyle = .none
            cell.lblTitle.text = "Address Detail"
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Nib.ReusableIdentifier.textfieldTableCell) as! TextfieldTableViewCell
            
            cell.textField.text = profileData["HouseNo"]
            cell.selectionStyle = .none
            cell.backgroundColor = UIColor.clear
            cell.isUserInteractionEnabled = isDetailEditable
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Nib.ReusableIdentifier.textfieldTableCell) as! TextfieldTableViewCell
            cell.textField.placeholder = Constants.PlaceholderText.addressTypePlaceholder
            cell.textField.text = profileData["AddressType"]
            cell.selectionStyle = .none
            cell.backgroundColor = UIColor.clear
            cell.isUserInteractionEnabled = isDetailEditable
            
            return cell
            
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Nib.ReusableIdentifier.textfieldTableCell) as! TextfieldTableViewCell
            cell.textField.placeholder = Constants.PlaceholderText.cityPlaceholder
            cell.textField.text = profileData["City"]
            cell.selectionStyle = .none
            cell.backgroundColor = UIColor.clear
            cell.isUserInteractionEnabled = isDetailEditable
            return cell
            
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Nib.ReusableIdentifier.textfieldTableCell) as! TextfieldTableViewCell
            cell.textField.placeholder = Constants.PlaceholderText.statePlacehlder
            cell.textField.text = profileData["State"]
            cell.selectionStyle = .none
            cell.backgroundColor = UIColor.clear
            cell.isUserInteractionEnabled = isDetailEditable
            return cell
            
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Nib.ReusableIdentifier.textfieldTableCell) as! TextfieldTableViewCell
            cell.textField.placeholder = Constants.PlaceholderText.countryPlaceholder
            cell.textField.text = profileData["Country"]
            cell.selectionStyle = .none
            cell.backgroundColor = UIColor.clear
            cell.isUserInteractionEnabled = isDetailEditable
            return cell
            
        case 6:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Nib.ReusableIdentifier.textfieldTableCell) as! TextfieldTableViewCell
            cell.textField.placeholder = Constants.PlaceholderText.postalCodePlaceholder
            cell.textField.text = profileData["PostalCode"]
            cell.selectionStyle = .none
            cell.backgroundColor = UIColor.clear
            cell.isUserInteractionEnabled = isDetailEditable
            return cell
            
        default:
            return UITableViewCell()
        }
        
    }
}
