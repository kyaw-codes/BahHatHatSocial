//
//  HomeView.swift
//  BahHatHatSocial
//
//  Created by Kyaw Zay Ya Lin Tun on 11/14/22.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 12) {
                    Group {
                        Text("Hi, ") + Text("Kyaw Monkey").font(.title3.bold()).foregroundColor(.primary.opacity(0.8))
                    }
                    .font(.title3)
                    .foregroundColor(.gray)
                    
                    Text("BahHatHatSocial")
                        .font(.largeTitle.bold())
                }
                .padding(.horizontal)
                .frame(maxWidth: .infinity, alignment: .leading)
                
                PostView()
                
                PostView()
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
