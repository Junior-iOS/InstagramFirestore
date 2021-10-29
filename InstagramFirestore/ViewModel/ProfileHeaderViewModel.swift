//
//  ProfileHeaderViewModel.swift
//  
//
//  Created by Junior Silva on 28/10/21.
//

import Foundation
import UIKit

struct ProfileHeaderViewModel {
    let user: User
    
    var fullName: String {
        return user.fullName
    }
    
    var profileImage: URL? {
        return URL(string: user.profileImage)
    }
    
    var followButtonText: String {
        if user.isCurrentUser {
            return "Edit Profile"
        }
        return user.isFollowed ? "Following" : "Follow"
    }
    
    var followButtonBackgroundColor: UIColor {
        return user.isCurrentUser ? .white : .systemBlue
    }
    
    var followButtonTextColor: UIColor {
        return user.isCurrentUser ? .black : .white
    }
    
    init(user: User) {
        self.user = user
    }
}
