//
//  UserService.swift
//  InstagramFirestore
//
//  Created by Junior Silva on 19/10/21.
//

import Foundation
import Firebase

typealias FirestoreCompletion = (Error?) -> Void

struct UserService {
    static func fetchCurrentUser(_ completion: @escaping(User) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        COLLECTION_USERS.document(uid).getDocument { snapshot, error in
            guard let dictionary = snapshot?.data() else { return }
            let user = User(dictionary: dictionary)
            completion(user)
        }
    }
    
    static func fetchUsers(completion: @escaping ([User]) -> Void) {
        COLLECTION_USERS.getDocuments { snapshot, error in
            guard let snapshot = snapshot else { return }
            let users = snapshot.documents.map({ User(dictionary: $0.data()) })
            completion(users)
        }
    }
    
    static func follow(uid: String, completion: @escaping FirestoreCompletion) {
        guard let currentUID = Auth.auth().currentUser?.uid else { return }
        COLLECTION_FOLLOWING.document(currentUID).collection("user-following").document(uid).setData([:]) { _ in
            COLLECTION_FOLLOWERS.document(uid).collection("user-followers").document(currentUID).setData([:], completion: completion)
        }
    }
    
    static func unfollow(uid: String, completion: @escaping FirestoreCompletion) {
//        guard let uid = Auth.auth().currentUser?.uid else { return }
    }
}
