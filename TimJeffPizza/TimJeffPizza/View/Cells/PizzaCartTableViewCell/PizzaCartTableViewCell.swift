//
//  PizzaCartTableViewCell.swift
//  TimJeffPizza
//
//  Created by Obeisun Timothy on 10/11/2021.
//

import UIKit
import Foundation

let cartImageCache = NSCache<AnyObject, AnyObject>.sharedInstance

class PizzaCartTableViewCell: UITableViewCell {
    @IBOutlet weak var pizzaImageView: UIImageView!
    @IBOutlet weak var pizzaNameLabel: UILabel!
    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var itemTableView: UITableView!
    
    var itemArray: [CartPizzaQuantityList] = []
    
    
    private var downloadTask: URLSessionDownloadTask?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupParentView()
        setupPizzaImageView()
        setupItemTableView()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupItemTableView() {
        itemTableView.register(UINib(nibName: PizzaCartItemTableViewCell.identifer, bundle: nil), forCellReuseIdentifier: PizzaCartItemTableViewCell.identifer)
        itemTableView.delegate = self
        itemTableView.dataSource = self
    }
    
    func setupPizzaImageView() {
        pizzaImageView.setupViewBorder(cornerRadius: pizzaImageView.frame.size.width / 2, borderWidth: nil, masksToBound: true)
    }
    
    func setupParentView() {
        parentView.layer.cornerRadius = 15
        parentView.layer.shadowColor = UIColor.systemGray.cgColor
        parentView.layer.shadowOffset = CGSize(width: 3, height: 3)
        parentView.layer.shadowRadius = 1.7
        parentView.layer.shadowOpacity = 0.5
    }
    
    func setup(pizza: CartPizzaList?) {
        if let pizza = pizza {
            pizzaNameLabel.text = pizza.cartName
            amountLabel.text = "$\(pizza.cartItemTotal)"
            let fileURL = URL(string: pizza.cartImage ?? "")
            self.downloadItemImageForCartResult(imageURL: fileURL)
            let quantityArr = pizza.cartpizzaquantitylist?.allObjects as? [CartPizzaQuantityList]
            itemArray = quantityArr ?? []
        }
    }
    
    public func downloadItemImageForCartResult(imageURL: URL?) {
        if let urlOfImage = imageURL {
            if let cachedImage = imageCache.object(forKey: urlOfImage.absoluteString as NSString){
                self.pizzaImageView!.image = cachedImage as? UIImage
            } else {
                let session = URLSession.shared
                self.downloadTask = session.downloadTask(
                    with: urlOfImage as URL, completionHandler: { [weak self] url, response, error in
                        if error == nil, let url = url, let data = NSData(contentsOf: url), let image = UIImage(data: data as Data) {
                            DispatchQueue.main.async() {
                                let imageToCache = image
                                if let strongSelf = self, let imageView = strongSelf.pizzaImageView {
                                    imageView.image = imageToCache
                                    cartImageCache.setObject(imageToCache, forKey: urlOfImage.absoluteString as NSString , cost: 1)
                                }
                            }
                        } else {
                            fatalError("ERROR \(error?.localizedDescription ?? String())")
                        }
                    })
                self.downloadTask!.resume()
            }
        }
    }
    
    override public func prepareForReuse() {
        self.downloadTask?.cancel()
        pizzaImageView?.image = UIImage(named: "ImagePlaceholder")
    }
    
    deinit {
        self.downloadTask?.cancel()
        pizzaImageView?.image = nil
    }
    
    static var identifer: String {
        return String(describing: self)
    }
}


extension PizzaCartTableViewCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: PizzaCartItemTableViewCell?  = tableView.dequeueReusableCell(withIdentifier: PizzaCartItemTableViewCell.identifer, for: indexPath) as? PizzaCartItemTableViewCell
        if cell == nil {
            cell = Bundle.main.loadNibNamed(PizzaCartItemTableViewCell.identifer, owner: self, options: nil)?.first as? PizzaCartItemTableViewCell
        }
        
        cell?.setupItem(item: itemArray[indexPath.row])
        cell?.selectionStyle = .none
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}
