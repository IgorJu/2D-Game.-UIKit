//
//  SettingsViewController.swift
//  2D Game
//
//  Created by Igor on 21.09.2023.
//

import UIKit

class SettingsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var userNameLabel: UILabel!
    
    @IBOutlet var userPhotoImageView: UIImageView! {
        didSet {
            userPhotoImageView.layer.cornerRadius = userPhotoImageView.frame.height / 2
            userPhotoImageView.contentMode = .scaleAspectFill
            userPhotoImageView.layer.borderColor = UIColor.white.cgColor
            userPhotoImageView.layer.borderWidth = 2
        }
    }
    
   private let storageManager = StorageManager.shared
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGradient()
        storageManager.loadUserName(userNameLabel)
        storageManager.loadUserPhoto(imageView: userPhotoImageView)
        
    }
    
    //MARK: - @IBActions
    
    @IBAction func editName() {
        alert()
    }
    
    
    @IBAction func addAvatar() {
        selectImage()
    }
    
    //MARK: - Private funcs
    
    private func alert() {
        let alert = UIAlertController(
            title: "Введите имя игрока",
            message: "",
            preferredStyle: .alert
        )
        
        alert.addTextField { (textField) in
            textField.placeholder = "Имя пользователя"
            textField.text = self.userNameLabel.text
        }
        
        alert.addAction(
            UIAlertAction(
                title: "Ок",
                style: .default,
                handler: { (_) in
                    if let username = alert.textFields?.first?.text {
                        self.userNameLabel.text = username
                        self.storageManager.saveUser(name: username)
                    }
                }
            )
        )
        
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    private func selectImage() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary // Выбор фото из фотобиблиотеки
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    //MARK: - Picker Delegate
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
    ) {
        
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.userPhotoImageView.image = selectedImage
            storageManager.saveImageToUserDefaults(image: selectedImage)
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}





