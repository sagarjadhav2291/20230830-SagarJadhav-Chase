//
//  SJHomeViewModel.swift
//  SJWeatherApp
//
//  Created by Sagar Jadhav on 28/08/23.
//

import UIKit
import CoreLocation

@MainActor
class SJHomeViewModel: ObservableObject {
    @Published var viewModel: SJHomeUIModel?
    var locationManager: LocationManager
    @Published var imageCache: ImageCache?
    @Published var currentCity: String = ""
    @Published var showAlert = false
    @Published var isLoading = false
    @Published var dataReceived = false

    init(locationManager: LocationManager) {
        self.locationManager = locationManager
        self.locationManager.requestAuthorization()
    }
    
    func getUserCurrentCityWithLocation() {
        SJLocationUtils.shared.startUpdatingLocation(currentLocationUpdate: { [self] currentCityName in
            currentCity = currentCityName
        })
    }
    @MainActor
    func performSearch(_ searchText: String) async {
        isLoading = true
        UserDefaults.standard.setValue(searchText, forKey: "lastCity")
        
        do {
            try await getHomeData(cityName: searchText) { result in
            }
        }
        catch {
        }
    }
    
    @MainActor
    func getHomeData(cityName: String, completion: @escaping(Result<SJHomeUIModel, Error>) -> Void) async throws {
        dataReceived = false

        await SJHomeUseCase().getWeatherDetailsForCity(cityName: cityName) { [self] result in
            switch result {
            case .success(let model):
                DispatchQueue.main.async {
                    self.viewModel = self.convertDomainToUIModel(domain: model)
                    self.showAlert = false
                    self.dataReceived = true
                }
            case .failure:
                DispatchQueue.main.async {
                    self.showAlert = true
                    self.dataReceived = false
                    self.isLoading = false
                }
                break
            }
        }
    }

    @MainActor
    func getIcon(icon: String, completion: @escaping (Result<UIImage, Error>) -> Void) async {
        await SJHomeUseCase().getIcon(icon: icon) { result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self.viewModel?.iconImage = image
                    self.imageCache?.setImage(image, forKey: self.viewModel?.iconId ?? "wind")
                    self.showAlert = false
                }

            case .failure:
                DispatchQueue.main.async {
                    self.showAlert = true
                }
                break
            }
        }
    }
    
    func convertDomainToUIModel(domain: SJHomeModel) -> SJHomeUIModel {
        let uiModel = SJHomeUIModel(name: domain.name,
                                    timezone: domain.timezone,
                                    temp: domain.temp,
                                    tempMin: domain.tempMin,
                                    tempMax: domain.tempMax,
                                    pressure: domain.pressure,
                                    humidity: domain.humidity,
                                    description: domain.description,
                                    wind: domain.wind,
                                    sunrise: domain.sunrise,
                                    sunset: domain.sunset,
                                    visibility: domain.visibility,
                                    iconId: domain.iconId
        )
        return uiModel
    }
    
    func stringTimeFromUnix(value: Double?) -> String {
        var time = "00:00"
        if let unixDate = value {
            let date = Date(timeIntervalSince1970: unixDate)
            let dateFormatter = DateFormatter()
            dateFormatter.timeStyle = DateFormatter.Style.short
            dateFormatter.locale = Locale(identifier: "en_US")
            time = dateFormatter.string(from: date)
        }
        return time
    }
    
}

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private var locationManager = CLLocationManager()
    
    override init() {
        super.init()
        locationManager.delegate = self
        
    }
    
    func requestAuthorization() {
        locationManager.requestWhenInUseAuthorization()
    }
}


