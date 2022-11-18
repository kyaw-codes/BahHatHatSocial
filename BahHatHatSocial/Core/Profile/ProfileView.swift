//
//  ProfileView.swift
//  BahHatHatSocial
//
//  Created by Kyaw Zay Ya Lin Tun on 11/14/22.
//

import SwiftUI
import FirebaseFirestoreSwift

struct ProfileView: View {
    @StateObject private var vm = ProfileVM()
    @EnvironmentObject var mainAppFlowVM: MainAppFlowVM
    
    @FirestoreQuery(
        collectionPath: "posts",
        predicates: [
            .isEqualTo("postedByUser.userId", AuthManager().currentUserId() ?? "")
        ]
    )
    var posts: [BHHPost]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    ProfileHeaderView()
                    InfoView()
                }
                .padding(.bottom, 10)
                .background(Color(uiColor: .systemBackground))
                
                Divider()
                
let sortedPosts = posts
    .sorted(by: {
        $0.postedDate ?? Date() > $1.postedDate ?? Date()
    })
    .map(PostVO.init(post:))

                ForEach(sortedPosts) { post in
                    LazyVGrid(columns: [GridItem(.flexible())]) {
                        PostView(vo: post, user: mainAppFlowVM.currentUser!)
                    }
                }
            }
            .navigationTitle(mainAppFlowVM.currentUser?.email ?? "")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button(action: vm.logout) {
                    Text("Log out")
                }
            }
            .alert(vm.errorMessage, isPresented: $vm.showingErrorAlert) {
                Button("OK", role: .cancel) { }
            }
            .overlay {
                if vm.loading {
                    LoadingView()
                }
            }
            .onChange(of: vm.successfullySignOut) { successfullySignOut in
                mainAppFlowVM.selectedTab = 1
                mainAppFlowVM.shouldShowLogin = successfullySignOut
            }
        }
    }
    
    @ViewBuilder
    private func ProfileHeaderView() -> some View {
        HStack {
            CircularProfileImageView(url: mainAppFlowVM.currentUser?.profileImageUrl, size: .init(width: 80, height: 80))

            Spacer()
            Spacer()
            
            VStack {
                Text("\(posts.count)")
                    .font(.title3.bold())
                Text("Post(s)")
                    .font(.caption)
            }
            
            Spacer()
            
            VStack {
                Text("0")
                    .font(.title3.bold())
                Text("Follower(s)")
                    .font(.caption)
            }
            
            Spacer()
            
            VStack {
                Text("0")
                    .font(.title3.bold())
                Text("Following(s)")
                    .font(.caption)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
    
    @ViewBuilder
    private func InfoView() -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(mainAppFlowVM.currentUser?.displayName ?? "")
                .font(.headline)
            
            if let bio = mainAppFlowVM.currentUser?.biography {
                Text(bio)
                    .foregroundColor(.gray)
            }
            
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
