//
//  AddPostView.swift
//  BahHatHatSocial
//
//  Created by Kyaw Zay Ya Lin Tun on 11/17/22.
//

import SwiftUI
import PhotosUI

struct AddPostView: View {
    @EnvironmentObject var mainAppFlowVM: MainAppFlowVM

    @StateObject var vm = AddPostVM()
    @FocusState var isFocused: Bool
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    HStack(spacing: 12) {
                        CircularProfileImageView(url: mainAppFlowVM.currentUser?.profileImageUrl, size: .init(width: 48, height: 48))
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(mainAppFlowVM.currentUser?.displayName ?? "")
                                .font(.headline)
                            Text(mainAppFlowVM.currentUser?.email ?? "")
                                .font(.footnote)
                                .foregroundColor(.primary.opacity(0.8))
                        }
                        Spacer()
                    }
                    .padding([.horizontal, .top])
                    
                    ZStack(alignment: .topLeading) {
                        if vm.postText.isEmpty {
                            Text("Type or paste something bah-hat-hat")
                                .foregroundColor(.secondary)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 12)
                        }
                        
                        TextEditor(text: $vm.postText)
                            .opacity(vm.postText.isEmpty ? 0.5 : 1)
                            .focused($isFocused, equals: true)
                            .padding(.top, 5)
                    }
                    .font(.body)
                    .padding(.horizontal)
                    
                    if let image = vm.selectedImage {
                        ZStack(alignment: .topTrailing) {
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: UIScreen.main.bounds.width)
                            
                            Button {
                                vm.selectedImage = nil
                            } label: {
                                Image(systemName: "xmark")
                                    .font(.title)
                                    .foregroundColor(.white)
                                    .padding()
                            }
                        }
                    }
                }
            }
            .scrollDismissesKeyboard(.interactively)
            .navigationTitle("New Post")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: vm.createNewPost) {
                        Text("Publish")
                            .foregroundColor(vm.shouldDisablePublishCTA ? .gray : .blue)
                    }
                    .disabled(vm.shouldDisablePublishCTA)
                }
                
                ToolbarItem(placement: .keyboard) {
                    PhotosPicker(
                        selection: $vm.selectedPhotoItem,
                        matching: .images,
                        photoLibrary: .shared()
                    ) {
                        Image(systemName: "photo")
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
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
            .onAppear {
                vm.postText = ""
                vm.selectedImage = nil
                isFocused = true
            }
            .onChange(of: vm.hasBeenPosted) { posted in
                if posted {
                    mainAppFlowVM.selectedTab = 1
                }
            }
        }
    }
}

struct AddPostView_Previews: PreviewProvider {
    static var previews: some View {
        AddPostView()
    }
}
