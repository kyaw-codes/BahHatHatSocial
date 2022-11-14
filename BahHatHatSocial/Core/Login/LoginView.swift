//
//  LoginView.swift
//  BahHatHatSocial
//
//  Created by Kyaw Zay Ya Lin Tun on 11/13/22.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var vm: LoginVM
    
    @State private var showSignUp = false
    
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
            .sheet(isPresented: $showSignUp, content: {
                SignUpView()
                    .environmentObject(SignUpVM())
            })
            .navigationTitle("Sign In")
        }
    }
    
    // MARK: - Views
    @ViewBuilder
    private func SignInButton() -> some View {
        Button {
            
        } label: {
            Text("Sign In")
                .padding(.vertical)
                .frame(maxWidth: .infinity)
                .background(
                    vm.shouldDisableSignInCTA ? Color.gray : Color.blue,
                    in: RoundedRectangle(cornerRadius: 12)
                )
                .foregroundColor(.white)
        }
        .disabled(vm.shouldDisableSignInCTA)
    }
    
    @ViewBuilder
    private func SignUpButton() -> some View {
        Button {
            showSignUp.toggle()
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
