//
//  ViewController.swift
//  UserDefaultsApp
//
//  Created by Valerii D on 12.07.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var secondNameTextField: UITextField!
    
    private var user = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        // user = StorageManager.shared.getUser() // декодируем данные из JSON
        user = StorageManager.shared.getUserFromFile() // декодируем данные из plist файла
        userNameLabel.text = "\(user.name) \(user.surname)"
    }

    @IBAction func donePressed() {
        // проверяем не пустое ли поле и не равно ли nil
        guard let firstName = firstNameTextField.text, !(firstName.isEmpty) else {
            wrongFormatAlert()
            return
        }
        guard let secondName = secondNameTextField.text, !(secondName.isEmpty) else {
            wrongFormatAlert()
            return
        }
        
        // проверяем содержит ли поле цифры если нет берём объект из памяти
        if let _ = Double(firstName) {
            wrongFormatAlert()
        } else if let _ = Double(secondName) {
            wrongFormatAlert()
        } else {
            userNameLabel.text = firstName + " " + secondName
            user.name = firstName
            user.surname = secondName
            // UserDefaults.standard.set(userNameLabel.text, forKey: "userFullName")
            // StorageManager.shared.saveUser(user) // кодируем данные в JSON
            StorageManager.shared.saveUserToFile(user) // кодируем данные в plist файла
        }
        
        
        firstNameTextField.text = nil
        secondNameTextField.text = nil
    }
    
}

extension ViewController {
    // cоздаем UIAlert
    func wrongFormatAlert() {
        let alert = UIAlertController(title: "Wrong format",
                                      message: "Please enter your name",
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK",
                                     style: .default,
                                     handler: nil)
        
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
}
