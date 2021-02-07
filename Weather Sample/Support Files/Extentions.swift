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
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        UIView.transition(with: self, duration: 0.2, options: .transitionCrossDissolve, animations: { self.image = image }, completion: nil)
                    }
                }
            }
        }
    }
}
