//
//  ProfileViewController.swift
//  WeinShop_Swift
//
//  Created by Jennifer Hedtke on 22.11.22.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import Firebase

class ProfileViewController: UIViewController {
    
    //MARK: - Variables and Outlets
    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var lastNameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var streetTF: UITextField!
    @IBOutlet weak var houseNumberTF: UITextField!
    @IBOutlet weak var postalCodeTF: UITextField!
    @IBOutlet weak var locationTF: UITextField!
    @IBOutlet weak var countryTF: UITextField!
    @IBOutlet weak var btnLogOut: UIButton!
    @IBOutlet weak var btnLogIn: UIButton!
    
    let db = Firestore.firestore()
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchUser { user in
            let user = user
            DispatchQueue.main.async { [self] in
                if Auth.auth().currentUser != nil {
                    print("User is signed in")
                    firstNameTF.text = user.firstName
                    lastNameTF.text = user.lastName
                    emailTF.text = user.email
                    btnLogIn.isHidden = true
                } else {
                    print("No user is signed in")
                    btnLogIn.isHidden = false
                    btnLogOut.isHidden = true
                }
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    //MARK: - Functions
    func fetchUser(completion: @escaping(User) -> Void) {
        db.collection("Users").getDocuments() { querySnapshot, error in
            if let error = error {
                print("Error getting User: \(error)")
            } else {
                var userToShow = User()
                for document in querySnapshot!.documents {
                    var user = User()
                    let userData = document.data()
                    
                    user.firstName = userData["firstName"] as? String
                    user.lastName = userData["lastName"] as? String
                    user.email = userData["email"] as?String
                    userToShow = user
                }
                completion(userToShow)
            }
        }
    }
    
    func logOut() {
        let firebaseAuth = Auth.auth()
            
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
    //MARK: - Actions
    @IBAction func btnLogOutClicked(_ sender: UIButton) {
        let alert = UIAlertController(title: "Abmelden", message: "Möchtest Du Dein Konto wirklich abmelden?", preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Abbrechen", style: .default)
        let acceptAction = UIAlertAction(title: "Abmelden", style: .default, handler: { [self] (_) in
            logOut()
            performSegue(withIdentifier: "LogOutSegue", sender: nil)
        })
        alert.addAction(cancelAction)
        alert.addAction(acceptAction)
        present(alert, animated: true)
    }
    
    
    
}
