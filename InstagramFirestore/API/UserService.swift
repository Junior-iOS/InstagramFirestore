//
//  UserService.swift
//  InstagramFirestore
//
//  Created by Junior Silva on 19/10/21.
//

import Foundation
import Firebase

struct UserService {
    static func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        COLLECTION_USERS.document(uid).getDocument { snapshot, error in
            print("Snapshot: ", snapshot?.data())
        }
    }
}
