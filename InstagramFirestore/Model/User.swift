//
//  User.swift
//  InstagramFirestore
//
//  Created by Junior Silva on 26/10/21.
//

import Foundation

struct User {
    let email: String
    let fullName: String
    let profileImage: String
    let userName: String
    let uid: String
    
    init(dictionary: [String: Any]) {
        self.email = dictionary["email"] as? String ?? ""
        self.fullName = dictionary["fullName"] as? String ?? ""
        self.profileImage = dictionary["profileImage"] as? String ?? ""
        self.userName = dictionary["userName"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
    }
}
