//
//  NavigationBar.swift
//  YandexWeather
//
//  Created by Almat Kairatov on 31.03.2023.
//

import SwiftUI

struct NavigationBar: View {
    @EnvironmentObject var weatherViewModel: WeatherViewModel
    
    @Binding var sidebarShow: Bool
    @State var isSearching = false
    @State var cityName: String = ""
    @State var lengthOfSearchBar: CGFloat = 0
    @State var lengthOfCityName: CGFloat = 200

    var body: some View {
        HStack{
            Button {
                withAnimation(.easeOut(duration: 0.4)) {
                    sidebarShow = true
                }
            } label: {
                Image("menu")
                    .sidebarImageCustomModifiers(width: 30)
            }
            Spacer()
            if let localityName = weatherViewModel.geoObject.locality?.name, let countryName = weatherViewModel.geoObject.country?.name {
                Text("\(localityName), \(countryName)")
                    .frame(width: lengthOfCityName, height: 30)
            } else {
                Text("Sorry, data is missing")
                    .frame(width: lengthOfCityName)
            }
            
            if lengthOfSearchBar == 0 {
                Spacer()
            }
            HStack{
                Image(systemName: "magnifyingglass")
                    .sidebarImageCustomModifiers(width: 24)
                    .onTapGesture {
                        if lengthOfSearchBar == 0 {
                            withAnimation{
                                lengthOfSearchBar = 200
                                lengthOfCityName = 0
                            }
                        }else {
                            withAnimation{
                                lengthOfSearchBar = 0
                                lengthOfCityName = 200
                                keyBoardHide()
                            }
                        }
                    }
                TextField("Search the city", text: $cityName)
                    .textFieldStyle(.plain)
                    .autocorrectionDisabled(true)
            }.frame(width: lengthOfSearchBar, height: 30)
                .padding(.horizontal)
            if lengthOfCityName == 0 {
                Spacer()
            }
        }
        .padding(.horizontal)
        .padding(.bottom, 10)
        .background(Color("navBar"))
    }
}
