//
//  CircularProfileImageView.swift
//  BahHatHatSocial
//
//  Created by Kyaw Zay Ya Lin Tun on 11/17/22.
//

import SwiftUI

struct CircularProfileImageView: View {
    
    let url: String?
    let size: CGSize
    
    var body: some View {
        if let url = url, !url.isEmpty {
            AsyncImage(url: URL(string: url)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipShape(Circle())
            } placeholder: {
                ZStack {
                    DefaultProfileImageView()
                    Color.black.opacity(0.7)
                        .clipShape(Circle())
                    ProgressView()
                        .tint(.white)
                        .scaleEffect(1.4)
                }
            }
            .frame(width: size.width, height: size.height)
        } else {
            DefaultProfileImageView()
        }
    }
    
    @ViewBuilder
    private func DefaultProfileImageView() -> some View {
        Image("defaultProfile")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: size.width, height: size.height)
            .clipShape(Circle())
    }
}
