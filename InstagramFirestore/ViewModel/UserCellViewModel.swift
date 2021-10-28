//
//  UserCellViewModel.swift
//  InstagramFirestore
//
//  Created by Junior Silva on 28/10/21.
//

import Foundation

struct UserCellViewModel {
    private let user: User
    
    var profileImage: URL? {
        return URL(string: user.profileImage)
    }
    
    var userName: String {
        return user.userName
    }
    
    var fullName: String {
        return user.fullName
    }
    
    init(user: User) {
        self.user = user
    }
}
