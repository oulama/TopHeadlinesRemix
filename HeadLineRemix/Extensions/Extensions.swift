//
//  Extensions.swift
//  HeadLineRemix
//
//  Created by Hamza DOUMARI on 1/20/20.
//  Copyright © 2020 Hamza DOUMARI. All rights reserved.
//

import Foundation
import UIKit

let imageCache = NSCache<AnyObject, UIImage>()

extension UIImageView{
    func setImage(from url: String){
        image = nil
        if let imageFromCache = imageCache.object(forKey: url as AnyObject){
            DispatchQueue.main.async {
                self.image = imageFromCache
            }
            return
        }
        let defaultSession = URLSession(configuration: .default)
        defaultSession.dataTask(with: URL(string: url)!) { (data, response, error) in
            
            if error == nil,let data = data {
                DispatchQueue.main.async {
                    let imageToCache = UIImage(data: data)
                    imageCache.setObject(imageToCache!, forKey: url as AnyObject)
                    self.image = imageToCache
                }
            }else{
                DispatchQueue.main.async {
                    self.image = UIImage(named: "MissingImage")
                }
            }
        }.resume()
    }

}

extension String{
    func dateFormatter(from oldFormat: String, to newFormat: String) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = oldFormat
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = newFormat
        guard let newDate = dateFormatterGet.date(from: self) else{ return self }
        return dateFormatterPrint.string(from: newDate)
    }
}
