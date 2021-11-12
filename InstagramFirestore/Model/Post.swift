//
//  Post.swift
//  InstagramFirestore
//
//  Created by Junior Silva on 31/10/21.
//

import Foundation
import Firebase

struct Post {
    var caption: String
    var likes: Int
    let imageUrl: String
    let ownerUid: String
    let timestamp: Timestamp
    var postId: String
    let ownerImageUrl: String
    let ownerUserName: String
    
    init(postId: String, dictionary: [String: Any]) {
        self.caption = dictionary["caption"] as? String ?? ""
        self.likes = dictionary["likes"] as? Int ?? 0
        self.imageUrl = dictionary["imageUrl"] as? String ?? ""
        self.ownerUid = dictionary["ownerUid"] as? String ?? ""
        self.timestamp = dictionary["timestamp"] as? Timestamp ?? Timestamp(date: Date())
        self.postId = dictionary["postId"] as? String ?? ""
        self.ownerImageUrl = dictionary["ownerImageUrl"] as? String ?? ""
        self.ownerUserName = dictionary["ownerUserName"] as? String ?? ""
        self.postId = postId
    }
}
