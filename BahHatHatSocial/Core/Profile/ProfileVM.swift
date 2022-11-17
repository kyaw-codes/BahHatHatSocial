//
//  ProfileVM.swift
//  BahHatHatSocial
//
//  Created by Kyaw Zay Ya Lin Tun on 11/17/22.
//

import SwiftUI
import Combine

class ProfileVM: ObservableObject {
    @Published var successfullySignOut = false
    @Published var showingErrorAlert = false
    @Published var errorMessage = ""
    @Published var loading = false

    private let authManager = AuthManager()

    private var subscriptionsSet = Set<AnyCancellable>()

    func logout() {
        switch authManager.logout() {
        case .success(_): successfullySignOut.toggle()
        case .failure(let err):
            showingErrorAlert.toggle()
            errorMessage = err.localizedDescription
        }
    }
}
