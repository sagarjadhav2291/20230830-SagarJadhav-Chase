//
//  SJLocationUtils.swift
//  SJWeatherApp
//
//  Created by Sagar Jadhav on 28/08/23.
//

import Foundation
import CoreLocation

class SJLocationUtils: NSObject {
    static let shared = SJLocationUtils()
    private var currentLocationNotification: ((String) -> Void)?
    private var locationManager = CLLocationManager()

    private override init() {
        super.init()
    }

    func startUpdatingLocation(currentLocationUpdate: @escaping (String) -> Void) {
        currentLocationNotification = currentLocationUpdate
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyReduced
    }
}

extension SJLocationUtils: CLLocationManagerDelegate {

    func locationManager(
        _ manager: CLLocationManager,
        didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        case .restricted, .denied, .notDetermined:
            break
        @unknown default:
            break
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            let location = CLLocation(latitude: latitude, longitude: longitude)
            
            CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
                if error != nil {
                    return
                } else if let city = placemarks?.first?.locality {
                    if let cityUpdate = self.currentLocationNotification {
                        cityUpdate(city)
                    }
                }
            })
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    }
}
