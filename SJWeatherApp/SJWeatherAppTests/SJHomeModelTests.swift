//
//  SJHomeModelTests.swift
//  SJWeatherAppTests
//
//  Created by Sagar Jadhav on 29/08/23.
//

import XCTest
@testable import SJWeatherApp


final class SJHomeModelTests: XCTestCase {

    func testSJHomeModelNameEquality() throws {
        let sjHomeModel = getSJHomeModel()
        let anotherSJHomeModel = getSJHomeModel()
        XCTAssertEqual(sjHomeModel.name, anotherSJHomeModel.name)
    }
    
    func testSJHomeModelDescriptionEquality() throws {
        let sjHomeModel = getSJHomeModel()
        let anotherSJHomeModel = getSJHomeModel()
        XCTAssertEqual(sjHomeModel.description, anotherSJHomeModel.description)
    }
    
    func testSJHomeModelIconEquality() throws {
        let sjHomeModel = getSJHomeModel()
        let anotherSJHomeModel = getSJHomeModel()
        XCTAssertEqual(sjHomeModel.iconId, anotherSJHomeModel.iconId)
    }
    
    private func getSJHomeModel() -> SJHomeModel {
        return SJHomeModel(name: "Pune", timezone: 0, temp: 10, tempMin: 10, tempMax: 20, pressure: 5, humidity: 5, description: "Cloudy", wind: 5, sunrise: 12000, sunset: 16000, visibility: 6, iconId: "default")
    }

}
