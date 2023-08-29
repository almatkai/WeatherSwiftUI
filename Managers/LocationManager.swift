//
//  LocationManager.swift
//  YandexWeather
//
//  Created by Almat Kairatov on 28.03.2023.
//

import CoreLocation

// I should create separate LocationVM but LocationManager is itself
// not a big thing so I think it is also not a bad option,
// but you can create it as WeatherManager and WeatherVM
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
        case .authorizedWhenInUse:  
            authorizationStatus = .authorizedWhenInUse
            break
        case .restricted, .denied:
            authorizationStatus = .restricted
            break
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
            break
        default:
            break
        }
    }
}
