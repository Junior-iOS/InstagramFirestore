//
//  Comment.swift
//  InstagramFirestore
//
//  Created by Junior Silva on 11/11/21.
//

import Foundation
import Firebase

struct Comment {
    let uid: String
    let userName: String
    let profileImageUrl: String
    let timestamp: Timestamp
    let comment: String
    
    init(dictionary: [String: Any]) {
        self.uid = dictionary["uid"] as? String ?? ""
        self.userName = dictionary["userName"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
        self.timestamp = dictionary["timestamp"] as? Timestamp ?? Timestamp(date: Date())
        self.comment = dictionary["comment"] as? String ?? ""
    }
}
