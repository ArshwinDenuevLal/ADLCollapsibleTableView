//
//  CollapsibleTableViewCell.swift
//  ADLCollapsibleTableView
//
//  Created by Arshwin Denuev Lal P M on 01/03/18.
//  Copyright © 2018 Arshwin Denuev Lal P M. All rights reserved.
//

import UIKit

class CollapsibleTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var buttonToRotate: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
