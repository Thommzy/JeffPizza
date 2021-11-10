//
//  PizzaCartItemTableViewCell.swift
//  TimJeffPizza
//
//  Created by Obeisun Timothy on 10/11/2021.
//

import UIKit

class PizzaCartItemTableViewCell: UITableViewCell {

    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setupItem(item: CartPizzaQuantityList?) {
        if let item = item {
            quantityLabel.text = "\(item.pizzaQuantity)"
            sizeLabel.text = item.pizzaSize
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    static var identifer: String {
        return String(describing: self)
    }
}
