//
//  NewPlaceViewController.swift
//  MyPlacesApp
//
//  Created by Василий Метлин on 17.02.2022.
//

import UIKit

class NewPlaceViewController: UITableViewController {
    
    var newPlace: Place?
    //    логика для установки заглушки для изображения
    var imageIsChanged = false
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var placeName: UITextField!
    @IBOutlet weak var placeLocation: UITextField!
    @IBOutlet weak var placeType: UITextField!
    @IBOutlet weak var placeImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveButton.isEnabled = false
        //        убрали разлиновку заменив его обычным view
        tableView.tableFooterView = UIView()
        //        добавляем action  на placeName, чтобы делать кнопку Save активной/неактивной. За состоянием кнопки следит textFieldChanged
        placeName.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        
    }
    
    //    MARK: TableViewDelegate
    //    настроили скрытие клавиатуры при нажатии на любую ячейку, кроме первой
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if indexPath.row == 0 {
            
            //            Добавляем изображения для отображения в ImagePicker
            let cameraIcon = UIImage(named: "camera")
            let photoIcon = UIImage(named: "photo")
            
            
            let actionSheet = UIAlertController(title: nil,
                                                message: nil,
                                                preferredStyle: .actionSheet)
            let camera = UIAlertAction(title: "Camera", style: .default) { [weak self] _ in
                self?.chooseImagePicker(source: .camera)
            }
            
            //            Устанавливаем нужно изображение по ключу
            camera.setValue(cameraIcon, forKey: "image")
            //            Устаналиваем расположение текста в пикере
            camera.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
            
            
            let photo = UIAlertAction(title: "Photo", style: .default) { [weak self] _ in
                self?.chooseImagePicker(source: .photoLibrary)            }
            
            //            Устанавливаем нужно изображение по ключу
            photo.setValue(photoIcon, forKey: "image")
            //            Устаналиваем расположение текста в пикере
            photo.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
            
            let cancel = UIAlertAction(title: "Cancel", style: .cancel)
            
            actionSheet.addAction(camera)
            actionSheet.addAction(photo)
            actionSheet.addAction(cancel)
            
            present(actionSheet, animated: true)
            
            
        } else {
            view.endEditing(true)
        }
    }
    
    func saveNewPlace() {
        
        //        реализовываем заглушку если изображение не было выбрано
        var image: UIImage?
        if imageIsChanged {
            image = placeImage.image
        } else {
            image = UIImage(named: "imagePlaceholder")
        }
        newPlace = Place(name: placeName.text!, locaction: placeLocation.text, type: placeType.text, image: image, restrauntImage: nil)
    }
    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        
        dismiss(animated: true, completion: nil)
    }
    
}

// MARK: TextFieldDelegate
extension NewPlaceViewController: UITextFieldDelegate {
    
    //    скрываем клавиатуру по нажатию на Done
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //    делаем логику по отображению кнопки Save
    @objc private func textFieldChanged() {
        if placeName.text?.isEmpty == false {
            saveButton.isEnabled = true
        } else {
            saveButton.isEnabled = false
        }
    }
}

//MARK: Work with image
//UIImagePickerControllerDelegate используется для работы с ImagePickerController
extension NewPlaceViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func chooseImagePicker(source: UIImagePickerController.SourceType) {
        //        проверяем источник выбора на доступность
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let imagePicker = UIImagePickerController()
            //            определяем делегирование imagePicker, а делегатом будет сам класс, для этого нужно подписаться на UINavigationControllerDelegate
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            present(imagePicker, animated: true, completion: nil)
        }
    }
    //A set of methods that your delegate object must implement to interact with the image picker interface.
    
    //   struct UIImagePickerController.InfoKey
    // Keys you use to retrieve information from the editing dictionary about the media that the user selected.
    //    набор ключей определяющих тип контента, который выбран пользователем. В нашем случае отредактированное изображение
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        //        берем значение по конкретному ключу структуры info. Свойство структуры определяет тип контента
        
        //        кастим до UIImage
        placeImage.image = info[.editedImage] as? UIImage
        //        настраиваем контент для отображения в UIImageVIew
        placeImage.contentMode = .scaleAspectFill // масштабируем
        placeImage.clipsToBounds = true // обрезаем по границам
        imageIsChanged = true
        dismiss(animated: true, completion: nil) // закрываем imagePickerController
    }
}
