//
//  WeatherViewModel.swift
//  Weather2
//
//  Created by Almat Kairatov on 27.03.2023.
//

import Foundation

class WeatherViewModel: ObservableObject {

    @Published var forecasts = [Forecast]()
    @Published var fact = Fact()
    @Published var geoObject = GeoObject()
    @Published var yesterday = Yesterday()
    @Published var info = Info()
    @Published var isDataFetched = false
    @Published var lang = Lang.Eng
    
    // MARK: - Fetch Movies
    func getWeather(lon: Double, lat: Double){
        let weatherManger = WeatherManger(lang: lang, lon: lon, lat: lat)
            weatherManger.getWeather{  weather in
                DispatchQueue.main.async {
                    self.forecasts = weather.forecasts ?? []
                    self.fact = weather.fact ?? Fact()
                    self.yesterday = weather.yesterday ?? Yesterday()
                    self.geoObject = weather.geo_object ?? GeoObject()
                    self.info = weather.info ?? Info()
                    self.isDataFetched = true
                }
            }
    }
}
