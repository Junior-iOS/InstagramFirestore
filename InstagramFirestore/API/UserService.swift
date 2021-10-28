//
//  UserService.swift
//  InstagramFirestore
//
//  Created by Junior Silva on 19/10/21.
//

import Foundation
import Firebase

struct UserService {
    static func fetchUser(_ completion: @escaping(User) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        COLLECTION_USERS.document(uid).getDocument { snapshot, error in
            guard let dictionary = snapshot?.data() else { return }
            let user = User(dictionary: dictionary)
            completion(user)
        }
    }
}
