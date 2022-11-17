//
//  BahHatHatSocialApp.swift
//  BahHatHatSocial
//
//  Created by Kyaw Zay Ya Lin Tun on 11/13/22.
//

import SwiftUI
import Firebase
import Combine

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

class MainAppFlowVM: ObservableObject {
    @Published var shouldShowLogin = false
    @Published var selectedTab = 1
    @Published var currentUser: BHHUser? = nil
    
    init() {
        AuthManager().currentUser().replaceError(with: nil).assign(to: &$currentUser)
    }
}

@main
struct BahHatHatSocialApp: App {
    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate
    
    @StateObject var vm = MainAppFlowVM()
    
    var body: some Scene {
        WindowGroup {
            if AuthManager().hasAlreadyLoggedIn() && !vm.shouldShowLogin {
                MainTabView()
                    .environmentObject(vm)
            } else {
                LoginView()
                    .environmentObject(vm)
            }
        }
    }
}
