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
    private let auth = Auth.auth()
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
                self.auth.createUser(withEmail: email, password: password)
                    .map(\.user.uid)
                    .map {
                        BHHUser(
                            userId: $0, email: email,
                            displayName: displayName,
                            profileImageUrl: profileImage == nil ? "" : downloadableUrl,
                            biography: biography
                        )
                    }
            }
            .flatMap { self.db.collection("users").addDocument(from: $0) }
            .map { _ in () }
            .eraseToAnyPublisher()
    }
    
    func login(email: String, password: String) -> AnyPublisher<User, Error> {
        auth.signIn(withEmail: email, password: password)
            .map(\.user)
            .eraseToAnyPublisher()
    }
    
    func logout() -> Result<Void, Error> {
        do {
            try auth.signOut()
            return .success(())
        } catch {
            return .failure(error)
        }
    }
    
    func fetchAllUsers() -> AnyPublisher<[BHHUser], Error> {
        db.collection("users").getDocuments()
            .map { snapshot in
                snapshot.documents.compactMap {
                    try? $0.data(as: BHHUser.self)
                }
            }
            .eraseToAnyPublisher()
    }
    
    func fetchUser(withDocId id: String) -> AnyPublisher<BHHUser?, Error> {
        db.collection("users").document(id).getDocument()
            .map { try? $0.data(as: BHHUser.self) }
            .eraseToAnyPublisher()
    }
    
    func fetchUser(withUserId id: String) -> AnyPublisher<BHHUser?, Error> {
        fetchAllUsers()
            .map { users in
                users.first { $0.userId == id }
            }
            .eraseToAnyPublisher()
    }
    
    func currentUser() -> AnyPublisher<BHHUser?, Error> {
        let currentUserId = Just(currentUserId()).compactMap { $0 }.share()
        let changedUserId = auth.authStateDidChangePublisher().compactMap(\.?.uid).share()
        
        return currentUserId.merge(with: changedUserId)
            .flatMap(fetchUser(withUserId:))
            .eraseToAnyPublisher()
    }

    func hasAlreadyLoggedIn() -> Bool {
        auth.currentUser != nil
    }

    func currentUserId() -> String? {
        auth.currentUser?.uid
    }
}
