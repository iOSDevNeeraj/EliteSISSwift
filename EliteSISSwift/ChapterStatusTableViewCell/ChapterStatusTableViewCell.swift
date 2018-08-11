//
//  ChapterStatusTableViewCell.swift
//  EliteSISSwift
//
//  Created by Kunal Das on 28/02/18.
//  Copyright © 2018 Kunal Das. All rights reserved.
//

import UIKit

class ChapterStatusTableViewCell: UITableViewCell {

    @IBOutlet weak var lblChapter: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
