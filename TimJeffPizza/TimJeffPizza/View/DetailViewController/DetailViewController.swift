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
    @IBOutlet weak var itemTableView: UITableView!
    @IBOutlet weak var itemTableViewParentView: UIView!
    @IBOutlet weak var itemTableViewHeightConstant: NSLayoutConstraint!
    @IBOutlet weak var payBtnParentView: UIView!
    @IBOutlet weak var priceTotalLbl: UILabel!
    @IBOutlet weak var paymentParentView: UIView!
    
    var pizzaData: JeffPizzaListResponseModel?
    var priceArray: [Price] = []
    var priceItemArray: [Price] = []
    var cartPizzaList: [CartPizzaList] = []
    var cartItemPizzaList: [CartPizzaQuantityList] = []
    var totalPriceArry: [Double] = []
    var collectionViewCellWidth: CGFloat = 65.0
    var collectionViewCellHeight: CGFloat = 60.0
    var colllectionViewCellSpace: CGFloat = 10.0
    var counter: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        setupDatas()
        setupPriceCollectionView()
        setupPizzaImageView()
        setupItemTableView()
        setupPayBtnParentView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        addTableviewOberver()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        removeTableviewObserver()
    }
    
    func setupItemTableView() {
        itemTableView.register(UINib(nibName: ItemTableViewCell.identifer, bundle: nil), forCellReuseIdentifier: ItemTableViewCell.identifer)
    }
    
    func setupPayBtnParentView() {
        payBtnParentView.setupViewBorder(cornerRadius: 15, borderWidth: nil, masksToBound: true)
    }
    
    func setupPizzaImageView() {
        pizzaImageView.setupViewBorder(cornerRadius: 15, borderWidth: nil, masksToBound: true)
    }
    
    func setupDatas() {
        titleLabel.text = pizzaData?.name
        ingredientLabel.text = pizzaData?.content
        priceArray = pizzaData?.prices ?? []
        let imageURL = URL(string: pizzaData!.imageURL)!
        pizzaImageView.downloadImage(from: imageURL)
        paymentParentView.isHidden = true
    }
    
    func setupPriceCollectionView() {
        priceCollectionView.register(UINib(nibName: PriceCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: PriceCollectionViewCell.identifier)
    }
    
    @IBAction func backBtnAction(_ sender: UIButton) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addToCartBtnAction(_ sender: UIButton) {
        let filter = priceTotalLbl.text!.filter { char in
            return char != "$"
        }
        let formattedTotal = Int64(Double(filter) ?? Double())
        
        let data = CoreDataManager.shared.fetchData()
        let checkExist = data.map{$0.cartName == pizzaData?.name}
        
        if let index = checkExist.firstIndex(of: true)  {
            CoreDataManager.shared.deleteData(data[index])
        }
        let cart = CartPizzaList(context: CoreDataManager.shared.viewContext)
        cart.cartImage = pizzaData?.imageURL
        cart.cartItemTotal = formattedTotal
        cart.cartName = pizzaData?.name
        cart.cartpizzaquantitylist = NSSet(array: cartItemPizzaList)
        cartPizzaList.append(cart)
        CoreDataManager.shared.save()
        let cartListVc = CartListViewController(nibName: "CartListViewController", bundle: nil)
        self.navigationController?.pushViewController(cartListVc, animated: true)
    }
}

extension DetailViewController: ItemTableViewCellProtocol {
    func plusButtonTapped(cell: ItemTableViewCell) {
        if let indexPath = self.itemTableView.indexPath(for: cell) {
            paymentParentView.isHidden = false
            var count = Int(cell.countLbl.text!) ?? Int()
            count += 1
            cell.countLbl.text = "\(count)"
            let itemTotal = Double(priceItemArray[indexPath.row].price)
            totalPriceArry.append(itemTotal)
            priceTotalLbl.text = "$\(totalPriceArry.reduce(0, +))"
            cartItemPizzaList[indexPath.row].pizzaQuantity = Int64(count)
            CoreDataManager.shared.save()
        }
    }
    
    func minusButtonTapped(cell: ItemTableViewCell) {
        
        if let indexPath = self.itemTableView.indexPath(for: cell) {
            var count = Int(cell.countLbl.text!) ?? Int()
            if priceItemArray.count < 2 && count == 1 {
                paymentParentView.isHidden = true
            }
            if count <= 1 {
                if count > 0 {
                    count -= 1
                    cell.countLbl.text = "\(count)"
                    let itemPrice = Double(priceItemArray[indexPath.row].price)
                    totalPriceArry.append(-itemPrice)
                    priceTotalLbl.text = "$\(totalPriceArry.reduce(0, +))"
                } else {
                    priceItemArray.remove(at: indexPath.row)
                    let index = IndexPath(item: indexPath.row, section: 0)
                    itemTableView.deleteRows(at: [index], with: .right)
                    itemTableView.reloadData()
                    if priceItemArray.count < 1 {
                        paymentParentView.isHidden = true
                    }
                }
            }
            else {
                count -= 1
                cell.countLbl.text = "\(count)"
                let itemPrice = Double(priceItemArray[indexPath.row].price)
                totalPriceArry.append(-itemPrice)
                priceTotalLbl.text = "$\(totalPriceArry.reduce(0, +))"
            }
            
            cartItemPizzaList[indexPath.row].pizzaQuantity = Int64(count)
            CoreDataManager.shared.save()
        }
    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return priceItemArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: ItemTableViewCell?  = tableView.dequeueReusableCell(withIdentifier: ItemTableViewCell.identifer, for: indexPath) as? ItemTableViewCell
        if cell == nil {
            cell = Bundle.main.loadNibNamed(ItemTableViewCell.identifer, owner: self, options: nil)?.first as? ItemTableViewCell
        }
        
        cell?.priceDetails = priceItemArray[indexPath.row]
        cell?.delegate = self
        cell?.selectionStyle = .none
        cell?.preservesSuperviewLayoutMargins = false
        cell?.separatorInset = UIEdgeInsets.zero
        cell?.layoutMargins = UIEdgeInsets.zero
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

//MARK: - Tableview Observer
extension DetailViewController {
    
    private func addTableviewOberver() {
        self.itemTableView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
    }
    
    private func removeTableviewObserver() {
        if self.itemTableView.observationInfo != nil {
            self.itemTableView.removeObserver(self, forKeyPath: "contentSize")
        }
    }
    /**
     This method is used to observeValue in table view.
     */
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if let obj = object as? UITableView {
            if obj == self.itemTableView && keyPath == "contentSize" {
                self.itemTableViewHeightConstant.constant = self.itemTableView.contentSize.height
                self.view.updateConstraints()
                self.view.layoutIfNeeded()
            }
        }
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sizeItem = priceArray[indexPath.row].size
        if priceItemArray.contains(where: {$0.size == sizeItem}) {
        } else {
            paymentParentView.isHidden = false
            let itemTotal = Double(priceArray[indexPath.row].price)
            totalPriceArry.append(itemTotal)
            priceTotalLbl.text = "$\(totalPriceArry.reduce(0, +))"
            priceItemArray.append(priceArray[indexPath.row])
            itemTableView.reloadData()
            if cartPizzaList.contains(where: { cartlist in
                return cartlist.cartName == pizzaData?.name
            }) {
            } else {
                let quantityList = CoreDataManager.shared.createPizzaQuantityList(quantity: 1, size: priceArray[indexPath.row].size)
                cartItemPizzaList.append(quantityList)
            }
        }
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
