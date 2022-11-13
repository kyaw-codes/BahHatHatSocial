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
    
    init() {
        validateAndUpdateSignInBtnState()
    }
    
    private func validateAndUpdateSignInBtnState() {
        $email.combineLatest($password)
            .map { $0.isEmpty || $1.isEmpty }
            .assign(to: &$shouldDisableSignInCTA)
    }
}
