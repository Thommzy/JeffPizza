//
//  PopupViewController.swift
//  TimJeffPizza
//
//  Created by Obeisun Timothy on 02/11/2021.
//

import UIKit

class PopupViewController: UIViewController {
    
    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var noBtn: UIButton!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var yesBtn: UIButton!
    
    var isMarried: Bool?
    var totalPrice: String?
    var pizzaName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        calcDiscount(totalPrice: totalPrice)
        setupView()
        setupBtns()
        setupMovieImageView()
        setupParentView()
    }
    
    func calcDiscount(totalPrice: String?) {
        let temp = totalPrice ?? String()
        let filter = temp.filter { char in
            return char != "$"
        }
        let initialPrice = Double(filter) ?? Double()
        if initialPrice > 12.0 {
            //Offer Discount
            if isMarried! {
                descriptionLbl.text = "Buy up to $\(initialPrice + 5.0) and get a free Movie Ticket"
                movieImageView.isHidden = false
            } else {
                descriptionLbl.text = "Buy up to $\(initialPrice + 5.0) and get 5% off"
                movieImageView.isHidden = true
            }
        } else {
            descriptionLbl.text = "Are you sure you want to make this Order"
            descriptionLbl.font = .systemFont(ofSize: 25)
        }
    }
    
    func setupParentView() {
        parentView.setupViewBorder(cornerRadius: 15, borderWidth: nil, masksToBound: true)
    }
    
    func setupMovieImageView() {
        movieImageView.setupViewBorder(cornerRadius: movieImageView.frame.size.width / 2, borderWidth: nil, masksToBound: true)
    }
    
    func setupBtns() {
        noBtn.setupViewBorder(cornerRadius: 10, borderWidth: nil, masksToBound: true)
        yesBtn.setupViewBorder(cornerRadius: 10, borderWidth: nil, masksToBound: true)
    }
    
    func setupView() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(tap)
    }
    
    @objc func viewTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func noBtnAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func yesBtnAction(_ sender: UIButton) {
        let summaryVc = SummaryViewController(nibName: NSLocalizedString("summaryViewController", comment: "summaryViewController"), bundle: nil)
        summaryVc.pizzaName = pizzaName
        summaryVc.totalPrice = totalPrice
        self.navigationController?.pushViewController(summaryVc, animated: true)
    }
}
