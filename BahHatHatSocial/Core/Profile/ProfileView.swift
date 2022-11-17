//
//  ProfileView.swift
//  BahHatHatSocial
//
//  Created by Kyaw Zay Ya Lin Tun on 11/14/22.
//

import SwiftUI

struct ProfileView: View {
    @StateObject private var vm = ProfileVM()
    @EnvironmentObject var mainAppFlowVM: MainAppFlowVM
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    ProfileView()
                    InfoView()
                }
                .padding(.bottom, 10)
                .background(Color(uiColor: .systemBackground))
                
                Divider()
            }
            .navigationTitle("kyaw.codes@gmail.com")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button(action: vm.logout) {
                    Text("Log out")
                }
            }
            .alert(vm.errorMessage, isPresented: $vm.showingErrorAlert) {
                Button("OK", role: .cancel) { }
            }
            .onChange(of: vm.successfullySignOut) { successfullySignOut in
                mainAppFlowVM.shouldShowLogin = successfullySignOut
            }
        }
    }
    
    @ViewBuilder
    private func ProfileView() -> some View {
        HStack {
            Image(systemName: "person")
                .font(.largeTitle)
                .frame(width: 80, height: 80)
                .foregroundColor(.white)
                .background(.gray.opacity(0.5), in: Circle())
            
            Spacer()
            Spacer()
            
            VStack {
                Text("10")
                    .font(.title3.bold())
                Text("Posts")
                    .font(.caption)
            }
            
            Spacer()
            
            VStack {
                Text("12")
                    .font(.title3.bold())
                Text("Followers")
                    .font(.caption)
            }
            
            Spacer()
            
            VStack {
                Text("5")
                    .font(.title3.bold())
                Text("Following")
                    .font(.caption)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
    
    @ViewBuilder
    private func InfoView() -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Kyaw Monkey")
                .font(.headline)
            Text("iOS @CodigoApps | Programming Mentor | Swift enthusiast | Community Builder | Organising CocoaHeads Myanmar 🇲🇲")
                .foregroundColor(.gray)
            
            Button {
                
            } label: {
                Text("Edit profile")
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
