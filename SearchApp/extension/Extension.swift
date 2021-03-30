//
//  Extension.swift
//  SearchApp
//
//  Created by ㅇ오ㅇ on 2021/03/27.
//

import UIKit

class ImageCacheManager { // 이미지를 저장해줄 공간
    
    static let shared = NSCache<NSString, UIImage>()
    
    private init() {}
}

extension UIImageView {
    
    func setImageUrl(_ url: String) {
        
        let cacheKey = NSString(string: url)
        // 캐시에 사용될 Key 값
        
        if let cachedImage = ImageCacheManager.shared.object(forKey: cacheKey) {
            // 해당 Key 에 캐시이미지가 저장되어 있으면 이미지를 사용
            
            self.image = cachedImage
            return
        }
        
        DispatchQueue.global(qos: .background).async {
            if let imageUrl = URL(string: url) {
                URLSession.shared.dataTask(with: imageUrl) { data, response, error in
                    if let _ = error {
                        DispatchQueue.main.async { // UI적으로 변하니깐!!
                            self.image = UIImage()
                        }
                        return
                    }
                    
                    DispatchQueue.main.async { // UI적으로 변하니깐!!
                        if let data = data, let image = UIImage(data: data) {
                            ImageCacheManager.shared.setObject(image, forKey: cacheKey) // 다운로드된 이미지를 캐시에 저장
                            self.image = image
                        }
                    }
                }.resume()
            }
        }
    }
}

extension Int {
    
    var roundedWithAbbreviations: String {
        var number: Double = 0
        var thousand: Double = 0
        var million: Double = 0
        
        if self > 10000 {
            number = Double(self)
            million = number / 10000
        } else if self > 1000 {
            number = Double(self)
            thousand = number / 1000
        }
        
        if million >= 1.0 {
            return "\(round(million*10)/10)만"
        } else if thousand >= 1.0 {
            return "\(round(thousand*10)/10)천"
        } else {
            return "\(self)"
        }
    }
}


