//
//  UIImageView+Extension.swift
//  TimJeffPizza
//
//  Created by Obeisun Timothy on 01/11/2021.
//

import UIKit

extension UIImageView {
    func downloadImage(from url: URL, contentMode mode: ContentMode = .scaleToFill) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix(NSLocalizedString("image", comment: "default Image")),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadImage(from: url, contentMode: mode)
    }
}
