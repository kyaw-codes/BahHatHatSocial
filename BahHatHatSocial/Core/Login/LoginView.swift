//
//  LoginView.swift
//  BahHatHatSocial
//
//  Created by Kyaw Zay Ya Lin Tun on 11/13/22.
//

import SwiftUI

struct LoginView: View {
    enum FocusedField: String {
        case email
        case password
    }
    
    @EnvironmentObject var mainAppFlowVM: MainAppFlowVM
    @StateObject var vm = LoginVM()
    @FocusState var focusState: FocusedField?
    
    @State private var showSignUp = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    TextField("Email", text: $vm.email)
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.emailAddress)
                        .focused($focusState, equals: .email)

                    SecureField("Passsword", text: $vm.password)
                        .textFieldStyle(.roundedBorder)
                        .focused($focusState, equals: .password)
                    
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
            .alert(vm.errorMessage, isPresented: $vm.showingErrorAlert) {
                Button("OK", role: .cancel) { }
            }
            .overlay {
                if vm.loading {
                    LoadingView()
                }
            }
            .onChange(of: vm.loginSuccess) { success in
                mainAppFlowVM.shouldShowLogin = !success
                focusState = nil
            }
        }
    }
    
    // MARK: - Views
    @ViewBuilder
    private func SignInButton() -> some View {
        Button(action: vm.login) {
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
