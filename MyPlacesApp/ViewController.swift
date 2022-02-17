//
//  ViewController.swift
//  MyPlacesApp
//
//  Created by Василий Метлин on 16.02.2022.
//

import UIKit

class ViewController: UIViewController {
    
    //    для обновления таблицы
    @IBOutlet weak var myPlacesTableView: UITableView!
    
//    var places = Place.getPlaces()
    
    //    MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
        //        кастим на анвинд NewPlaceVC и добавляем в массив новый объект, обновляем таблицу
        guard let newPlaceVC = segue.source as? NewPlaceViewController else { return }
        newPlaceVC.saveNewPlace()
//        places.append(newPlaceVC.newPlace!)
        myPlacesTableView.reloadData()
    }
    
}

// MARK: DataSource to VC
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return places.count
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "reuseCell") as? CustomTableViewCell else { return UITableViewCell() }
        
//        let place = places[indexPath.row]
        
//        cell.nameLabel?.text = place.name
//        cell.locationLabel.text = place.locaction
//        cell.typeLabel.text = place.type
//        //        добавляем логику по изображению заведения
//        if place.image == nil {
//            cell.imageOfPlace?.image = UIImage(named: place.restrauntImage!)
//        } else {
//            cell.imageOfPlace.image = place.image
//        }
        cell.imageOfPlace?.layer.cornerRadius = cell.imageOfPlace.frame.size.height / 2
        cell.imageOfPlace?.clipsToBounds = true
        return cell
    }
}

