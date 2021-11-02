//
//  DetailViewController.swift
//  TimJeffPizza
//
//  Created by Obeisun Timothy on 01/11/2021.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var ingredientLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceCollectionView: UICollectionView!
    @IBOutlet weak var pizzaImageView: UIImageView!
    @IBOutlet weak var payBtn: UIButton!
    
    var pizzaData: JeffPizzaListResponseModel?
    var priceArray: [Price] = []
    var collectionViewCellWidth: CGFloat = 65.0
    var collectionViewCellHeight: CGFloat = 60.0
    var colllectionViewCellSpace: CGFloat = 10.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDatas()
        setupPriceCollectionView()
        setupPizzaImageView()
        setupPayBtn()
    }
    
    func setupPayBtn() {
        payBtn.layer.cornerRadius = 15
        payBtn.layer.masksToBounds = true
    }
    
    func setupPizzaImageView() {
        pizzaImageView.layer.cornerRadius = pizzaImageView.frame.size.width / 2
        pizzaImageView.layer.masksToBounds = true
    }
    
    func setupDatas() {
        titleLabel.text = pizzaData?.name
        ingredientLabel.text = pizzaData?.content
        priceArray = pizzaData?.prices ?? []
        let imageURL = URL(string: pizzaData!.imageURL)!
        pizzaImageView.downloadImage(from: imageURL)
    }
    
    func setupPriceCollectionView() {
        priceCollectionView.register(UINib(nibName: PriceCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: PriceCollectionViewCell.identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    @IBAction func backBtnAction(_ sender: UIButton) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func payBtnAction(_ sender: UIButton) {
        print("Pay Now!")
    }
}


extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return priceArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PriceCollectionViewCell.identifier, for: indexPath) as? PriceCollectionViewCell
        cell?.priceDetails = priceArray[indexPath.row]
        cell?.layoutIfNeeded()
        return cell!
    }
}

extension DetailViewController: UICollectionViewDelegateFlowLayout { func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionViewCellWidth, height: collectionViewCellHeight)
}
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let totalCellWidth = collectionViewCellWidth * CGFloat(priceArray.count)
        let totalSpacingWidth = colllectionViewCellSpace * CGFloat(priceArray.count - 1)
        let leftInset = (priceCollectionView.frame.size.width - CGFloat(totalCellWidth + totalSpacingWidth)) / 2
        let rightInset = leftInset
        return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return colllectionViewCellSpace
    }
}
