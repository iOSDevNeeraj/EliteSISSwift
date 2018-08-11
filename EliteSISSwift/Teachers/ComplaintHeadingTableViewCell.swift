//
//  ComplaintHeadingTableViewCell.swift
//  EliteSISSwift
//
//  Created by Kunal Das on 14/04/18.
//  Copyright © 2018 Kunal Das. All rights reserved.
//

import UIKit

class ComplaintHeadingTableViewCell: UITableViewCell {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var viewContainer: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        viewContainer.layer.borderWidth = 1
        viewContainer.layer.borderColor = UIColor.black.cgColor
        viewContainer.clipsToBounds = true
    }
    
    override func prepareForReuse() {
        label.text = nil
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
