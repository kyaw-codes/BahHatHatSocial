//
//  PostView.swift
//  BahHatHatSocial
//
//  Created by Kyaw Zay Ya Lin Tun on 11/17/22.
//

import SwiftUI

struct PostView: View {
    var body: some View {
        VStack {
            VStack {
                HStack(spacing: 12) {
                    Image(systemName: "person.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 48, height: 48)
                        .clipShape(Circle())
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("KyawMonkey")
                            .font(.headline)
                        Text("19 Nov, 2022 12:31 PM")
                            .font(.footnote)
                            .foregroundColor(.primary.opacity(0.8))
                    }
                    
                    Spacer()
                }
                
                Text("Lorem ipsum, or lipsum as it is sometimes known, is dummy text used in laying out print, graphic or web designs. The passage is attributed to an unknown typesetter in the 15th century who is thought to have scrambled parts of Cicero's De Finibus Bonorum et Malorum for use in a type specimen book.")
                    .foregroundColor(.primary)
                
                AsyncImage(url: URL(string: "https://images.unsplash.com/photo-1517960413843-0aee8e2b3285?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxleHBsb3JlLWZlZWR8Mnx8fGVufDB8fHx8&w=1000&q=80")) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    ZStack {
                        Color.primary.opacity(0.3)
                        
                        ProgressView()
                            .scaleEffect(2)
                    }
                }
            }
            .padding(.horizontal)
            
            HStack {
                Button {
                    
                } label: {
                    HStack {
                        Image(systemName: "hand.thumbsup")
                            .font(.title2)
                        
                        Text("1 Like")
                    }
                    .frame(maxWidth: .infinity)
                }
                
                Button {
                    
                } label: {
                    HStack {
                        Image(systemName: "bubble.left")
                            .font(.title2)
                        
                        Text("0 Comment")
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            
            Divider()
        }
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView()
    }
}
