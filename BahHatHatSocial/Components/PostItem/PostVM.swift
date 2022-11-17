//
//  PostVM.swift
//  BahHatHatSocial
//
//  Created by Kyaw Zay Ya Lin Tun on 11/17/22.
//

import SwiftUI
import Combine

final class PostVM: ObservableObject {
    @Published var showingAlert = false
    @Published var alertTitle = ""
    
    private let postManager = PostManager()
    private var subscriptionsSet = Set<AnyCancellable>()
    
    func presentDeleteConfirmationAlert() {
        showingAlert.toggle()
        alertTitle = "This will permantely remove the post and this actoin cannot be undone."
    }
    
    func deletePost(id: String) {
        postManager.deletePost(id: id)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let err):
                    print("\(#file) \(#function): \(err.localizedDescription)")
                }
            } receiveValue: { _ in }
            .store(in: &subscriptionsSet)
    }
}

