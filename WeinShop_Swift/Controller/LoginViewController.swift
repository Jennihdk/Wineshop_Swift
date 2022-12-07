//
//  LoginViewController.swift
//  WeinShop_Swift
//
//  Created by Jennifer Hedtke on 17.11.22.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class LoginViewController: UIViewController {
    
    //MARK: - Variables and Outlets
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var errorLbl: UILabel!
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        roundTextFieldCorners()
        initializeHideKeyboard()
    }
    
    //MARK: viewDidAppear = Wenn View (UI) angezeigt wird
    override func viewDidAppear(_ animated: Bool) {
        guard let uid = Auth.auth().currentUser?.uid else {
            print("Kein User aktuell")
            return
        }
        
        if !uid.isEmpty {
            print("\(uid)")
            performSegue(withIdentifier: "LoginSegue", sender: nil)
        }
    }
    
    //MARK: - Functions
    func roundTextFieldCorners() {
        emailTF.layer.cornerRadius = emailTF.frame.size.height/2
        emailTF.clipsToBounds = true
        passwordTF.layer.cornerRadius = passwordTF.frame.size.height/2
        passwordTF.clipsToBounds = true
    }
    
    //MARK: - Actions
    @IBAction func loginBtnClicked(_ sender: UIButton) {
        let email = emailTF.text!
        let password = passwordTF.text!
        
        if !email.isEmpty && !password.isEmpty {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                
                if error != nil {
                    print("Something went wrong with login")
                    self.errorLbl.isHidden = false
                    self.errorLbl.text = "Die Nutzerdaten sind nicht korrekt"
                    
                } else {
                    self.performSegue(withIdentifier: "LoginSegue", sender: nil)
                    
                }
                
            }
        }
    }
}
