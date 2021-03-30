//
//  SearchViewModel.swift
//  SearchApp
//
//  Created by ㅇ오ㅇ on 2021/03/28.
//

import UIKit

struct SearchViewModel {
    
    var result: Results?
    
    var userRatingCount: String {//후기 남긴 갯수
        guard let countString = result?.userRatingCount.roundedWithAbbreviations else { return "0" }
        return countString
    }
    
    var userRatingCountTextColor: UIColor {
        return .systemGray
    }
    
    var ratingStarCount: Double { // 별점
        guard let count = result?.averageUserRating else { return 0 }
        let countString = round(count*10)/10
        return countString
    }
    
    var iconImageString: String { //아이콘 이미지
        guard let iconImageString = result?.artworkUrl60 else { return "" }
        return iconImageString
    }
    
    var appMainTitleString: String { // 메인 제목
        guard let appMainTitleString = result?.trackCensoredName else { return ""}
        return appMainTitleString
    }
    
    var screenShot: [String] {
        guard let firstScreenShot = result?.screenshotUrls else { return [""] }
        return firstScreenShot
    }
    
}
