//
//  WeatherViewModel.swift
//  Weather2
//
//  Created by Almat Kairatov on 27.03.2023.
//

import Foundation

class WeatherViewModel: ObservableObject {

    @Published var lat = 0.0
    @Published var lon = 0.0
    @Published var isDataFetched = false
    @Published var lang = Lang.Rus
    
    @Published var weather: Weather = Weather()
    
    // MARK: - Fetch Movies
    func getWeather(lon: Double, lat: Double){
        let weatherManger = WeatherManger(lang: lang, lon: lon, lat: lat)
        
        self.lat = lat
        self.lon = lon
        
        weatherManger.getWeather{  weather in
            DispatchQueue.main.async {
                self.weather = weather
                self.isDataFetched = true
            }
        }
    }
}
