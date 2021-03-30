//
//  App.swift
//  SearchApp
//
//  Created by ㅇ오ㅇ on 2021/03/27.
//

import Foundation

struct App: Decodable {
    var results: [Results]
}

struct Results: Decodable {
    var screenshotUrls: [String]
    var artworkUrl60: String
    var trackCensoredName: String
    var averageUserRating: Double
    var userRatingCount: Int
}
