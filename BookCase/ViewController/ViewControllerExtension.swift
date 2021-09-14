//
//  ViewControllerExtension.swift
//  BookCase
//
//  Created by Mohamed Zakaria on 5/11/18.
//  Copyright © 2018 Mohamed Zakaria. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    // Show alert message
    func showAlert(title: String?, message errormessage: String) {
        let alertController = UIAlertController(title: title, message: errormessage, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
        alertController.addAction(dismissAction)
        present(alertController, animated: true, completion: nil)
    }
    
}
