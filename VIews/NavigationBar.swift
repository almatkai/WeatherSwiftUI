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
            } else {
                Text("Sorry, data is missing")
            }
            Spacer()
            VStack{
                Text("\(weatherViewModel.lang.description)")
                    .font(.system(size: 20))
                    .onTapGesture {
                        withAnimation{
                            changeLang.toggle()
                        }
                    }
                if changeLang {
                    if weatherViewModel.lang.description != "Eng" {
                        Text(Lang.Eng.description)
                            .onTapGesture {
                                weatherViewModel.lang = Lang.Eng
                            }
                    }
                    if weatherViewModel.lang.description != "Rus" {
                        Text(Lang.Rus.description)
                            .onTapGesture {
                                weatherViewModel.lang = Lang.Rus
                            }
                    }
                    if weatherViewModel.lang.description != "Kaz" {
                        Text(Lang.Kaz.description)
                            .onTapGesture {
                                weatherViewModel.lang = Lang.Kaz
                            }
                    }
                }
            }
            
        }
        .padding(.horizontal)
        .padding(.bottom, 10)
        .background(Color("skyBlue"))
    }
}
