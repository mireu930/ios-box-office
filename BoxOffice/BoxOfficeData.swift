
import Foundation

struct BoxOfficeData: Codable {
    let boxOfficeResult: BoxOfficeResult
}

// MARK: - BoxOfficeResult
struct BoxOfficeResult: Codable {
    let boxofficeType, showRange: String
    let dailyBoxOfficeList: [DailyBoxOfficeList]
    
    enum CodingKeys: String, CodingKey {
        case showRange, dailyBoxOfficeList
        case boxOfficeType = "boxofficeType"
    }
}

// MARK: - DailyBoxOfficeList
struct DailyBoxOfficeList: Codable {
    let number, rank, rankFluctuation, rankOldAndNew: String
    let movieCode, movieName, openDate: String
    let salesAmount, salesShare, salesFluctuation, salesChange, salesAccumulation: String
    let audienceCount, audienceFluctuation, audienceChange, audienceAccumulation: String
    let screenCount, showCount: String

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
