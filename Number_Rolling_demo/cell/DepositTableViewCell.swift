//
//  DepositTableViewCell.swift
//  Number_Rolling_demo
//
//  Created by Steven on 2022/9/19.
//

import UIKit

protocol DepositCellDelegate {
    func didDeposit()
}

class DepositTableViewCell: UITableViewCell {

    @IBOutlet weak var depositButton: UIButton!
     
    var delegate: DepositCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        depositButton.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func didDeposit(_ sender: Any) {
        delegate?.didDeposit()
    }
    
}
