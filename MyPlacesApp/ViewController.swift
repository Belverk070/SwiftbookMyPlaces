//
//  ViewController.swift
//  MyPlacesApp
//
//  Created by Василий Метлин on 16.02.2022.
//

import UIKit

class ViewController: UIViewController {
    
    var places = Place.getPlaces()
    
    //    MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func backSegue(_ segue: UIStoryboardSegue) {}
    
}

// MARK: DataSource to VC
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "reuseCell") as? CustomTableViewCell else { return UITableViewCell() }
        cell.nameLabel?.text = places[indexPath.row].name
        cell.locationLabel.text = places[indexPath.row].locaction
        cell.typeLabel.text = places[indexPath.row].type
        cell.imageOfPlace?.image = UIImage(named: places[indexPath.row].image)
        cell.imageOfPlace?.layer.cornerRadius = cell.imageOfPlace.frame.size.height / 2
        cell.imageOfPlace?.clipsToBounds = true
        return cell
    }
}

