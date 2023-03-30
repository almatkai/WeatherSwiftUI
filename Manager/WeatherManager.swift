//
//  WeatherManager.swift
//  Weather2
//
//  Created by Almat Kairatov on 27.03.2023.
//

import Foundation
import Alamofire
import CoreLocation

enum Lang: String, CustomStringConvertible{
    case Eng = "en_US"
    case Rus = "ru_RU"
    case Kaz = "kk_KZ"
    
    var description: String {
            switch self {
            case .Eng:
                return "Eng"
            case .Rus:
                return "Rus"
            case .Kaz:
                return "Kaz"
            }
        }
}

struct WeatherManger{
    let lang: Lang
    private let headers: HTTPHeaders = [
        "X-Yandex-API-Key": "e0dd87d3-66f5-4691-9829-8ad541bdbad2",
    ]
    let lon: Double
    let lat: Double

    func getWeather(completion: @escaping (Weather) -> Void) {
        let url = "https://api.weather.yandex.ru/v2/forecast?lat=\(lat)&lon=\(lon)&lang=\(self.lang.rawValue)"
//        let url = "https://api.weather.yandex.ru/v2/forecast?lat=37.33233141&lon=-122.0312186&lang=ru_RU" //Cupertino
//        let url = "https://api.weather.yandex.ru/v2/forecast?lat=51.160522&lon=71.470360&lang=ru_RU" //Astana
        
        AF.request(url, headers: headers).responseJSON { response in
            switch response.result {
            case .success(let value):
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: value, options: [])
                    let decoder = JSONDecoder()
                    let weather = try decoder.decode(Weather.self, from: jsonData)
                    completion(weather)
                } catch {
                    print("DEBUG WeatherManager: Failed to decode weather data with error: \(error.localizedDescription)")
                }
            case .failure(let error):
                print("DEBUG WeatherManager: Failed to get weather data with error: \(error.localizedDescription)")
            }
        }
    }
}
