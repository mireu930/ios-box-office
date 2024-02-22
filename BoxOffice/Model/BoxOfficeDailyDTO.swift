//
//  BoxOfficeDailyDTO.swift
//  BoxOffice
//
//  Created by MAC2020 on 2/19/24.
//

import Foundation

struct BoxOfficeResult: Decodable, Identifiable {
    let id: String
    let boxofficeType: String
    let showRange: String
    let dailyBoxOfficeList: [DailyBoxOfficeInfo]
    
    enum CodingKeys: String, CodingKey {
        case boxOfficeResult
    }
    
    enum NestedKeys: String, CodingKey {
        case id
        case boxofficeType
        case showRange
        case dailyBoxOfficeList
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let boxOfficeResult = try container.nestedContainer(keyedBy: NestedKeys.self, forKey: .boxOfficeResult)
        self.id = try boxOfficeResult.decode(String.self, forKey: .id)
        self.boxofficeType = try boxOfficeResult.decode(String.self, forKey: .boxofficeType)
        self.showRange = try boxOfficeResult.decode(String.self, forKey: .showRange)
        self.dailyBoxOfficeList = try boxOfficeResult.decode([DailyBoxOfficeInfo].self, forKey: .dailyBoxOfficeList)
    }
}

struct DailyBoxOfficeInfo: Codable, Identifiable {
    let id: String
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
        case id
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
