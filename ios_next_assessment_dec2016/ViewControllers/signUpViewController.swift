//
//  signUpViewController.swift
//  ios_next_assessment_dec2016
//
//  Created by Clinton Otten on 21/12/2016.
//  Copyright © 2016 Next Academy. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class signUpViewController: UIViewController {

    @IBOutlet weak var emailSignUpTextField: UITextField!
    
    @IBOutlet weak var passwordSignUpTextField: UITextField!
    
    @IBOutlet weak var createAccountButton: UIButton!{
        didSet{
            createAccountButton.addTarget(self, action: #selector(didTapCreateAccountButton(button:)), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var cancelAccountButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func didTapCreateAccountButton (button: UIButton) {
        if let email = self.emailSignUpTextField.text, let password = passwordSignUpTextField.text {
            
            FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
                
                if error != nil{
                    print("Login Failed")
                    print("\(error?.localizedDescription)")
                    
                    return
                }
                
                guard user != nil else{ return }
                
                self.notifySuccessfulSignUp()
                print("Successful SingUp")
                })
        } else {
            print("Incomplete email or Password")
            
        }
        
        
        
        }
}


extension signUpViewController {
    func notifySuccessfulSignUp(){
        
        let authSuccessNotification = Notification(name: Notification.Name(rawValue: "AuthSuccessNotification"))
        
        NotificationCenter.default.post(authSuccessNotification)
    }
    
}
