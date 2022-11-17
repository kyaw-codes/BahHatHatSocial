//
//  HomeView.swift
//  BahHatHatSocial
//
//  Created by Kyaw Zay Ya Lin Tun on 11/14/22.
//

import SwiftUI
import FirebaseFirestoreSwift

struct HomeView: View {
    @EnvironmentObject private var mainAppFlowVM: MainAppFlowVM
    @StateObject private var vm = HomeVM()
    
    @FirestoreQuery(
        collectionPath: "posts",
        predicates: [.order(by: "postedDate", descending: true)]
    )
    var allPosts: [BHHPost]
    
    @FirestoreQuery(collectionPath: "users") var allUsers: [BHHUser]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 12) {
                    Group {
                        Text("Hi, ")
                        +
                        Text(mainAppFlowVM.currentUser?.displayName ?? "")
                            .fontWeight(.bold)
                            .foregroundColor(.primary.opacity(0.8))
                    }
                    .font(.title3)
                    .foregroundColor(.gray)
                    
                    Text("BahHatHatSocial")
                        .font(.largeTitle.bold())
                }
                .padding(.horizontal)
                .frame(maxWidth: .infinity, alignment: .leading)
                
                let userDict = allUsers
                    .reduce(into: [:]) { $0[$1.docId ?? ""] = $1 }
                                
                ForEach(allPosts.map(PostVO.init(post:))) { post in
                    LazyVGrid(columns: [GridItem(.flexible())]) {
                        PostView(vo: post, user: userDict[post.postedUserDocId])
                    }
                }
            }
            .safeAreaInset(edge: .top) {
                Color(uiColor: .systemBackground)
                    .edgesIgnoringSafeArea(.top)
                    .frame(height: 0)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
