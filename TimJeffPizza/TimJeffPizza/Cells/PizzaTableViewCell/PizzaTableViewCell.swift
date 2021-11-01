//
//  PizzaTableViewCell.swift
//  TimJeffPizza
//
//  Created by Obeisun Timothy on 31/10/2021.
//

import UIKit

class PizzaTableViewCell: UITableViewCell {
    
    @IBOutlet weak var priceCollectionView: UICollectionView!
    @IBOutlet weak var pizzaImageView: UIImageView!
    @IBOutlet weak var pizzaNameLabel: UILabel!
    
    var priceArray: [Price] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupPriceCollectionView()
    }
    
    var pizzaItem: JeffPizzaListResponseModel? {
        didSet {
            if let pizzaItem = pizzaItem {
                pizzaNameLabel.text = pizzaItem.name
            }
        }
    }
    
    func setupPriceCollectionView() {
        priceCollectionView.register(UINib(nibName: "", bundle: nil), forCellWithReuseIdentifier: "")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    static var identifer: String {
        return String(describing: self)
    }
}
