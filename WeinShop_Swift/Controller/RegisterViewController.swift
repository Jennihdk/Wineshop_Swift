//
//  RegisterViewController.swift
//  WeinShop_Swift
//
//  Created by Jennifer Hedtke on 17.11.22.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class RegisterViewController: UIViewController {
    
    //MARK: - Variables and Outlets
    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var lastNameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var passwordRepeatTF: UITextField!
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK: - Functions
    func createAlert(withTitle: String, andMessage: String) {
        
        let alertController = UIAlertController(title: withTitle, message: andMessage, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        
        self.present(alertController, animated: true)
        
    }
    
    func signUp() {
        var validated = false
        
        let firstName = firstNameTF.text!
        let lastName = lastNameTF.text!
        let email = emailTF.text!
        let password = passwordTF.text!
        let passwordRepeat = passwordRepeatTF.text!
        
        //Check that all text fields are filled out
        if !firstName.isEmpty && !lastName.isEmpty && !email.isEmpty && !password.isEmpty && !passwordRepeat.isEmpty {
            
            // 2. Validierung: Sind spezifische Bedingungen erfüllt?
            if !email.contains("@") {
                createAlert(withTitle: "Email", andMessage: "Bitte gib eine korrekte Email an.")
            } else if password.count < 6 {
                createAlert(withTitle: "Passwort", andMessage: "Das Passwort muss mind. 6 Zeichen beinhalten.")
            } else if password != passwordRepeat {
                createAlert(withTitle: "Passwort", andMessage: "Passwörter stimmen nicht überein.")
            } else {
                validated = true
            }
        } else {
            createAlert(withTitle: "Fehler", andMessage: "Bitte fülle alle Felder aus.")
        }
        
        //Create User
        if validated {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if error != nil {
                    self.createAlert(withTitle: "Fehler", andMessage: "Es ist ein unbekannter Fehler aufgetreten.")
                } else {
                    
                    //Create Firestore
                    let db = Firestore.firestore()
                    db.collection("Users").addDocument(data: [
                        "firstName": firstName,
                        "lastName": lastName,
                        "email": email,
                        "uid": authResult?.user.uid as Any
                    ]) { error in
                        
                        if error != nil {
                            self.createAlert(withTitle: "Fehler", andMessage: "Es ist ein Fehler aufgetreten")
                        } else {
                            self.performSegue(withIdentifier: "SignUpSegue", sender: nil)
                        }
                        
                    }
                }
            }
        }
    }
    
    //MARK: - Actions
    @IBAction func signUpBtnClicked(_ sender: UIButton) {
        signUp()
    }
    
}
