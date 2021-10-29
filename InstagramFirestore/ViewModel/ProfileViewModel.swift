//
//  ProfileViewModel.swift
//  InstagramFirestore
//
//  Created by Junior Silva on 28/10/21.
//

import Foundation

struct ProfileViewModel {
    private let user: User
    
    var profileImage: URL? {
        return URL(string: user.profileImage)
    }
    
    init(user: User) {
        self.user = user
    }
}
