//
//  ProfileHeaderViewModel.swift
//  
//
//  Created by Junior Silva on 28/10/21.
//

import Foundation

struct ProfileHeaderViewModel {
    let user: User
    
    var fullName: String {
        return user.fullName
    }
    
    var profileImage: URL? {
        return URL(string: user.profileImage)
    }
    
    init(user: User) {
        self.user = user
    }
}
