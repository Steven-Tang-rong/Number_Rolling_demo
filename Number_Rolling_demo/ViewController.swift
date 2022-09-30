//
//  ViewController.swift
//  Number_Rolling_demo
//
//  Created by Steven on 2022/9/18.
//

import UIKit

class ViewController: UIViewController {
 
    @IBOutlet weak var mainTableView: UITableView!
    
    let amount: [Float] = [1000, 2000, 3000, 5000, 10000, 20000]
    
    var accountValue: Float = 50000.0
    var amountCell: AmountCellTableViewCell?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainTableView.delegate = self
        mainTableView.dataSource = self
        
        setupCell()
    }
    
    func setupCell() {
        let amountNib = UINib(nibName: "AmountCellTableViewCell", bundle: nil)
        let withdrawNib = UINib(nibName: "WithdrawTableViewCell", bundle: nil)
        let depositNib = UINib(nibName: "DepositTableViewCell", bundle: nil)
        
        mainTableView.register(amountNib, forCellReuseIdentifier: "amountNib")
        mainTableView.register(withdrawNib, forCellReuseIdentifier: "withdrawNib")
        mainTableView.register(depositNib, forCellReuseIdentifier: "depositNib")
        
        //mainTableView.tableFooterView = UIView()
    }

}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return amount.count
        }else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        let row = indexPath.row
        
        if section == 0 {
            amountCell = tableView.dequeueReusableCell(withIdentifier: "amountNib", for: indexPath) as? AmountCellTableViewCell
            amountCell?.amountLabel.text = String(format: "$ %.0f", accountValue)
            amountCell?.selectionStyle = .none
            
            return amountCell!
        } else if section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "withdrawNib", for: indexPath) as? WithdrawTableViewCell
            
            cell?.delegate = self
            cell?.cellIndexPath = indexPath
            
            cell?.withdrawButton.backgroundColor = UIColor(red: 67/255, green: 193/255, blue: 200/255, alpha: 1)
            cell?.withdrawButton.isEnabled = true
            
            if row <= amount.count {
                cell?.setupCell(amount: amount[row])
            }

            cell?.selectionStyle = .none
            return cell!
        } else {
            let depositCell = tableView.dequeueReusableCell(withIdentifier: "depositNib", for: indexPath) as! DepositTableViewCell
            depositCell.delegate = self
            depositCell.selectionStyle = .none
            
            return depositCell
        }
        
    }
    
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 140
        }else if indexPath.section == 2 {
            return 100
        }else {
            return 50
        }
    }
}


extension ViewController: WithdrawCellDelegate, DepositCellDelegate {
    func didWithdraw(at: IndexPath) {
        
        if accountValue >= 999.0 {
            accountValue -= amount[at.row]
            amountCell?.amountLabel.countFromCurrent(to: accountValue, duration: 1)
        }
        
        if let indexPathsForVisibleRows = mainTableView.indexPathsForVisibleRows {
                for indexPath in indexPathsForVisibleRows {
                    print("cellIndexPath.row = \(indexPath.row)")
                    
                    let cell = mainTableView.cellForRow(at: indexPath) as? WithdrawTableViewCell

                    
                    if accountValue <= amount[indexPath.row] - 1 {
                        cell?.withdrawButton.backgroundColor = .gray
                        cell?.withdrawButton.isEnabled = false
                        
                        print("accountValue = \(accountValue), \namount[at.row] = \(amount[indexPath.row]) ")

                    }
                }
            }
        
    }
    
    func didDeposit() {
        accountValue = 50000.0
        amountCell?.amountLabel.countFromCurrent(to: 50000.0, duration: 1)
        
        mainTableView.reloadData()
    }
    
    
}
