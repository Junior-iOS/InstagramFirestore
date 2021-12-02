//
//  PostViewModel.swift
//  InstagramFirestore
//
//  Created by Junior Silva on 31/10/21.
//

import Foundation
import UIKit

struct PostViewModel {
    var post: Post
    
    var imageUrl: URL? { return URL(string: post.imageUrl) }
    
    var userProfileImageUrl: URL? { return URL(string: post.ownerImageUrl) }
    
    var userName: String { return post.ownerUserName }
    
    var caption: String { return post.caption }
    
    var likes: Int { return post.likes }
    
    var likesLabelText: String { return post.likes != 1 ? "\(post.likes) likes" : "\(post.likes) like" }
    
    var likeButtonImage: UIImage? {
        let imageName = post.didLike ? "like_selected" : "like_unselected"
        return UIImage(named: imageName)
    }
    
    var likeButtonTintColor: UIColor { return post.didLike ? .red : .white }
    
    init(post: Post) {
        self.post = post
    }
}
