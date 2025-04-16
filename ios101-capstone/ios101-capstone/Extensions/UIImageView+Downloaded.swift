//
//  UIImageView+Downloaded.swift
//  ios101-capstone
//
//  Created by Benjamin Nguyen on 4/13/25.
//  Credit to Leo Dabus: https://stackoverflow.com/a/27712427
//

import UIKit
import Apollo
import ApolloSQLite
import AniListAPI

extension UIImageView {
    
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode

        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard
                let self = self,
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }
        
        task.resume()
    }
    
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
