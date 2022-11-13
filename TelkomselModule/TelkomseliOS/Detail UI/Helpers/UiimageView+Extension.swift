//
//  UiimageView+Extension.swift
//  TelkomseliOS
//
//  Created by Amin faruq on 11/11/22.
//

import UIKit

extension UIImageView {
    func setImageFromURL(stringUrl: URL) {
        if let url = URL(string: stringUrl.absoluteString) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                // Error handling...
                guard let imageData = data else { return }
                
                DispatchQueue.main.async {
                    self.image = UIImage(data: imageData)
                }
            }.resume()
        }
    }
}

