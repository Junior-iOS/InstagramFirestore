//
//  PostViewModel.swift
//  InstagramFirestore
//
//  Created by Junior Silva on 31/10/21.
//

import Foundation

struct PostViewModel {
    private let post: Post
    
    var imageUrl: URL? { return URL(string: post.imageUrl) }
    
    var userProfileImageUrl: URL? { return URL(string: post.ownerImageUrl) }
    
    var userName: String { return post.ownerUserName }
    
    var caption: String { return post.caption }
    
    var likes: Int { return post.likes }
    
    var likesLabelText: String { return post.likes != 1 ? "\(post.likes) likes" : "\(post.likes) like" }
    
    init(post: Post) {
        self.post = post
    }
}
