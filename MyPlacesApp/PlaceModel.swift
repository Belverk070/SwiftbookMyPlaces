//
//  PlaceModel.swift
//  MyPlacesApp
//
//  Created by Василий Метлин on 16.02.2022.
//

import UIKit

struct Place {
    
    var name: String
    var locaction: String?
    var type: String?
    var image: UIImage?
    var restrauntImage: String?
    
    static let arrayOfCafe = ["Burger Heroes", "Kitchen", "Bonsai", "Дастархан", "Индокитай", "X.O", "Балкан Гриль", "Sherlock Holmes", "Speak Easy", "Morris Pub", "Вкусные истории", "Классик", "Love&Life", "Шок", "Бочка"]
    
    static func getPlaces() -> [Place] {
        
        var places = [Place]()
        
        for place in arrayOfCafe {
            places.append(Place(name: place, locaction: "Moscow", type: "Cafe", image: nil, restrauntImage: place))
        }
        
        return places
    }
    
}
