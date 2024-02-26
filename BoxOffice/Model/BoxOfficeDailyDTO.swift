//
//  BoxOfficeDailyDTO.swift
//  BoxOffice
//
//  Created by MAC2020 on 2/19/24.
//

import Foundation

struct BoxOfficeDataResponse: Codable {
    let boxOfficeResult: BoxOfficeResult
}

struct BoxOfficeResult: Codable {
    let boxOfficeType: String
    let showRange: String
    let dailyBoxOfficeList: [DailyBoxOfficeInfo]
    
    enum CodingKeys: String, CodingKey {
        case showRange
        case dailyBoxOfficeList
        case boxOfficeType = "boxofficeType"
    }
}

struct DailyBoxOfficeInfo: Codable, Hashable {
    let number: String
    let rank: String
    let rankFluctuation: String
    let rankOldAndNew: String
    let movieCode: String
    let movieName: String
    let openDate: String
    let salesAmount: String
    let salesShare: String
    let salesFluctuation: String
    let salesChange: String
    let salesAccumulation: String
    let audienceCount: String
    let audienceFluctuation: String
    let audienceChange: String
    let audienceAccumulation: String
    let screenCount: String
    let showCount: String
    
    enum CodingKeys: String, CodingKey {
        case rank, rankOldAndNew, salesShare, salesChange
        case number = "rnum"
        case rankFluctuation = "rankInten"
        case movieCode = "movieCd"
        case movieName = "movieNm"
        case openDate = "openDt"
        case salesAmount = "salesAmt"
        case salesFluctuation = "salesInten"
        case salesAccumulation = "salesAcc"
        case audienceCount = "audiCnt"
        case audienceFluctuation = "audiInten"
        case audienceChange = "audiChange"
        case audienceAccumulation = "audiAcc"
        case screenCount = "scrnCnt"
        case showCount = "showCnt"
    }
}

enum RankOldAndNew: String, Codable {
    case new = "NEW"
    case old = "OLD"
}
