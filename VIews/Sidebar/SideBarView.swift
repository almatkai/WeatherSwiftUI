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
    
    @ObservedObject var googlePlaceManager: GooglePlaceManager
    @Binding var sidebarShow: Bool
    @Binding var citySearch: Bool
    var width: CGFloat

    @FetchRequest(sortDescriptors: []) var places: FetchedResults<Place>
    var body: some View {
        HStack(spacing: 0){
            VStack{
                VStack {
                    if citySearch {
                        PlaceSearch(googlePlaceManager: googlePlaceManager)
                            .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                    } else {
                        SidebarCurrentCities(width: width, sidebarShow: $sidebarShow)
                    }
                }
                .rotation3DEffect(.degrees(citySearch ? 180 : 0), axis: (x: 0, y: 1, z: 0))
                
                Spacer()
            }
            .border(width: 2, edges: [.trailing], color: Color("borderSidebar"))
            
            .overlay {
                VStack{
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            withAnimation {
                                citySearch.toggle()
                            }
                        }){
                            Image(systemName: citySearch ? "x.circle" : "plus.magnifyingglass")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                                .foregroundColor(Color("magnifyingGlass"))
                                .padding(20)
                                .rotation3DEffect(.degrees(citySearch ? 180 : 0), axis: (x: 0, y: 1, z: 0))
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
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        citySearch = false
                    }
                }
        }
        
    }
}
