//
//  PlaceModel.swift
//  YandexWeather
//
//  Created by Almat Kairatov on 19.08.2023.
//

import Foundation

struct PlaceModel: Identifiable {
    var id = UUID().uuidString
    var name: String = ""
    var placeId: String = ""
    var lat = ""
    var lon = ""
}
