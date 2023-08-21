////
////  TestView.swift
////  YandexWeather
////
////  Created by Almat Kairatov on 17.08.2023.
////
//
//import SwiftUI
//
//struct TestView: View {
//
//    @StateObject var googlePlaceManager = GooglePlaceManager()
//    @State var placesFound: [Place] = []
//    @State var text = ""
//
//    var body: some View {
//
//        VStack{
//            TextField("Search place ...", text: $text)
//                .onChange(of: text, perform: { _ in
//                    googlePlaceManager.findPlaces(query: text) { result in
//                        switch result {
//                        case .failure(let err):
//                            print("ERROR FIND PLACE ERROR: \(err)")
//                        case .success(let places):
//                            placesFound = places
//                        }
//                    }
//                })
//            VStack {
//                ScrollView {
//                    ForEach(placesFound) { place in
//                        VStack(alignment: .leading) {
//                            Text(place.name)
//                                .font(.body)
//                                .foregroundColor(.blue)
//                            Text(place.identifier)
//                            Divider()
//                        }
//                        .onTapGesture {
//                            googlePlaceManager.fetchPlace(placeID: place.identifier)
//                        }
//                    }
//                }
//            }
//            Spacer()
//        }
//    }
//}
//
