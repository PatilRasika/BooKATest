//
//  OrderTableCellTableViewCell.swift
//  BookATest
//
//  Created by Rasika on 6/23/18.
//  Copyright © 2018 Rasika. All rights reserved.
//

import UIKit

class OrderTableCellTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var test: UITextField!
    @IBOutlet weak var date: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
