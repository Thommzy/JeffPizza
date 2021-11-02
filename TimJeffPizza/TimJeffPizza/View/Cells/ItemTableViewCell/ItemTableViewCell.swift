//
//  ItemTableViewCell.swift
//  TimJeffPizza
//
//  Created by Obeisun Timothy on 02/11/2021.
//

import UIKit

class ItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var sizeLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var minusBtn: UIButton!
    @IBOutlet weak var countLbl: UILabel!
    @IBOutlet weak var plusBtn: UIButton!
    
    var delegate: ItemTableViewCellProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCounterBtns()
    }
    
    var priceDetails: Price? {
        didSet {
            sizeLbl.text = priceDetails?.size
            //priceLbl.text = "$\(priceDetails?.price ?? Double())"
        }
    }
    
    func setupCounterBtns() {
        plusBtn.setupViewBorder(cornerRadius: 10, borderWidth: nil, masksToBound: true)
        minusBtn.setupViewBorder(cornerRadius: 10, borderWidth: nil, masksToBound: true)
    }
    
    @IBAction func minusBtnTapped(_ sender: UIButton) {
        delegate?.minusButtonTapped(cell: self)
    }
    
    @IBAction func plusBtnTapped(_ sender: UIButton) {
        delegate?.plusButtonTapped(cell: self)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    static var identifer: String {
        return String(describing: self)
    }
}
