//
//  ProfileViewController.swift
//  WeinShop_Swift
//
//  Created by Jennifer Hedtke on 22.11.22.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseDatabase

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
    @IBOutlet weak var btnSaveUserData: UIButton!
    
    let db = Firestore.firestore()
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        roundTextFieldCorners()
        initializeHideKeyboard()
        
        fetchUser { user in
            let currentUser = user
            DispatchQueue.main.async { [self] in
                if Auth.auth().currentUser != nil {
                    print("User is signed in")
                    firstNameTF.text = currentUser.firstName
                    lastNameTF.text = currentUser.lastName
                    emailTF.text = currentUser.email
                    streetTF.text = currentUser.street
                    houseNumberTF.text = currentUser.houseNumber
                    postalCodeTF.text = currentUser.postalCode
                    locationTF.text = currentUser.location
                    countryTF.text = currentUser.country
                    btnLogIn.isHidden = true
                } else {
                    print("No user is signed in")
                    btnLogIn.isHidden = false
                    btnLogOut.isHidden = true
                    btnSaveUserData.isHidden = true
                }
            }
        }
    }
    
    //MARK: - Functions
    func roundTextFieldCorners() {
        firstNameTF.layer.borderWidth = 0.1
        firstNameTF.layer.cornerRadius = firstNameTF.frame.size.height/2
        firstNameTF.clipsToBounds = true
        lastNameTF.layer.borderWidth = 0.1
        lastNameTF.layer.cornerRadius = lastNameTF.frame.size.height/2
        lastNameTF.clipsToBounds = true
        emailTF.layer.borderWidth = 0.1
        emailTF.layer.cornerRadius = emailTF.frame.size.height/2
        emailTF.clipsToBounds = true
        streetTF.layer.borderWidth = 0.1
        streetTF.layer.cornerRadius = streetTF.frame.size.height/2
        streetTF.clipsToBounds = true
        houseNumberTF.layer.borderWidth = 0.1
        houseNumberTF.layer.cornerRadius = houseNumberTF.frame.size.height/2
        houseNumberTF.clipsToBounds = true
        postalCodeTF.layer.borderWidth = 0.1
        postalCodeTF.layer.cornerRadius = postalCodeTF.frame.size.height/2
        postalCodeTF.clipsToBounds = true
        locationTF.layer.borderWidth = 0.1
        locationTF.layer.cornerRadius = locationTF.frame.size.height/2
        locationTF.clipsToBounds = true
        countryTF.layer.borderWidth = 0.1
        countryTF.layer.cornerRadius = countryTF.frame.size.height/2
        countryTF.clipsToBounds = true
    }
    
    func fetchUser(completion: @escaping(User) -> Void) {
        //fetches the data of the currently logged in user
        let currentUser = Auth.auth().currentUser?.uid
        let docRef = db.collection("Users").document(currentUser!)

        docRef.getDocument { (document, error) in
            var user = User()
            if let document = document, document.exists {
                let userData = document.data()
                user.firstName = userData!["firstName"] as? String
                user.lastName = userData!["lastName"] as? String
                user.email = userData!["email"] as? String
                user.street = userData!["street"] as? String
                user.houseNumber = userData!["houseNumber"] as? String
                user.postalCode = userData!["postalCode"] as? String
                user.location = userData!["location"] as? String
                user.country = userData!["country"] as? String
            } else {
                print("Document does not exist")
            }
            completion(user)
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
    
    func updateProfileData() {
        let currentUser = Auth.auth().currentUser?.uid
        // Set new fields to the current user
        db.collection("Users").document(currentUser!).setData([
            "street": streetTF.text!,
            "houseNumber": houseNumberTF.text!,
            "postalCode": postalCodeTF.text!,
            "location": locationTF.text!,
            "country": countryTF.text!
         ], merge: true ){ err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
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
        logOut()
    }
    
    @IBAction func btnSaveUserDataClicked(_ sender: UIButton) {
        updateProfileData()
    }

}
