//
//  PostView.swift
//  BahHatHatSocial
//
//  Created by Kyaw Zay Ya Lin Tun on 11/17/22.
//

import SwiftUI

struct PostView: View {
    let vo: PostVO
    
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
                        Text(vo.postedDate.presentableString)
                            .font(.footnote)
                            .foregroundColor(.primary.opacity(0.8))
                    }
                    
                    Spacer()
                }
                
                Text(vo.postText)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.primary)
                
                if !vo.imageUrl.isEmpty {
                    AsyncImage(url: URL(string: vo.imageUrl)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: UIScreen.main.bounds.width)
                    } placeholder: {
                        ZStack {
                            Color.primary.opacity(0.3)
                                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
                            
                            ProgressView()
                                .scaleEffect(2)
                        }
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
                        
                        Text("\(vo.likeCount) Like(s)")
                    }
                    .frame(maxWidth: .infinity)
                }
                
                Button {
                    
                } label: {
                    HStack {
                        Image(systemName: "bubble.left")
                            .font(.title2)
                        
                        Text("\(vo.commentCount) Comment(s)")
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
        PostView(vo: .init(documentId: "", postedDate: Date(), postText: "", imageUrl: "", postedBy: ""))
    }
}
