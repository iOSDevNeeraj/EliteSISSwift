//
//  AssignmentTableViewCell.swift
//  EliteSISSwift
//
//  Created by Kunal Das on 24/02/18.
//  Copyright © 2018 Kunal Das. All rights reserved.
//

import UIKit

class AssignmentTableViewCell: UITableViewCell {

    @IBOutlet weak var btnViewAssignment: UIButton!
    @IBOutlet weak var btnDownloadAssignment: UIButton!
    @IBOutlet weak var lblSubmitDate: PaddingLabel!
    @IBOutlet weak var lblDescription: PaddingLabel!
    @IBOutlet weak var lblIssueDate: PaddingLabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
