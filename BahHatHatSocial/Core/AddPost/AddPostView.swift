//
//  AddPostView.swift
//  BahHatHatSocial
//
//  Created by Kyaw Zay Ya Lin Tun on 11/17/22.
//

import SwiftUI

struct AddPostView: View {
    @StateObject var vm = AddPostVM()
    @FocusState var isFocused: Bool
    
    var body: some View {
        NavigationStack {
            ScrollView {
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
                            Text("kyaw.codes@gmail.com")
                                .font(.footnote)
                                .foregroundColor(.primary.opacity(0.8))
                        }
                        Spacer()
                    }
                    .padding([.horizontal, .top])
                    
                    ZStack(alignment: .topLeading) {
                        if vm.postText.isEmpty {
                            Text("Placeholder Text")
                                .foregroundColor(.secondary)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 12)
                        }

                        TextEditor(text: $vm.postText)
                            .opacity(vm.postText.isEmpty ? 0.5 : 1)
                            .focused($isFocused, equals: true)
                    }
                    .font(.body)
                    .padding(.horizontal)
                }
            }
            .scrollDismissesKeyboard(.interactively)
            .navigationTitle("New Post")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        
                    } label: {
                        Text("Publish")
                    }
                }
                
                ToolbarItem(placement: .keyboard) {
                    Button {
                        
                    } label: {
                        Image(systemName: "photo")
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }

            }
            .onAppear {
                vm.postText = ""
                isFocused = true
            }
        }
    }
}

struct AddPostView_Previews: PreviewProvider {
    static var previews: some View {
        AddPostView()
    }
}
