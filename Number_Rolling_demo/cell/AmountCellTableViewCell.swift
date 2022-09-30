//
//  AmountCellTableViewCell.swift
//  Number_Rolling_demo
//
//  Created by Steven on 2022/9/18.
//

import UIKit

class AmountCellTableViewCell: UITableViewCell {

    
    @IBOutlet weak var amountLabel: NumberRollingLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
