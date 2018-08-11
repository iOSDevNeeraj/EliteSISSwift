//
//  NotificationTableViewCell.swift
//  EliteSISSwift
//
//  Created by Kunal Das on 07/03/18.
//  Copyright © 2018 Kunal Das. All rights reserved.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {

    @IBOutlet weak var lblClass: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblAssignment: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
