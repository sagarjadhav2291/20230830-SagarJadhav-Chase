//
//  SJHomeUsecase.swift
//  SJWeatherApp
//
//  Created by Sagar Jadhav on 28/08/23.
//

import UIKit

protocol SJHomeUseCaseProtocol {
    func getWeatherDetailsForCity(cityName: String, completion: @escaping(Result<SJHomeModel, Error>) -> Void) async
    func getIcon(icon: String, completion: @escaping (Result<UIImage, Error>) -> Void) async
}

class SJHomeUseCase: SJHomeUseCaseProtocol {
    func getWeatherDetailsForCity(cityName: String, completion: @escaping(Result<SJHomeModel, Error>) -> Void) async {
        
        SJHomeProvider().fetchDataForCity(cityName: cityName) { fetchedItems, error in
            if let fetchedItems = fetchedItems {
                completion(.success(fetchedItems))
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }
    
    func getIcon(icon: String, completion: @escaping (Result<UIImage, Error>) -> Void) async {
        
        await SJHomeProvider().fetchImage(iconImage: icon) { result in
            switch result {
            case .success(let image):
                completion(.success(image))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
