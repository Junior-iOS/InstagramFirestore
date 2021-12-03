//
//  Notification.swift
//  InstagramFirestore
//
//  Created by Junior Silva on 03/12/21.
//

import Firebase

enum NotificationType: Int {
    case like, follow, comment
    
    var notificationMessage: String {
        switch self {
        case .like: return " liked your post"
        case .follow: return " started following you"
        case .comment: return " commented on your post"
        }
    }
}

struct Notification {
    let uid: String
    let postImageUrl: String?
    let postId: String?
    let timestamp: Timestamp
    let type: NotificationType
    let id: String
    
    init(dictionary: [String:Any]) {
        self.uid = dictionary["uid"] as? String ?? ""
        self.postImageUrl = dictionary["postImageUrl"] as? String ?? ""
        self.postId = dictionary["postId"] as? String ?? ""
        self.timestamp = dictionary["timestamp"] as? Timestamp ?? Timestamp(date: Date())
        self.type = NotificationType(rawValue: dictionary["type"] as? Int ?? 0) ?? .like
        self.id = dictionary["id"] as? String ?? ""
    }
}
