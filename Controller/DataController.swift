//
//  DataController.swift
//  YandexWeather
//
//  Created by Almat Kairatov on 22.08.2023.
//

import Foundation
import CoreData

final class DataController: ObservableObject {
    
    let container = NSPersistentContainer(name: "PlaceCD")
    
    init() {
        container.loadPersistentStores { description, err in
            if let err = err {
                print(err.localizedDescription)
            }
        }
    }
}

extension NSManagedObjectContext {
    func saveAll() {
        do {
            try save()
        } catch {
            print(error.localizedDescription)
        }
    }
    func addPlace(placeModel: PlaceModel) {
        let place = Place(context: self) // self -> moc(ManagedObjectContext) is itself context
        place.id = UUID()
        place.city = placeModel.city
        place.cityFulltext = placeModel.cityFulltext
        place.placeId = placeModel.placeId
        place.lat = Double(placeModel.lat)
        place.lon = Double(placeModel.lon)
        
        saveAll()
    }
    
    func deletePlace(_ place: Place) {
        self.delete(place)
    }
}
