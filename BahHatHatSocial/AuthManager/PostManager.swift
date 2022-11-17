//
//  PostManager.swift
//  BahHatHatSocial
//
//  Created by Kyaw Zay Ya Lin Tun on 11/17/22.
//

import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseFirestoreCombineSwift
import Combine

final class PostManager {
    private let db = Firestore.firestore()
    private let authManager = AuthManager()
    private let photoUploadManager = PhotoUploadManager()
    
    private var currentUserId: String {
        authManager.currentUser()?.uid ?? ""
    }
    
    private var subscriptionSets = Set<AnyCancellable>()
    
    func createPost(text: String, image: Data?) -> AnyPublisher<BHHPost, Error> {
        let imagePath = "postImages/\(UUID().uuidString).png"
        
        return photoUploadManager
            .upload(photoData: image ?? Data(), withPath: imagePath)
            .map {
                BHHPost(
                    postText: text,
                    imageUrl: image == nil ? "" : $0,
                    postedBy: self.currentUserId,
                    likedBy: [],
                    comments: []
                )
            }
            .flatMap {
                self.db.collection("posts").addDocument(from: $0)
            }
            .flatMap { ref in
                Future {
                    try await ref.getDocument(as: BHHPost.self)
                }
            }
            .eraseToAnyPublisher()
    }
}
