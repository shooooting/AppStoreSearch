//
//  Service.swift
//  SearchApp
//
//  Created by ㅇ오ㅇ on 2021/03/26.
//

import UIKit

class Service {
    
    static func searchApp(searchText: String, completion: @escaping (App?, Error?) -> Void) {
        
        let str = "https://itunes.apple.com/search?term=\(searchText)&entity=software&country=KR&media=software"
        guard let encoded = str.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        guard let queryURL = URL(string: encoded) else { return }
        let requestURL = URLRequest(url: queryURL)
        
        
        let task = URLSession.shared.dataTask(with: requestURL) { (data, response, error) in

            guard error == nil else { return print("error") }
            guard let data = data else { return print("data error")}

            do {
                let completionData = try JSONDecoder().decode(App.self, from: data)
                completion(completionData, nil)
            } catch {
                print("DEBUG: searchApp Error \(error.localizedDescription)")
                completion(nil, error)
            }
        }
        task.resume()
        
    }
}
