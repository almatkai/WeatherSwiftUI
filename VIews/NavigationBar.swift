//
//  NavigationBar.swift
//  YandexWeather
//
//  Created by Almat Kairatov on 31.03.2023.
//

import SwiftUI

struct NavigationBar: View {
    
    @EnvironmentObject var weatherVM: WeatherViewModel
    @Binding var sidebarShow: Bool
    @State var isSearching = false
    @State var cityName: String = ""
    @State var lengthOfSearchBar: CGFloat = 0
    @State var lengthOfCityName: CGFloat = 200
    
    @Binding var citySearch: Bool

    var body: some View {
        HStack{
            Button {
                withAnimation(.easeOut(duration: 0.4)) {
                    sidebarShow = true
                }
            } label: {
                Image("menu")
                    .imageModifier(width: 30)
            }
            Spacer()
            if let localityName = weatherVM.currentWeather.geo_object?.locality?.name,
                let countryName = weatherVM.currentWeather.geo_object?.country?.name {
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
                    .imageModifier(width: 24)
                    .onTapGesture {
                        citySearch = true
                        withAnimation{
                            sidebarShow = true
                        }
                    }
            }.frame(width: lengthOfSearchBar, height: 30)
                .padding(.horizontal)
            if lengthOfCityName == 0 {
                Spacer()
            }
        }
        .padding(.horizontal)
        .padding(.bottom, 10)
        .padding(.top, 5)
        .background(Color("navBar"))
    }
}
