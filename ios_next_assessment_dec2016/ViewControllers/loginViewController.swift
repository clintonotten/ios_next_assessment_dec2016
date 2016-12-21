//
//  loginViewController.swift
//  ios_next_assessment_dec2016
//
//  Created by Clinton Otten on 21/12/2016.
//  Copyright © 2016 Next Academy. All rights reserved.
//

import UIKit
import FirebaseAuth

class loginViewController: UIViewController {

    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!{
        didSet{
            spinner.isHidden = true
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func notifySuccessLogin(){
        
        //create notification
        let authSuccessNoification = Notification(name: Notification.Name(rawValue:"AuthSuccessNotification"))
        
        // post notification
        NotificationCenter.default.post(authSuccessNoification)
    }

    @IBAction func didTapLoginButton(_ sender: Any) {
        if let email = self.emailTextField.text, let password = self.passwordTextField.text {
            
            spinner.isHidden = false
            spinner.startAnimating()
            
            FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
                
                if let error = error{
                    print("Login Failed")
                    
                    return
                }
                
                guard let firUser = user else{ return }
                
                self.notifySuccessLogin()
                
                print("Successful login")
            
                })
        } else {
            print("Email or Password can't be empty")
            
            }
        
    }
    
    
    
    
    
    
    
    
}
