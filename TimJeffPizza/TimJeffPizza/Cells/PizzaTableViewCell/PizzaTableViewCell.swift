//
//  PizzaTableViewCell.swift
//  TimJeffPizza
//
//  Created by Obeisun Timothy on 31/10/2021.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>.sharedInstance

class PizzaTableViewCell: UITableViewCell {
    
    @IBOutlet weak var priceCollectionView: UICollectionView!
    @IBOutlet weak var pizzaImageView: UIImageView!
    @IBOutlet weak var pizzaNameLabel: UILabel!
    @IBOutlet weak var parentView: UIView!
    
    var priceArray: [Price] = []
    private var downloadTask: URLSessionDownloadTask?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupPriceCollectionView()
        setupParentView()
        setupPizzaImageView()
    }
    
    var pizzaItem: JeffPizzaListResponseModel? {
        didSet {
            if let pizzaItem = pizzaItem {
                pizzaNameLabel.text = pizzaItem.name
                let fileURL = URL(string: pizzaItem.imageURL)
                self.downloadItemImageForSearchResult(imageURL: fileURL)
                DispatchQueue.main.async {
                    self.priceArray = pizzaItem.prices
                    self.priceCollectionView.reloadData()
                }
            }
        }
    }
    
    func setupPizzaImageView() {
        pizzaImageView.layer.cornerRadius = pizzaImageView.frame.size.width / 2
        pizzaImageView.layer.masksToBounds = true
    }
    
    func setupParentView() {
        parentView.layer.cornerRadius = 15
        parentView.layer.shadowColor = UIColor.systemGray.cgColor
        parentView.layer.shadowOffset = CGSize(width: 3, height: 3)
        parentView.layer.shadowRadius = 1.7
        parentView.layer.shadowOpacity = 0.5
        
    }
    
    func setupPriceCollectionView() {
        priceCollectionView.register(UINib(nibName: PriceCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: PriceCollectionViewCell.identifier)
        priceCollectionView.delegate = self
        priceCollectionView.dataSource = self
    }
    
    public func downloadItemImageForSearchResult(imageURL: URL?) {
        
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
                                    imageCache.setObject(imageToCache, forKey: urlOfImage.absoluteString as NSString , cost: 1)
                                }
                            }
                        } else {
                            print("ERROR \(error?.localizedDescription ?? String())")
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
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    static var identifer: String {
        return String(describing: self)
    }
}

extension PizzaTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
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

extension PizzaTableViewCell: UICollectionViewDelegateFlowLayout { func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 65, height: 60)
}
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}
