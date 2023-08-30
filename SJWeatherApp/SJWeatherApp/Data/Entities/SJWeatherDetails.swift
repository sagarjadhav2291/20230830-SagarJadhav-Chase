//
//  SJWeatherDetails.swift
//  SJWeatherApp
//
//  Created by Sagar Jadhav on 29/08/23.
//

import SwiftUI

struct SJWeatherDetails: Decodable {
    let id: Int?
    let name: String?
    let cod: Int?
    let base: String?
    let visibility: Int?
    let dt: Int?
    let timezone: Int?
    let coord: Coord
    let weather: [Weather]
    let main: Main
    let wind: Wind
    let clouds: Clouds
    let sys: Sys
}

struct Coord: Codable {
    let lon, lat: Double?
}

struct Weather: Codable {
    let id: Int?
    let main, description, icon: String?
}

struct Main: Codable {
    let temp: Double?
    let pressure, humidity: Int?
    let tempMin, tempMax: Double?
    
    enum CodingKeys: String, CodingKey {
        case temp, pressure, humidity
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}

struct Wind: Codable {
    let speed: Double?
    let deg: Int?
}

struct Clouds: Codable {
    let all: Int?
}

struct Sys: Codable {
    let type, id: Int?
    let message: Double?
    let country: String?
    let sunrise, sunset: Double?
}
