//
//  AuthManager.swift
//  BahHatHatSocial
//
//  Created by Kyaw Zay Ya Lin Tun on 11/15/22.
//

import FirebaseAuth
import FirebaseAuthCombineSwift
import FirebaseFirestore
import FirebaseFirestoreCombineSwift
import Combine

final class AuthManager {

    private let db = Firestore.firestore()
    private let photoUploadManager = PhotoUploadManager()
    private var subscriptionSets = Set<AnyCancellable>()

    func signup(
        email: String,
        password: String,
        displayName: String,
        profileImage: Data?,
        biography: String
    ) -> AnyPublisher<Void, Error> {
        let profileImagePath = "profileImages/\(email)-\(UUID().uuidString).png"
        
        return photoUploadManager
            .upload(photoData: profileImage ?? Data(), withPath: profileImagePath)
            .flatMap { downloadableUrl in
                Auth.auth().createUser(withEmail: email, password: password)
                    .map(\.user.uid)
                    .map { BHHUser(userId: $0, email: email, displayName: displayName, profileImageUrl: downloadableUrl, biography: biography) }
            }
            .flatMap { self.db.collection("users").addDocument(from: $0) }
            .map { _ in () }
            .eraseToAnyPublisher()
//            .sink { completion in
//                switch completion {
//                case .finished:
//                    break
//                case .failure(let error):
//                    print("\(#file) \(#function): failed to add 'users' collection: \(error.localizedDescription)")
//                }
//            } receiveValue: { ref in
//
//            }
//            .store(in: &subscriptionSets)
    }
    
    func login(email: String, password: String) {
        
    }
}
