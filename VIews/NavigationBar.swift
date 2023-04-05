//
//  NavigationBar.swift
//  YandexWeather
//
//  Created by Almat Kairatov on 31.03.2023.
//

import SwiftUI

struct NavigationBar: View {
    @EnvironmentObject var weatherViewModel: WeatherViewModel
    
    @Binding var xOffSet: CGFloat
    @Binding var changeLang: Bool
    @State var isSearching = false
    @State var cityName: String = ""
    @State var lengthOfSearchBar: CGFloat = 0
    @State var lengthOfCityName: CGFloat = 200

    var body: some View {
        HStack{
            Button {
                withAnimation(.easeOut(duration: 0.4)) {
                    xOffSet = 0
                }
            } label: {
                Image("menu")
                    .sidebarImageCustomModifiers(width: 30)
            }
            Spacer()
            if let localityName = weatherViewModel.geoObject.locality?.name, let countryName = weatherViewModel.geoObject.country?.name {
                Text("\(localityName), \(countryName)")
                    .frame(width: lengthOfCityName)
            } else {
                Text("Sorry, data is missing")
                    .frame(width: lengthOfCityName)
            }
            TextField("Search the city", text: $cityName)
                .frame(width: lengthOfSearchBar, height: 30)
                .background(.green)
            
            Spacer()
            Image(systemName: "magnifyingglass")
                .sidebarImageCustomModifiers(width: 30)
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
                        }
                    }
                }
//            VStack{
//                Text("\(weatherViewModel.lang.description)")
//                    .font(.system(size: 20))
//                    .onTapGesture {
//                        withAnimation{
//                            changeLang.toggle()
//                        }
//                    }
//                if changeLang {
//                    if weatherViewModel.lang.description != "Eng" {
//                        Text(Lang.Eng.description)
//                            .onTapGesture {
//                                weatherViewModel.lang = Lang.Eng
//                            }
//                    }
//                    if weatherViewModel.lang.description != "Rus" {
//                        Text(Lang.Rus.description)
//                            .onTapGesture {
//                                weatherViewModel.lang = Lang.Rus
//                            }
//                    }
//                    if weatherViewModel.lang.description != "Kaz" {
//                        Text(Lang.Kaz.description)
//                            .onTapGesture {
//                                weatherViewModel.lang = Lang.Kaz
//                            }
//                    }
//                }
//            }
            
        }
        .padding(.horizontal)
        .padding(.bottom, 10)
        .background(Color("navBar"))
    }
}
