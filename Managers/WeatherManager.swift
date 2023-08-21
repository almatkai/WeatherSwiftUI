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
        "X-Yandex-API-Key": "68d5d688-4280-4c47-bd08-fe26f3665f3d",
    ]
    let lon: Double
    let lat: Double

    func getWeather(completion: @escaping (Weather) -> Void) {
        let url = "https://api.weather.yandex.ru/v2/forecast?lat=\(lat)&lon=\(lon)&lang=\(self.lang.rawValue)"
        // URL EXAMPLES
//        let url = "https://api.weather.yandex.ru/v2/forecast?lat=51.509865&lon=-0.118092&lang=ru_Ru" //London
//        let url = "https://api.(аштвукweather.yandex.ru/v2/forecast?lat=49.89220004696588&lon=73.19040375680234&lang=ru_Ru" //Karaganda
//        let url = "https://api.weather.yandex.ru/v2/forecast?lat=37.33233141&lon=-122.0312186&lang=ru_Ru" //Cupertino
//        let url = "https://api.weather.yandex.ru/v2/forecast?lat=51.160522&lon=71.470360&lang=ru_RU" //Astana
        
        AF.request(url, headers: headers).responseJSON { response in
            switch response.result {
            case .success(let value):
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: value, options: [])
                    
                    // MARK: - To Check Whether the data fetched
//                    if let jsonString = String(data: jsonData, encoding: .utf8) {
//                        print("DEBUG jsonData: \(jsonString)")
//                    } else {
//                        print("DEBUG jsonData could not be converted to a string.")
//                    }
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
