//
//  SJHomeViewModelTests.swift
//  SJWeatherAppTests
//
//  Created by Sagar Jadhav on 29/08/23.
//

import XCTest
@testable import SJWeatherApp

final class SJHomeViewModelTests: XCTestCase {
    @MainActor func testConversionOfDomainToUIModel() {
        let viewModel = SJHomeViewModel()
        
        let model = viewModel.convertDomainToUIModel(domain: SJHomeModel(name: "Pune", timezone: 0, temp: 10, tempMin: 10, tempMax: 20, pressure: 5, humidity: 5, description: "Cloudy", wind: 5, sunrise: 12000, sunset: 16000, visibility: 6, iconId: "default"))
        
        let anotherModel = viewModel.convertDomainToUIModel(domain: SJHomeModel(name: "Pune", timezone: 0, temp: 10, tempMin: 10, tempMax: 20, pressure: 5, humidity: 5, description: "Cloudy", wind: 5, sunrise: 12000, sunset: 16000, visibility: 6, iconId: "default"))
        
        XCTAssertEqual(model, anotherModel)
    }
}
