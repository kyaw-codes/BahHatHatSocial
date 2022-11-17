//
//  MainTabView.swift
//  BahHatHatSocial
//
//  Created by Kyaw Zay Ya Lin Tun on 11/14/22.
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var mainAppFlowVM: MainAppFlowVM
    @State private var selectedTab = 1
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                .tag(1)
            
            AddPostView()
                .tabItem {
                    Label("New Post", systemImage: "plus.square")
                }
                .tag(2)

            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
                .tag(3)
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
