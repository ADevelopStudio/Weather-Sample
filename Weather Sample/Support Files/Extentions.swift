//
//  Extentions.swift
//  Weather Sample
//
//  Created by Dmitrii Zverev on 6/2/21.
//

import UIKit

extension UIImageView {
    func load(url: URL?) {
        guard let  url = url else {return}
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {self?.image = image}
                }
            }
        }
    }
}
