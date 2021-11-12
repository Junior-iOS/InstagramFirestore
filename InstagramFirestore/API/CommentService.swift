//
//  CommentService.swift
//  InstagramFirestore
//
//  Created by Junior Silva on 11/11/21.
//

import Foundation
import Firebase

struct CommentService {
    static func uploadComment(comment: String, postID: String, user: User, completion: @escaping (FirestoreCompletion)) {
        let data: [String: Any] = [
            "uid": user.uid,
            "comment": comment,
            "timestamp": Timestamp(date: Date()),
            "userName": user.userName,
            "profileImageUrl": user.profileImage
        ]
        
        COLLECTION_POSTS.document(postID).collection("comments").addDocument(data: data, completion: completion)
    }
    
    static func fetchComments() {
        
    }
}
