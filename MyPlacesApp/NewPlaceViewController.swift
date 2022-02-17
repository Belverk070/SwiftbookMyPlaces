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
            let actionSheet = UIAlertController(title: nil,
                                                message: nil,
                                                preferredStyle: .actionSheet)
            let camera = UIAlertAction(title: "Camera", style: .default) { _ in
                self.chooseImagePicker(source: .camera)
            }
            
            let photo = UIAlertAction(title: "Photo", style: .default) { _ in
                self.chooseImagePicker(source: .photoLibrary)            }
            
            let cancel = UIAlertAction(title: "Cancel", style: .cancel)
            
            actionSheet.addAction(camera)
            actionSheet.addAction(photo)
            actionSheet.addAction(cancel)
            
            present(actionSheet, animated: true)
            
            
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

//MARK: Work with image

extension NewPlaceViewController {
    
    func chooseImagePicker(source: UIImagePickerController.SourceType) {
        //        проверяем источник выбора на доступность
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let imagePicker = UIImagePickerController()
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
}
