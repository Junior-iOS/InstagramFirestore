//
//  AuthenticationButton.swift
//  InstagramFirestore
//
//  Created by Junior Silva on 03/10/21.
//

import Foundation
import UIKit

class AuthenticationButton: UIButton {
    
    init(title: String) {
        super.init(frame: .zero)
        
        setTitle(title, for: .normal)
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        setTitleColor(.white, for: .normal)
        backgroundColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        layer.cornerRadius = 5
        setHeight(50)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
