//
//  NewPlaceViewController.swift
//  MyPlacesApp
//
//  Created by Василий Метлин on 17.02.2022.
//

import UIKit

class NewPlaceViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        убрали разлиновку заменив его обычным view
        tableView.tableFooterView = UIView()
        
    }
    
//    MARK: TableViewDelegate
    
//    настроили скрытие клавиатуры при нажатии на любую ячейку, кроме первой
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            
        } else {
            view.endEditing(true)
        }
    }
}

// MARK: TextFieldDelegate
extension NewPlaceViewController: UITextFieldDelegate {
    
//    скрываем клавиатуру по нажатию на Done
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
