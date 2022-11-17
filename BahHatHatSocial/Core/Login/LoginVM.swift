//
//  LoginVM.swift
//  BahHatHatSocial
//
//  Created by Kyaw Zay Ya Lin Tun on 11/13/22.
//

import SwiftUI
import Combine

class LoginVM: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var shouldDisableSignInCTA: Bool = true
    
    @Published var showingErrorAlert = false
    @Published var errorMessage = ""
    @Published var loading = false
    @Published var loginSuccess = false

    private var subscriptionsSet = Set<AnyCancellable>()
    
    init() {
        validateAndUpdateSignInBtnState()
    }
    
    func login() {
        loading.toggle()
        AuthManager().login(email: email, password: password)
            .sink { [weak self] completion in
                self?.loading.toggle()
                switch completion {
                case .finished: self?.loginSuccess.toggle()
                case .failure(let err):
                    self?.showingErrorAlert.toggle()
                    self?.errorMessage = err.localizedDescription
                }
            } receiveValue: { _ in }
            .store(in: &subscriptionsSet)
    }
    
    private func validateAndUpdateSignInBtnState() {
        $email.combineLatest($password)
            .map { $0.isEmpty || $1.isEmpty }
            .assign(to: &$shouldDisableSignInCTA)
    }
}
