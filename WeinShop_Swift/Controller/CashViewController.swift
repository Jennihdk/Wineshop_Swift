//
//  CashViewController.swift
//  WeinShop_Swift
//
//  Created by Jennifer Hedtke on 02.12.22.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import CoreData

class CashViewController: UIViewController {
    
    //MARK: - Variables and Outlets
    @IBOutlet weak var streetTF: UITextField!
    @IBOutlet weak var houseNumberTF: UITextField!
    @IBOutlet weak var postalCodeTF: UITextField!
    @IBOutlet weak var locationTF: UITextField!
    @IBOutlet weak var countryTF: UITextField!
    
    //Coredata
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var coordinator = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.persistentStoreCoordinator
    
    //Firestore
    let db = Firestore.firestore()
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        roundTextFieldCorners()

        fetchUser { user in
            let user = user
            DispatchQueue.main.async { [self] in
                if Auth.auth().currentUser != nil {
                    print("User is signed in")
                    streetTF.text = user.street
                    houseNumberTF.text = user.houseNumber
                    postalCodeTF.text = user.postalCode
                    locationTF.text = user.location
                    countryTF.text = user.country
                } else {
                    print("No user is signed in")
                }
            }
        }
    }
    
    //MARK: - Functions
    func roundTextFieldCorners() {
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
        db.collection("Users").getDocuments() { querySnapshot, error in
            if let error = error {
                print("Error getting User: \(error)")
            } else {
                var userToShow = User()
                for document in querySnapshot!.documents {
                    var user = User()
                    let userData = document.data()
                    
                    user.street = userData["street"] as? String
                    user.houseNumber = userData["houseNuber"] as? String
                    user.postalCode = userData["postalCode"] as? String
                    user.location = userData["location"] as? String
                    user.country = userData["country"] as? String
                    userToShow = user
                }
                completion(userToShow)
            }
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
    @IBAction func btnCompletePurchaseClicked(_ sender: UIButton) {
        updateProfileData()
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "CartItem")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try coordinator.execute(deleteRequest, with: context)
        } catch let error as NSError {
            print(error)
        }
        
        performSegue(withIdentifier: "CompletePurchaseSegue", sender: nil)
    }
}
