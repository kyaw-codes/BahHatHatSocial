//
//  ProfileVM.swift
//  BahHatHatSocial
//
//  Created by Kyaw Zay Ya Lin Tun on 11/17/22.
//

import SwiftUI

class ProfileVM: ObservableObject {
    
    @Published var showingErrorAlert = false
    @Published var errorMessage = ""
    @Published var successfullySignOut = false
    
    func logout() {
        let result = AuthManager().logout()
        switch result {
        case .success(_): successfullySignOut.toggle()
        case .failure(let err):
            showingErrorAlert.toggle()
            errorMessage = err.localizedDescription
        }
    }
}
