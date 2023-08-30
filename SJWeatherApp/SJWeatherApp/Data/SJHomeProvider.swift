//
//  SJHomeProvider.swift
//  SJWeatherApp
//
//  Created by Sagar Jadhav on 28/08/23.
//

import SwiftUI
protocol SJHomeProviderProtocol {
    func fetchDataForCity(cityName: String, completion: @escaping (SJHomeModel?, Error?) -> Void)
    func fetchImage(iconImage: String, completion: @escaping (Result<UIImage, Error>) -> Void) async
}

class SJHomeProvider: SJHomeProviderProtocol {
    @Published var items: SJWeatherDetails?
    
    func fetchDataForCity(cityName: String, completion: @escaping (SJHomeModel?, Error?) -> Void) {
        Task {
            do {
                guard let url = URL(string: AppConstants().getCityDetailsURL(cityName: cityName)) else { return }
                let (data, _) = try await URLSession.shared.data(from: url)
                let decodedData = try JSONDecoder().decode(SJWeatherDetails.self, from: data)
                completion(self.convertDataModelToDomainModel(dataModel: decodedData), nil)
            } catch {
                completion(nil, error)
            }
        }
    }
    
    func fetchImage(iconImage: String, completion: @escaping (Result<UIImage, Error>) -> Void) async {
        guard let url = URL(string: AppConstants().getWeatherImageURL(iconImage: iconImage)) else {
            return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let uiImage = UIImage(data: data) {
                completion(.success(uiImage))
            }
            
        } catch {
            completion(.failure(error))
        }
    }
    
    func convertDataModelToDomainModel(dataModel: SJWeatherDetails) -> SJHomeModel {
        let domainModel = SJHomeModel(name: dataModel.name ?? "",
                                      timezone: dataModel.timezone ?? 0,
                                      temp: dataModel.main.temp ?? 0,
                                      tempMin: dataModel.main.tempMin ?? 0,
                                      tempMax: dataModel.main.tempMax ?? 0,
                                      pressure: dataModel.main.pressure ?? 0,
                                      humidity: dataModel.main.humidity ?? 0,
                                      description: dataModel.weather[0].description ?? "" ,
                                      wind: Int(dataModel.wind.speed ?? 0),
                                      sunrise: dataModel.sys.sunrise ?? 0,
                                      sunset: dataModel.sys.sunset ?? 0,
                                      visibility: dataModel.visibility ?? 0,
                                      iconId: dataModel.weather[0].icon ?? ""
        )
        return domainModel
    }
    
}
