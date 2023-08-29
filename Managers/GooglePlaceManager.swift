//
//  GooglePlaceManager.swift
//  YandexWeather
//
//  Created by Almat Kairatov on 17.08.2023.
//

import SwiftUI
import GooglePlaces

class GooglePlaceManager: ObservableObject {
    
    static let shared = GooglePlaceManager()
    
    private let client = GMSPlacesClient.shared()
    
    enum PlacesError: Error {
        case failedToFind
    }
    
    public func findPlaces(
        query: String,
        completion: @escaping (Result<[PlaceModel], Error>) -> Void
    ) {
            let filter = GMSAutocompleteFilter()
            filter.type = .city
            client.findAutocompletePredictions(
                fromQuery: query,
                filter: filter,
                sessionToken: nil) {   (res, error) in
                    guard let res = res, error == nil
                    else {
                        completion(.failure(PlacesError.failedToFind))
                        return
                    }
                    
                    let places: [PlaceModel] = res.compactMap {
                        PlaceModel(city: $0.attributedFullText.string, placeId: $0.placeID)
                    }
                    completion(.success(places))
                }
    }
    
    func fetchPlace(placeID: String, handler: @escaping(PlaceModel) -> Void) {
        let fields: GMSPlaceField = GMSPlaceField(arrayLiteral: .name, .placeID, .formattedAddress, .coordinate)

        GMSPlacesClient.shared().fetchPlace(fromPlaceID: placeID, placeFields: fields, sessionToken: nil) { place, error in
            if let error = error {
                print("An error occurred: \(error.localizedDescription)")
                return
            }
            if let place = place {
                handler(PlaceModel(
                    cityFulltext: place.formattedAddress ?? "Unknown",
                    placeId: place.placeID ?? "Unknown",
                    lat: place.coordinate.latitude,
                    lon: place.coordinate.longitude
                ))
            }
        }
    }
}
