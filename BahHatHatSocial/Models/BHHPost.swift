//
//  BHHPost.swift
//  BahHatHatSocial
//
//  Created by Kyaw Zay Ya Lin Tun on 11/17/22.
//

import Foundation
import FirebaseFirestoreSwift

struct BHHPost: Codable {
    @DocumentID var id: String?
    var postedDate = Date()
    let postText: String
    let imageUrl: String
    let postedBy: String
    let likedBy: [String]
    let comments: [BHHPost]
    
    var likeCount: Int {
        return likedBy.count
    }
    
    var commentCount: Int {
        return comments.count
    }
}
