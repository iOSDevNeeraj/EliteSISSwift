//
//  NotificationCollectionViewCell.swift
//  EliteSISSwift
//
//  Created by Kunal Das on 28/02/18.
//  Copyright © 2018 Kunal Das. All rights reserved.
//

import UIKit

class NotificationCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var tblViewDetails: UITableView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        tblViewDetails.rowHeight = UITableViewAutomaticDimension
        tblViewDetails.register(UINib(nibName:"NotificationTableViewCell", bundle: nil), forCellReuseIdentifier: "NotificationTableViewCell")
        tblViewDetails.separatorStyle = .none
    }

}
