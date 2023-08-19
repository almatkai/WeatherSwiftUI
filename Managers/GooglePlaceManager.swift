//
//  GooglePlaceManager.swift
//  YandexWeather
//
//  Created by Almat Kairatov on 17.08.2023.
//

import SwiftUI
import GooglePlaces

struct Place: Identifiable {
    var id = UUID().uuidString
    let name: String
    let identifier: String
}

class GooglePlaceManager: ObservableObject {
    
    static let shared = GooglePlaceManager()
    
    private let client = GMSPlacesClient.shared()
    
    enum PlacesError: Error {
        case failedToFind
    }
    
    public func findPlaces(
        query: String,
        completion: @escaping (Result<[Place], Error>) -> Void
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
                    
                    let places: [Place] = res.compactMap {
                        Place(name: $0.attributedFullText.string, identifier: $0.placeID)
                    }
                    completion(.success(places))
                }
    }
    
    func fetchPlace(placeID: String) {
        let fields: GMSPlaceField = GMSPlaceField(arrayLiteral: .name, .placeID, .formattedAddress, .coordinate)

        GMSPlacesClient.shared().fetchPlace(fromPlaceID: placeID, placeFields: fields, sessionToken: nil) { place, error in
            if let error = error {
                print("An error occurred: \(error.localizedDescription)")
                return
            }
            if let place = place {
                print("Name: \(place.name ?? "Unknown")")
                print("Place ID: \(place.placeID ?? "Unknown")")
                print("Formatted Address: \(place.formattedAddress ?? "Unknown")")
                print("Coordinate: \(place.coordinate.latitude), \(place.coordinate.longitude)")
            }
        }
    }
}
