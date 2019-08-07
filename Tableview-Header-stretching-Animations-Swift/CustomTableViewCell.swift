//
//  CustomTableViewCell.swift
//  StretchableTableViewHeader
//
//  Created by Artoon Solutions Private Limited on 06/06/19.
//  Copyright © 2019 Artoon Solutions Private Limited. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
