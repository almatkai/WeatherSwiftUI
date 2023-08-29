//
//  WeatherViewModel.swift
//  Weather2
//
//  Created by Almat Kairatov on 27.03.2023.
//

import Foundation

class WeatherViewModel: ObservableObject {
    
    @Published var isDataFetched = false
    @Published var lang = Lang.Eng
    @Published var weathers: [Weather] = []
    @Published var currentWeather = Weather()
    @Published var timeZone = ""
    @Published var weatherAndPlaceDict: [Int : Int] = [:]
    @Published var fact = [Fact]()
    
    // MARK: - Fetch Movies
    func getWeather(lon: Double, lat: Double, index: Int = -1, changeLoco: Bool = false){
        let weatherManager = WeatherManger(lang: lang, lon: lon, lat: lat)
        
        weatherManager.getWeather{  weather in
            DispatchQueue.main.async {
                self.weathers.append(weather)
                self.isDataFetched = true
                if index >= 0 {
                    self.weatherAndPlaceDict[index] = self.weathers.count - 1
                }
                self.changeCurrentWeather(index: index, isPlaceCDindex: true)
                
                if changeLoco {
                    self.updateFact()
                }
            }
        }
    }
    
    func changeCurrentWeather(index: Int, isPlaceCDindex: Bool = false) {
        var indx = index
        if isPlaceCDindex {
            indx = self.weatherAndPlaceDict[index] ?? 0
        }
        self.currentWeather = self.weathers[indx]
        self.timeZone = self.currentWeather.info?.tzinfo?.name ?? ""
        self.updateFact()
    }
    
    func updateFact() {
        fact.removeAll()
        if let forecast = self.currentWeather.forecasts?[0]{
            if let hours = forecast.hours {
                self.fact += hours
            }
            if let forecast = self.currentWeather.forecasts?[1]{
                if let hours = forecast.hours {
                    self.fact += hours
                }
            }
        }
    }
}
