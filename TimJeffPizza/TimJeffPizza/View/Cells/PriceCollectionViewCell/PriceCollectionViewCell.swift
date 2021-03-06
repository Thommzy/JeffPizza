//
//  PriceCollectionViewCell.swift
//  TimJeffPizza
//
//  Created by Obeisun Timothy on 01/11/2021.
//

import UIKit

class PriceCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var sizeLbl: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var parentView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupParentView()
    }
    
    func setupParentView() {
        parentView.setupViewBorder(cornerRadius: 10, borderWidth: nil, masksToBound: true)
    }
    
    var priceDetails: Price? {
        didSet {
            sizeLbl.text = priceDetails?.size
            priceLabel.text = "$\(priceDetails?.price ?? Double())"
        }
    }
    
    static var identifier: String {
        return String(describing: self)
    }
}
