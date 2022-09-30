//
//  WithdrawTableViewCell.swift
//  Number_Rolling_demo
//
//  Created by Steven on 2022/9/19.
//

import UIKit

protocol WithdrawCellDelegate {
    func didWithdraw(at: IndexPath)
}

extension WithdrawCellDelegate {
    func didWithdraw(at: IndexPath) {
        print("at = \(at)")
    }
}

class WithdrawTableViewCell: UITableViewCell {

    @IBOutlet weak var withdrawLabel: UILabel!
    @IBOutlet weak var withdrawButton: UIButton!
    
    var delegate: WithdrawCellDelegate?
    var cellIndexPath: IndexPath?

    
    override func awakeFromNib() {
        super.awakeFromNib()
        withdrawButton.layer.cornerRadius = 15
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func didWithdraw(_ sender: Any) {
        if cellIndexPath != nil {
            delegate?.didWithdraw(at: cellIndexPath!)
            //感覺無法點擊應該是寫在這
//            withdrawButton.backgroundColor = .gray
//            withdrawButton.isEnabled = false
        }
    }
    
    func setupCell(amount: Float) {
        withdrawLabel.text = String(format: "$ %.0f", amount)
    }
    
    
}
