//
//  SJHomeUIModelTests.swift
//  SJWeatherAppTests
//
//  Created by Sagar Jadhav on 29/08/23.
//

import XCTest
@testable import SJWeatherApp

final class SJHomeUIModelTests: XCTestCase {

    func testSJHomeModelNameEquality() throws {
        let sjHomeUIMOdel = getSJHomeUIModel()
        let anotherSJHomeUIModel = getSJHomeUIModel()
        XCTAssertEqual(sjHomeUIMOdel, anotherSJHomeUIModel)
    }
    
    
    private func getSJHomeUIModel() -> SJHomeUIModel {
        return SJHomeUIModel(name: "Pune", timezone: 0, temp: 10, tempMin: 10, tempMax: 20, pressure: 5, humidity: 5, description: "Cloudy", wind: 5, sunrise: 12000, sunset: 16000, visibility: 6, iconId: "default")
    }

}
