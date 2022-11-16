//
//  LoadingView.swift
//  BahHatHatSocial
//
//  Created by Kyaw Zay Ya Lin Tun on 11/17/22.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
                .opacity(0.5)
                
            VStack(spacing: 12) {
                ProgressView()
                    .scaleEffect(1.4)
            }
            .padding(24)
            .background(.regularMaterial)
            .clipShape(Circle())
            .offset(y: -40)
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
