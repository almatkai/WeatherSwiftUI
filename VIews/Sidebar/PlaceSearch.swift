//
//  SideBarSearch.swift
//  YandexWeather
//
//  Created by Almat Kairatov on 22.08.2023.
//

import SwiftUI

struct PlaceSearch: View {
    @ObservedObject var googlePlaceManager: GooglePlaceManager
    @State var text = ""
    @State var placesFound: [PlaceModel] = []
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var places: FetchedResults<Place>
    
    @State var choosenCity = PlaceModel()
    
    var body: some View {
        VStack(spacing: 0){
            TextField("Search place ...", text: $text)
                .autocorrectionDisabled(true)
                .onChange(of: text, perform: { _ in
                    googlePlaceManager.findPlaces(query: text) { result in
                        switch result {
                        case .failure(let err):
                            print("ERROR FIND PLACE ERROR: \(err)")
                        case .success(let places):
                            placesFound = places
                        }
                    }
                })
                .padding(.bottom, 4)
            Divider()
            VStack {
                ScrollView {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(height: 10)
                    ForEach(placesFound) { place in
                        if !places.contains(where: {
                            $0.placeId == place.placeId
                        }){
                            Button(action: {
                                googlePlaceManager.fetchPlace(placeID: place.placeId) { handlerPlace in
                                    choosenCity = handlerPlace
                                    choosenCity.cityFulltext = place.city
                                    moc.addPlace(placeModel: choosenCity)
                                }
                            }){
                                VStack(alignment: .leading) {
                                    Text(place.city)
                                        .font(.body)
                                    Divider()
                                }
                            }
                        }
                    }
                }
            }
        }
        .padding()
    }
}
