//
//  PostVO.swift
//  BahHatHatSocial
//
//  Created by Kyaw Zay Ya Lin Tun on 11/17/22.
//

import Foundation

struct PostVO: Identifiable {
    let documentId: String
    let postedDate: Date
    let postText: String
    let imageUrl: String
    let postedBy: String
    var likedBy: [String] = []
    var comments: [PostVO] = []
    
    var id: String {
        return documentId
    }
    
    var likeCount: Int {
        return likedBy.count
    }
    
    var commentCount: Int {
        return comments.count
    }
    
    var canDelete: Bool {
        return postedBy == AuthManager().currentUserId()
    }
    
    var likedByMe: Bool {
        guard let id = AuthManager().currentUserId() else {
            return false
        }
        return likedBy.contains(id)
    }
    
    init(documentId: String, postedDate: Date, postText: String, imageUrl: String, postedBy: String) {
        self.documentId = documentId
        self.postedDate = postedDate
        self.postText = postText
        self.imageUrl = imageUrl
        self.postedBy = postedBy
    }
    
    init(post: BHHPost) {
        self.documentId = post.id ?? ""
        self.postedDate = post.postedDate ?? Date()
        self.postText = post.postText
        self.imageUrl = post.imageUrl
        self.postedBy = post.postedBy
        self.likedBy = post.likedBy
        self.comments = post.comments.map(PostVO.init(post:))
    }
    
}
