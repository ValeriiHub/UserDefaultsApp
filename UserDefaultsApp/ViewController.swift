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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userNameLabel.isHidden = true
        
        if let userName = UserDefaults.standard.value(forKey: "userFullName") {
            userNameLabel.isHidden = false
            userNameLabel.text = userName as? String
        }
    }

    @IBAction func donePressed() {
        guard let firstName = firstNameTextField.text, !(firstName.isEmpty) else {
            wrongFormatAlert()
            return
        }
        guard let secondName = secondNameTextField.text, !(secondName.isEmpty) else {
            wrongFormatAlert()
            return
        }
        
        if let _ = Double(firstName) {
            wrongFormatAlert()
        } else if let _ = Double(secondName) {
            wrongFormatAlert()
        } else {
            userNameLabel.isHidden = false
            userNameLabel.text = firstName + " " + secondName
            UserDefaults.standard.set(userNameLabel.text, forKey: "userFullName")
        }
        
        
        firstNameTextField.text = nil
        secondNameTextField.text = nil
    }
    
}

extension ViewController {
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
