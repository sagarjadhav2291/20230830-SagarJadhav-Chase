//
//  Constants.swift
//  SJWeatherApp
//
//  Created by Sagar Jadhav on 29/08/23.
//

import Foundation

struct AppConstants {
    let baseUrlString = "https://api.openweathermap.org/"
    let baseImageUrlString = "https://openweathermap.org/"
    let appid = "837539e206722ed6a1f0338ed2767236"
    func getCityDetailsURL(cityName: String) -> String {
        let urlString = baseUrlString + "/data/2.5/weather?q=" + cityName + "&appid=" + appid + "&units=metric"
        return urlString
    }
    
    func getWeatherImageURL(iconImage: String) -> String {
        let urlString = baseImageUrlString + "/img/wn/" + iconImage + "@2x.png"
        return urlString
    }
}





