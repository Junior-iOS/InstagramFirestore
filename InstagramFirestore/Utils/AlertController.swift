//
//  AlertController.swift
//  InstagramFirestore
//
//  Created by Junior Silva on 28/10/21.
//

import Foundation
import UIKit

final class AlertController {
    
    static let shared = AlertController()
    
    func showAlert(title: String, message: String, viewController: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Got it", style: .default)
        alert.addAction(ok)
        viewController.present(alert, animated: true)
    }
    
}
