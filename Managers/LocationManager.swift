//
//  LocationManager.swift
//  YandexWeather
//
//  Created by Almat Kairatov on 28.03.2023.
//

import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    let manager = CLLocationManager ()
    
    @Published var locationManager = CLLocationManager()
    @Published var authorizationStatus = CLAuthorizationStatus.denied
    
    override init() {
        super.init ()
        manager.delegate = self
    }
    func requestLocation () {
        manager.requestWhenInUseAuthorization()
    }
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse:  // Location services are available.
            authorizationStatus = .authorizedWhenInUse
            break
        case .restricted, .denied:  // Location services currently unavailable.
            authorizationStatus = .restricted
            break
        case .notDetermined:        // Authorization not determined yet.
            manager.requestWhenInUseAuthorization()
            break
        default:
            break
        }
    }
}
