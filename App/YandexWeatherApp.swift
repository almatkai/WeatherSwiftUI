//
//  YandexWeatherApp.swift
//  YandexWeather
//
//  Created by Almat Kairatov on 28.03.2023.
//

import SwiftUI
import GooglePlaces

@main
struct YandexWeatherApp: App {
    
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    @UIApplicationDelegateAdaptor private var appDelegate: YandexWeatherAppDelegate
    
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .environmentObject(WeatherViewModel())
                .environment(\.screenWidth, screenWidth)
                .environment(\.screenHeight, screenHeight)
        }
    }
}

struct ScreenWidthKey: EnvironmentKey {
    static let defaultValue: CGFloat? = nil
}
struct ScreenHeightKey: EnvironmentKey {
    static let defaultValue: CGFloat? = nil
}
extension EnvironmentValues {
    var screenWidth: CGFloat? {
        get { self[ScreenWidthKey.self] }
        set { self[ScreenWidthKey.self] = newValue }
    }
    var screenHeight: CGFloat? {
        get { self[ScreenHeightKey.self] }
        set { self[ScreenHeightKey.self] = newValue }
    }
}

class YandexWeatherAppDelegate: NSObject, UIApplicationDelegate, ObservableObject {
    func application(_ application: UIApplication,didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {

    }
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // get api key from here: https://console.cloud.google.com/google/maps-apis/credentials
        GMSPlacesClient.provideAPIKey("GOOGLE-PLACES-API-KEY")
        return true
    }
}
