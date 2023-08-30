//
//  SJHomeUIModel.swift
//  SJWeatherApp
//
//  Created by Sagar Jadhav on 29/08/23.
//

import SwiftUI

struct SJHomeUIModel: Equatable {
    var name: String
    var timezone: Int
    var temp: Double
    var tempMin: Double
    var tempMax: Double
    var pressure: Int
    var humidity: Int
    var description: String
    var wind: Int
    var sunrise: Double
    var sunset: Double
    var visibility: Int
    var iconId: String
    var iconImage: UIImage?
}
