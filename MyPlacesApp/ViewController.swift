//
//  ViewController.swift
//  MyPlacesApp
//
//  Created by Василий Метлин on 16.02.2022.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    
//    Results - массив из Realm с данными
    var places: Results<Place>!
 
    @IBOutlet weak var myPlacesTableView: UITableView!

    //    MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        добавляем данные из реалма в массив places
        places = realm.objects(Place.self)
        
    }
    
    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
        //        кастим на анвинд NewPlaceVC и добавляем в массив новый объект, обновляем таблицу
        guard let newPlaceVC = segue.source as? NewPlaceViewController else { return }
        newPlaceVC.saveNewPlace()
        myPlacesTableView.reloadData()
    }
    
}

// MARK: DataSource to VC
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.isEmpty ? 0 : places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "reuseCell") as? CustomTableViewCell else { return UITableViewCell() }
        
        let place = places[indexPath.row]
        cell.nameLabel?.text = place.name
        cell.locationLabel.text = place.locaction
        cell.typeLabel.text = place.type
        //        добавляем логику по изображению заведения
        cell.imageOfPlace.image = UIImage(data: place.imageData!)
        cell.imageOfPlace?.layer.cornerRadius = cell.imageOfPlace.frame.size.height / 2
        cell.imageOfPlace?.clipsToBounds = true
        return cell
    }
}

