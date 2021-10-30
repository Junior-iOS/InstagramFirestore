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
        return user.isFollowed ? "Unfollow" : "Follow"
    }
    
    var followButtonBackgroundColor: UIColor {
        return user.isCurrentUser ? .white : .systemBlue
    }
    
    var followButtonTextColor: UIColor {
        return user.isCurrentUser ? .black : .white
    }
    
    var numberOfFollowers: NSAttributedString {
        return attributedStatusText(value: user.stats?.followers ?? 0, label: "followers")
    }
    
    var numberOfFollowing: NSAttributedString {
        return attributedStatusText(value: user.stats?.following ?? 0, label: "following")
    }
    
    var numberOfPosts: NSAttributedString {
        return attributedStatusText(value: user.stats?.posts ?? 0, label: "posts")
    }
    
    init(user: User) {
        self.user = user
    }
    
    // MARK: - Helpers
    private func attributedStatusText(value: Int, label: String) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: "\(value)\n", attributes: [.font : UIFont.boldSystemFont(ofSize: 14)])
        attributedString.append(NSMutableAttributedString(string: label, attributes: [.font : UIFont.boldSystemFont(ofSize: 14), .foregroundColor: UIColor.lightGray]))
        return attributedString
    }
}
