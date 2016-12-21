//
//  profileViewController.swift
//  ios_next_assessment_dec2016
//
//  Created by Clinton Otten on 21/12/2016.
//  Copyright © 2016 Next Academy. All rights reserved.
//

import UIKit
import Firebase

class profileViewController: UIViewController {

    @IBOutlet weak var logOutButton: UIButton!
    
    var profile = Profile()
    
    let user = FIRAuth.auth()?.currentUser
    var ref: FIRDatabaseReference!
    let storage = FIRStorage.storage()
    var storageRef : FIRStorageReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = FIRDatabase.database().reference()
        storageRef = storage.reference(forURL: "gs://ios-next-assessment-dec2016.appspot.com")

        fetchUser()
        // Do any additional setup after loading the view.
    }
    
    func fetchUser() {
        ref.child("users").child((user?.uid)!).observeSingleEvent(of: .value , with: {(snapshot) in
            if let dictionary = snapshot.value as? [String:AnyObject] {
                print("\(dictionary)")
                
            }
        })
    }
    
    @IBAction func didTapLogOutButton(_ sender: Any) {
    let firebaseAuth = FIRAuth.auth()
        do {
            try firebaseAuth?.signOut()
        }
        catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
        QuickPresent(storyboard: "Main", controllername: "navigation")
    }
    
    @IBAction func didTapUpdateProfileButton(_ sender: Any) {

        QuickPresent(storyboard: "Main", controllername: "signUp")
    }

    
    
}
