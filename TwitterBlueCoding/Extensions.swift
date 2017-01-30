//
//  Extensions.swift
//  TwitterBlueCoding
//
//  Created by James Rochabrun on 1/27/17.
//  Copyright © 2017 James Rochabrun. All rights reserved.
//

import Foundation
import UIKit


let imageCache = NSCache<NSString, UIImage>()
var rgbValue: UInt32 = 0


extension UIImageView {
    
    func loadImageUsingCacheWithURLString(_ URLString: String) {
        
        self.image = nil
        if let cachedImage = imageCache.object(forKey: NSString(string: URLString)) {
            self.image = cachedImage
            return
        }
        
        if  let url = URL(string: URLString) {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                if error != nil {
                    print("ERROR LOADING IMAGES FROM URL: \(error)")
                    return
                }
                DispatchQueue.main.async {
                    if let data = data {
                        if let downloadedImage = UIImage(data: data) {
                            imageCache.setObject(downloadedImage, forKey: NSString(string: URLString))
                            self.image = downloadedImage
                        }
                    }
                }
            }).resume()
        }
    }
}

extension UIColor {
    
    static func hexStringToUIColor(_ hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.characters.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

extension String {
    var length: Int {
        return self.characters.count
    }
}

extension UIButton {
    
     func createCustomButtonWith(title: String ,target:Any, selector:(Selector), borderWidth: CGFloat, cornerRadius: CGFloat, fontSize: CGFloat, inView view:UIView) {
        
        //let button = UIButton()
        self.setTitle(title, for: .normal)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        self.layer.borderColor = UIColor.hexStringToUIColor(Constants.APPColor.buttonBorderWhite).cgColor
        self.layer.borderWidth = borderWidth
        self.layer.cornerRadius = cornerRadius
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: fontSize)
        self.addTarget(target, action: selector, for: .touchUpInside)
        view.addSubview(self)
    }
}

extension UIView {
    
    func createViewGradientwithFrame(_ frame: CGRect, inView view: UIView) {
        
        self.frame = frame
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [UIColor.hexStringToUIColor(Constants.APPColor.orange).cgColor, UIColor.hexStringToUIColor(Constants.APPColor.pink).cgColor]
        self.layer.insertSublayer(gradient, at: 0)
        view.addSubview(self)
    }
    

    
}




