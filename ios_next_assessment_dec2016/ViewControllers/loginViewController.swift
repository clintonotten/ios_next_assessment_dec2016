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
    
    
    @IBAction func didTapLoginButton(_ sender: Any) {
        if let email = self.emailTextField.text, let password = self.passwordTextField.text {
            
            FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
                
                self.startSpinning()
                
                if error != nil{
                    print("Login Failed")
                    print("\(error)")
                    self.stopSpinning()
                    
                    AlertController.alertPopUp(viewController: self, titleMsg: "Login Error", message: "Incorrect email or password", cancelMsg: "Ok")
                    
                    return
                }
                
                guard user != nil else{ return }
                
                self.notifySuccessLogin()
                self.stopSpinning()
                print("Successful login")
            
                })
        } else {
            print("Email or Password can't be empty")
            self.stopSpinning()
            }
        
    }
    
}
extension loginViewController : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if text.isEmpty {
            self.loginButton.isUserInteractionEnabled = false
        } else {
            self.loginButton.isUserInteractionEnabled = true
        }
    }
}
extension loginViewController {
    
    func notifySuccessLogin(){
        //create notification
        let authSuccessNoification = Notification(name: Notification.Name(rawValue:"AuthSuccessNotification"))
        
        // post notification
        NotificationCenter.default.post(authSuccessNoification)
    }
    
    //Spinner Animations
    
    func startSpinning() {
        spinner.isHidden = false
        spinner.startAnimating()
    }
    
    func stopSpinning() {
        spinner.isHidden = true
        spinner.stopAnimating()
    }
    
    // Check if textfield is empty
    
//    func isTextFieldEmpty() {
//        if se
//    }
}
