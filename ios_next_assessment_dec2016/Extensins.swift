//
//  Extensins.swift
//  ios_next_assessment_dec2016
//
//  Created by Clinton Otten on 21/12/2016.
//  Copyright © 2016 Next Academy. All rights reserved.
//

import Foundation
import UIKit

class AlertController{
    static func alertPopUp(viewController : UIViewController, titleMsg : String, message : String, cancelMsg : String) -> Void{
        let alertController = UIAlertController(title: titleMsg, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        let cancelButton = UIAlertAction(title: cancelMsg, style: .cancel, handler: nil)
        
        alertController.addAction(cancelButton)
        viewController.present(alertController, animated : true, completion:nil)
    }
}

extension UIViewController {
    
    func QuickPresent(storyboard : String, controllername : String) {
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: controllername)
        present(controller, animated: true, completion: nil)
    }
}

extension UIImageView {
    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { () -> Void in
                self.image = image
            }
            }.resume()
    }
    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
}
