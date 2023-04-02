//
//  UIImageView_FetchImageFromUrl.swift
//  TrueMovieFanIOS
//
//  Created by Fabricio Segovia on 2023-04-01.
//

import UIKit

extension UIImageView {
    
    func fetchUImageFromURL(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
    
}
