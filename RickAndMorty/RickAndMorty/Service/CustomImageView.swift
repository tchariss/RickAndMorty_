//
//  CustomImageView.swift
//  RickAndMorty
//
//  Created by Tchariss on 16.04.2022.
//

import Foundation
import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

class CustomImageView: UIImageView {
    
    var task: URLSessionDataTask!
    let spinner = UIActivityIndicatorView(style: .medium)
    
    func loadImage(from url: URL) {
        image = nil
        addSpinner()
        
        if let task = task {
            task.cancel()
        }
        
        // Есть ли уже изображение в кэше
        if let imageFromCache = imageCache.object(forKey: url.absoluteString as AnyObject) as? UIImage {
            if let newImage = imageFromCache.resizeImageTo(size: CGSize(width: 120, height: 120)) {
                image = newImage
            }
            spinner.removeFromSuperview()
            return
        }
        
        let request = URLRequest(url: url)
        task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard
                let data = data,
                let newImage = UIImage(data: data)
            else {
                print("Не удалось загрузить сообщение с URL-адреса: \(url)")
                return
            }
            
            // Кэширование для ускорения процесса извлечения данных
            imageCache.setObject(newImage, forKey: url.absoluteString as AnyObject)
            
            DispatchQueue.main.async {
                if let image = newImage.resizeImageTo(size: CGSize(width: 120, height: 120)) {
                    self.image = image
                }
                self.spinner.removeFromSuperview()
            }
        }
        task.resume()
    }
    
    func addSpinner() {
        addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        spinner.startAnimating()
    }
}

// MARK: - Resize image
extension UIImage {
    
    func resizeImageTo(size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        self.draw(in: CGRect(origin: CGPoint.zero, size: size))
        let resizeImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return resizeImage
    }
    
}
