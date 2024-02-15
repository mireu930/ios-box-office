//
//  BoxOfficeTests.swift
//  BoxOfficeTests
//
//  Created by Lee minyeol on 2/14/24.
//

import XCTest
@testable import BoxOffice

final class BoxOfficeTests: XCTestCase {

    func test_인스턴스를통한_Movie타입과Json데이터를_비교했을때_서로같다() {
        // given
        let dailyBoxOfficeList = DailyBoxOfficeInfo(rnum: "1", rank: "1", rankInten: "0", rankOldAndNew: RankOldAndNew(rawValue: "NEW") ?? .new, movieCD: "20199882", movieNm: "경관의 피", openDt: "2022-01-05", salesAmt: "584559330", salesShare: "34.2", salesInten: "584559330", salesChange: "100", salesAcc: "631402330", audiCnt: "64050", audiInten: "64050", audiChange: "100", audiAcc: "69228", scrnCnt: "1171", showCnt: "4416")
        
        let boxOfficeResult = 
        BoxOfficeResult(boxofficeType: "일별 박스오피스", showRange: "20220105~20220105", dailyBoxOfficeList: [dailyBoxOfficeList])
        let movie = BoxOfficeData(boxOfficeResult: boxOfficeResult)
        
        guard let data = JsonData.josnData.data(using: .utf8) else { return }
        //when
        do {
            let jsonData = try JSONDecoder().decode(BoxOfficeData.self, from: data)
        //then
            XCTAssertEqual(movie, jsonData)
        } catch {
            XCTFail()
        }
        
    }

}
