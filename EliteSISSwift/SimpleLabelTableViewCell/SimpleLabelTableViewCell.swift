//
//  SimpleTableViewCell.swift
//  EliteSISSwift
//
//  Created by Kunal Das on 26/03/18.
//  Copyright © 2018 Kunal Das. All rights reserved.
//

import UIKit

class SimpleLabelTableViewCell: UITableViewCell {

    @IBOutlet weak var lblContent: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
