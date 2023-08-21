//
//  SideBarView.swift
//  YandexWeather
//
//  Created by Almat Kairatov on 15.08.2023.
//

import SwiftUI
import MapKit
import GooglePlaces

struct SideBarView: View {
    
    @Binding var sidebarShow: Bool
    
    @StateObject var googlePlaceManager = GooglePlaceManager()
    @State var placesFound: [PlaceModel] = []
    @State var text = ""
    
    var width: CGFloat
    var body: some View {
        HStack(spacing: 0){
            VStack{
                VStack {
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
                    Divider()
                    VStack {
                        ScrollView {
                            ForEach(placesFound) { place in
                                Button(action: {
                                    googlePlaceManager.fetchPlace(placeID: place.placeId)
                                }){
                                    VStack(alignment: .leading) {
                                        Text(place.name)
                                            .font(.body)
                                        Divider()
                                    }
                                }
                            }
                        }
                    }
                }
                .padding()
                Spacer()
            }
            .border(width: 2, edges: [.trailing], color: Color("borderSidebar"))
            
            .overlay {
                VStack{
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            
                        }){
                            Image(systemName: "plus.magnifyingglass")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40)
                                .foregroundColor(Color("magnifyingGlass"))
                                .padding(20)
                        }
                    }
                }
            }
            .frame(maxWidth: width, maxHeight: .infinity)
            .background(Color("cardBackGround"))
            .shadow(radius: 10, x: 10)
            Rectangle()
                .ignoresSafeArea()
                .foregroundColor(.clear)
                .frame(maxWidth: width * 0.25, maxHeight: .infinity)
                .contentShape(Rectangle())
                .onTapGesture {
                    withAnimation{
                        sidebarShow = false
                        keyBoardHide()
                    }
                }
        }
        
    }
    
    private func getSearchedPlaceWeather() {
        
    }
}

extension View {
    func border(width: CGFloat, edges: [Edge], color: Color) -> some View {
        overlay(EdgeBorder(width: width, edges: edges).foregroundColor(color).ignoresSafeArea())
    }
}

struct EdgeBorder: Shape {
    var width: CGFloat
    var edges: [Edge]

    func path(in rect: CGRect) -> Path {
        edges.map { edge -> Path in
            switch edge {
            case .top: return Path(.init(x: rect.minX, y: rect.minY, width: rect.width, height: width))
            case .bottom: return Path(.init(x: rect.minX, y: rect.maxY - width, width: rect.width, height: width))
            case .leading: return Path(.init(x: rect.minX, y: rect.minY, width: width, height: rect.height))
            case .trailing: return Path(.init(x: rect.maxX - width, y: rect.minY, width: width, height: rect.height))
            }
        }.reduce(into: Path()) { $0.addPath($1) }
    }
}
