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
import FirebaseStorage

class signUpViewController: UIViewController, UINavigationControllerDelegate {

    @IBOutlet weak var emailSignUpTextField: UITextField!
    
    @IBOutlet weak var passwordSignUpTextField: UITextField!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var ageTextField: UITextField!
    
    @IBOutlet weak var genderTextField: UITextField!
    
    @IBOutlet weak var createAccountButton: UIButton!
    
    @IBOutlet weak var profilePictureImage: UIImageView!
    
    @IBOutlet weak var descriptionTextView: UITextView!
    
    var ref : FIRDatabaseReference!
    let storage = FIRStorage.storage()
    var storageRef : FIRStorageReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = FIRDatabase.database().reference()
        storageRef = storage.reference(forURL: "gs://ios-next-assessment-dec2016.appspot.com")
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func didTapCreateAccountButton(_ sender: Any) {
        
        if let email = self.emailSignUpTextField.text, let password = self.passwordSignUpTextField.text, let name = self.nameTextField.text, let age = self.ageTextField.text, let gender = self.genderTextField.text, let notes = self.descriptionTextView.text {
            
            FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
                
                if error != nil{
                    print("Login Failed")
                    print("\(error?.localizedDescription)")
                    
                    return
                }
                
                
                
                guard user != nil else{ return }
                
                self.notifySuccessfulSignUp()
                print("Successful SingUp")
                
                self.ref.child("users").child((user?.uid)!).setValue(["email" : email, "name" : name, "age" : age, "gender": gender, "notes": notes])
                
                if self.profilePictureImage.image != nil {
                self.uploadPicture()
                }
                })
        } else {
            print("Incomplete email or Password")
            
            }
        
        
        
    }
    
        
    @IBAction func uploadProfilePicture(_ sender: Any) {
        self.openLibraryFolder()
    }
    
    func openLibraryFolder(){
        if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary)){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }

    @IBOutlet weak var didTapUpdateAccountButton: UIButton!
}


extension signUpViewController {
    func notifySuccessfulSignUp(){
        
        let authSuccessNotification = Notification(name: Notification.Name(rawValue: "AuthSuccessNotification"))
        
        NotificationCenter.default.post(authSuccessNotification)
    }
    
    func uploadPicture() {
        var data = NSData()
        data = UIImageJPEGRepresentation(profilePictureImage.image!, 0.7)! as NSData
        
        let filePath = "\(FIRAuth.auth()!.currentUser!.uid)/\("profilepic")"
        let metaData = FIRStorageMetadata()
        metaData.contentType = "image/jpg"
        self.storageRef.child(filePath).put(data as Data, metadata: metaData){(metaData,error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }else{
                
                let downloadURL = metaData!.downloadURL()!.absoluteString
                
                self.ref.child("users").child(FIRAuth.auth()!.currentUser!.uid).updateChildValues(["profilepic": downloadURL])
    }
    
}
}
}
extension signUpViewController : UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var selectedImageFromPicker : UIImage?
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            selectedImageFromPicker = editedImage
        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            selectedImageFromPicker = originalImage
        }
        
        if let selectedImage = selectedImageFromPicker {
            profilePictureImage.image = selectedImage
            
            
                }
        dismiss(animated: true, completion: nil)

            }
}
