//
//  NotificationService.swift
//  InstagramFirestore
//
//  Created by Junior Silva on 03/12/21.
//

import Firebase

struct NotificationService {
    static func uploadNotification(toUid uid: String, type: NotificationType, post: Post? = nil) {
        guard let currentUID = Auth.auth().currentUser?.uid else { return }
        guard uid != currentUID else { return }
        
        let docRef = COLLECTION_NOTIFICATIONS.document(uid).collection("user-notifications").document() // get document id
        
        var data: [String: Any] = [
            "timestamp": Timestamp(date: Date()),
            "uid": currentUID,
            "type": type.rawValue,
            "id": docRef.documentID
        ]
        
        if let post = post {
            data["postId"] = post.postId
            data["postImageUrl"] = post.imageUrl
        }
        
        docRef.setData(data)
    }
    
    static func fetchNotification() {
        
    }
}
