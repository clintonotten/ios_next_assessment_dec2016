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
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var notesLabel: UILabel!
    
    
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
        setProfile()
        // Do any additional setup after loading the view.
    }
    
    func fetchUser() {
        ref.child("users").child((user?.uid)!).observeSingleEvent(of: .value , with: {(snapshot) in
            if let dictionary = snapshot.value as? [String:AnyObject] {
                print("\(dictionary)")
                
                self.profile.name = (dictionary["name"] as! String?)!
                self.profile.age = (dictionary["age"] as! String?)!
                self.profile.notes = (dictionary["notes"] as! String?)!
                self.profile.email = (dictionary["email"] as! String?)!
                self.profile.gender = (dictionary["gender"] as! String?)!
                
            }
        })
    }
    
    func setProfile() {
        self.nameLabel.text = self.profile.name
        self.ageLabel.text = self.profile.age
        self.notesLabel.text = self.profile.notes
        self.emailLabel.text = self.profile.email
        self.genderLabel.text = self.profile.gender
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
