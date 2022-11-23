//
//  ProfileViewController.swift
//  WeinShop_Swift
//
//  Created by Jennifer Hedtke on 22.11.22.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

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
    
    var firstName: String?
    
    let db = Firestore.firestore()
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*fetchUser { user in
            self.user = user
            print(user)
            
            DispatchQueue.main.async { [self] in
                if Auth.auth().currentUser != nil {
                    print("User is signed in")
                    firstNameTF.text = user.firstName
                    lastNameTF.text = user.lastName
                    emailTF.text = user.email
                } else {
                    print("No user is signed in")
                }
                
            }
        }*/
    }
    
    /*func fetchUser(completion: @escaping(User) -> Void) {
        
        db.collection("User").getDocuments() { querySnapshot, error in
            if let error = error {
                print("Error getting User: \(error)")
            } else {
                let userToShow = User()
                for document in querySnapshot!.documents {
                    var user = User()
                    let userData = document.data()
                    
                    user.firstName = userData["firstName"] as? String
                    user.lastName = userData["lastName"] as? String
                    user.email = userData["email"] as?String
                }
                completion(userToShow)
            }
        }
    }*/
    
    func getUser() {
        
    }
    
    @objc func logOut() {
        let firebaseAuth = Auth.auth()
            
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
    //MARK: - Actions
    @IBAction func btnLogOutClicked(_ sender: UIButton) {
        logOut()
        performSegue(withIdentifier: "LogOutSegue", sender: nil)
    }
}
