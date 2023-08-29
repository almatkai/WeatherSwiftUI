//
//  PlaceModel.swift
//  YandexWeather
//
//  Created by Almat Kairatov on 19.08.2023.
//

import Foundation

struct PlaceModel: Identifiable {
    var id = UUID().uuidString
    var city: String = ""
    var cityFulltext: String = ""
    var placeId: String = ""
    var lat = 0.0
    var lon = 0.0
}
