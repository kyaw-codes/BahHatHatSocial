//
//  LoginView.swift
//  BahHatHatSocial
//
//  Created by Kyaw Zay Ya Lin Tun on 11/13/22.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var vm: LoginVM
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    TextField("Email", text: $vm.email)
                        .textFieldStyle(.roundedBorder)

                    SecureField("Passsword", text: $vm.password)
                        .textFieldStyle(.roundedBorder)
                    
                    Spacer(minLength: 40)
                    
                    SignInButton()
                        
                    SignUpButton()
                }
                .padding()
            }
            .scrollDismissesKeyboard(.interactively)
            .navigationTitle("Sign In")
        }
    }
    
    // MARK: - Views
    @ViewBuilder
    func SignInButton() -> some View {
        Button {
            
        } label: {
            Text("Sign In")
                .padding(.vertical)
                .frame(maxWidth: .infinity)
                .background(
                    Color.blue.opacity(vm.shouldDisableSignInCTA ? 0.5 : 1),
                    in: RoundedRectangle(cornerRadius: 12)
                )
                .foregroundColor(.white)
        }
        .disabled(vm.shouldDisableSignInCTA)
    }
    
    @ViewBuilder
    func SignUpButton() -> some View {
        Button {
            
        } label: {
            Text("Sign Up")
                .padding(.vertical)
                .frame(maxWidth: .infinity)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(LoginVM())
    }
}
