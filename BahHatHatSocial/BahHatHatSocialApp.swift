//
//  BahHatHatSocialApp.swift
//  BahHatHatSocial
//
//  Created by Kyaw Zay Ya Lin Tun on 11/13/22.
//

import SwiftUI

@main
struct BahHatHatSocialApp: App {
    @StateObject var loginVM = LoginVM()
    
    var body: some Scene {
        WindowGroup {
            LoginView()
                .environmentObject(loginVM)
        }
    }
}
