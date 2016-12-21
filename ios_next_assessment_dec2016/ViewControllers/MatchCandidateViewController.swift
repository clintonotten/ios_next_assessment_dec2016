//
//  MatchCandidateViewController.swift
//  ios_next_assessment_dec2016
//
//  Created by Clinton Otten on 21/12/2016.
//  Copyright © 2016 Next Academy. All rights reserved.
//

import UIKit
import Firebase

class MatchCandidateViewController: UIViewController {

    let user = FIRAuth.auth()?.currentUser
    var ref: FIRDatabaseReference!
    let profile = Profile()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = FIRDatabase.database().reference()
        // Do any additional setup after loading the view.
    }

//    func fetchMatches {
//        ref.child("users").observeSingleEvent(of: .value , with: {(snapshot) in
//            if let dictionary = snapshot.value as? [String:AnyObject] {
//                print("\(dictionary)")
//                
//                self.profile.name = (dictionary["name"] as! String?)!
//                self.profile.age = (dictionary["age"] as! String?)!
//                self.profile.notes = (dictionary["notes"] as! String?)!
//                self.profile.email = (dictionary["email"] as! String?)!
//                self.profile.gender = (dictionary["gender"] as! String?)!
//                self.profile.pic = (dictionary["profilepic"] as! String?)!
//                
//                self.setProfile()
//            }
//        })
//    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
