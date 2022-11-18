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
    
    private var subscriptionSets = Set<AnyCancellable>()
    
    func createPost(text: String, image: Data?) -> Future<BHHPost, Error> {
        let imagePath = "postImages/\(UUID().uuidString).png"
        
        let currentUser = authManager.currentUser().replaceError(with: nil).share()
        let photoUpload = photoUploadManager
            .upload(photoData: image ?? Data(), withPath: imagePath)
            .share()
        
        return Publishers.CombineLatest(currentUser, photoUpload)
            .map { (user, photoUrl) in
                BHHPost(
                    postText: text,
                    imageUrl: image == nil ? "" : photoUrl,
                    postedByUser: .init(userId: user?.userId ?? "", documentId: user?.docId ?? ""),
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
            .asFuture()
    }

    func deletePost(id: String) -> Future<Void, Error> {
        return db.collection("posts").document(id).delete().asFuture()
    }
}


