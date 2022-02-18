//
//  StorageManager.swift
//  MyPlacesApp
//
//  Created by Василий Метлин on 17.02.2022.
//

import RealmSwift

let realm = try! Realm()

// менеджер для сохранения новых объектов в БД
class StorageManager {
    static func saveObject(_ place: Place) {
        try! realm.write {
            realm.add(place)
        }
    }
}
