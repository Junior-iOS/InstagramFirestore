//
//  NotificationService.swift
//  InstagramFirestore
//
//  Created by Junior Silva on 03/12/21.
//

import Firebase

struct NotificationService {
    static func uploadNotification(toUid uid: String, fromUser: User, type: NotificationType, post: Post? = nil) {
        guard let currentUID = Auth.auth().currentUser?.uid else { return }
        guard uid != currentUID else { return }
        
        let docRef = COLLECTION_NOTIFICATIONS.document(uid).collection("user-notifications").document() // get document id
        
        var data: [String: Any] = [
            "userProfileImageUrl": fromUser.profileImage,
            "userName": fromUser.userName,
            "timestamp": Timestamp(date: Date()),
            "uid": fromUser.uid,
            "type": type.rawValue,
            "id": docRef.documentID
        ]
        
        if let post = post {
            data["postId"] = post.postId
            data["postImageUrl"] = post.imageUrl
        }
        
        docRef.setData(data)
    }
    
    static func fetchNotification(completion: @escaping ([Notification]) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        COLLECTION_NOTIFICATIONS.document(uid).collection("user-notifications").getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            
            let notifications = documents.map({ Notification(dictionary: $0.data()) })
            completion(notifications)
        }
    }
}
