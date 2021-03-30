//
//  SearchAppTests.swift
//  SearchAppTests
//
//  Created by ㅇ오ㅇ on 2021/03/31.
//

import XCTest
@testable import SearchApp

class SearchAppTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testMainAnswerViewModel() throws {
        //재가 원하는 값이 나오는 가를 확인 하였습니다.
        let results = Results(screenshotUrls: [""], artworkUrl60: "", trackCensoredName: "", averageUserRating: 4.74596999999999979991116560995578765869140625, userRatingCount: 15876)
        let viewModelTest = SearchViewModel(result: results)
        
        XCTAssertEqual(viewModelTest.ratingStarCount, 4.7)
        
        XCTAssertEqual(viewModelTest.userRatingCount, "1.6만")
    }
    
}
