//
//  ViewController.swift
//  MyPlacesApp
//
//  Created by Василий Метлин on 16.02.2022.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    
    private let searchController = UISearchController(searchResultsController: nil)
    private var filteredPlaces: Results<Place>!
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    //    Results - массив из Realm с данными
    private var places: Results<Place>!
    private var ascendingSorting = true
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var reversedSortedButoon: UIBarButtonItem!
    @IBOutlet weak var myPlacesTableView: UITableView!
    
    //    MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        //        добавляем данные из реалма в массив places
        places = realm.objects(Place.self)
        
        //        Setup the search controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
    }
    @IBAction func sortSelection(_ sender: UISegmentedControl) {
        sorting()
    }
    @IBAction func reversedSorting(_ sender: UIBarButtonItem) {
        ascendingSorting.toggle()
        
        if ascendingSorting {
            reversedSortedButoon.image = UIImage(named: "AZ")
        } else {
            reversedSortedButoon.image = UIImage(named: "ZA")
        }
        sorting()
    }
    
    private func sorting() {
        if segmentedControl.selectedSegmentIndex == 0 {
            places = places.sorted(byKeyPath: "date", ascending: ascendingSorting)
        } else {
            places = places.sorted(byKeyPath: "name", ascending: ascendingSorting)
        }
        myPlacesTableView.reloadData()
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredPlaces.count
        }
        return places.isEmpty ? 0 : places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "reuseCell") as? CustomTableViewCell else { return UITableViewCell() }
        var place = Place()
        if isFiltering {
            place = filteredPlaces[indexPath.row]
        } else {
            place = places[indexPath.row]
        }
        
        cell.nameLabel?.text = place.name
        cell.locationLabel.text = place.locaction
        cell.typeLabel.text = place.type
        //        добавляем логику по изображению заведения
        cell.imageOfPlace.image = UIImage(data: place.imageData!)
        cell.imageOfPlace?.layer.cornerRadius = cell.imageOfPlace.frame.size.height / 2
        cell.imageOfPlace?.clipsToBounds = true
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showDetail", sender: Any?.self)
    }
    
    //    MARK: Delegate
    //    настройка удаления объекта
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let place = places[indexPath.row]
            StorageManager.deleteObject(place)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    //    можно использовать для настройки массива действий по свайпу справа налево
    //    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    //
    //        let place = places[indexPath.row]
    //        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, _ in
    //            StorageManager.deleteObject(place)
    //            tableView.deleteRows(at: [indexPath], with: .automatic)
    //        }
    //
    //        return UISwipeActionsConfiguration(actions: [deleteAction])
    //    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            guard let indexPath = myPlacesTableView.indexPathForSelectedRow else { return }
            let place: Place
            if isFiltering {
                place = filteredPlaces[indexPath.row]
            } else {
                place = places[indexPath.row]
            }
            let newPlaceVC = segue.destination as! NewPlaceViewController
            newPlaceVC.currentPlace = place
        }
    }
    
    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
        
        guard let newPlaceVC = segue.source as? NewPlaceViewController else { return }
        
        newPlaceVC.savePlace()
        myPlacesTableView.reloadData()
    }
    
}

//MARK: UISearchResultsUpdating
extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        filteredPlaces = places.filter("name CONTAINS[c] %@ OR locaction CONTAINS[c] %@", searchText, searchText)
        myPlacesTableView.reloadData()
}
}
