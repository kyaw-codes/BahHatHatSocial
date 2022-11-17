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
    @ServerTimestamp var postedDate: Date?
    let postText: String
    let imageUrl: String
    let postedByUser: PostedByUser
    let likedBy: [String]
    let comments: [BHHPost]
}

struct PostedByUser: Codable {
    let userId: String
    let documentId: String
}
