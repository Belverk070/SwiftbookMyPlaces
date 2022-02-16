//
//  ViewController.swift
//  MyPlacesApp
//
//  Created by Василий Метлин on 16.02.2022.
//

import UIKit

class ViewController: UIViewController {
    
    let arrayOfCafe = ["Burger Heroes", "Kitchen", "Bonsai", "Дастархан", "Индокитай", "X.O", "Балкан Гриль", "Sherlock Holmes", "Speak Easy", "Morris Pub", "Вкусные истории", "Классик", "Love&Life", "Шок", "Бочка"]
    
    //    MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
}

// MARK: Extenstion to VC
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfCafe.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "reuseCell") else { return UITableViewCell() }
        cell.textLabel?.text = arrayOfCafe[indexPath.row]
        cell.imageView?.image = UIImage(named: arrayOfCafe[indexPath.row])
        return cell
    }
}

