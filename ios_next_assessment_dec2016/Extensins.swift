//
//  Extensins.swift
//  ios_next_assessment_dec2016
//
//  Created by Clinton Otten on 21/12/2016.
//  Copyright © 2016 Next Academy. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    class AlertController{
        static func alertPopUp(viewController : UIViewController, titleMsg : String, message : String, cancelMsg : String) -> Void{
            let alertController = UIAlertController(title: titleMsg, message: message, preferredStyle: UIAlertControllerStyle.alert)
            
            let cancelButton = UIAlertAction(title: cancelMsg, style: .cancel, handler: nil)
            
            alertController.addAction(cancelButton)
            viewController.present(alertController, animated : true, completion:nil)
        }
    }
}
