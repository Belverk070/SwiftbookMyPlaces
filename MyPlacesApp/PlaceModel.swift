//
//  PlaceModel.swift
//  MyPlacesApp
//
//  Created by Василий Метлин on 16.02.2022.
//

import UIKit
import RealmSwift

class Place: Object {
    
    @objc dynamic var name = ""
    @objc dynamic var locaction: String?
    @objc dynamic var type: String?
    @objc dynamic var imageData: Data?
    @objc dynamic var date = Date()
    @objc dynamic var rating = 0.0

    
//    назначенный инициализатор, обозначается ключевым словом convenience
    convenience init(name: String, location: String?, type: String?, imageData: Data?, rating: Double) {
        self.init()
        self.name = name
        self.locaction = location
        self.type = type
        self.imageData = imageData
        self.rating = rating
    }
}
