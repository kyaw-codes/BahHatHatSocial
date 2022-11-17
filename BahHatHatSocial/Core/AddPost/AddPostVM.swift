//
//  AddPostVM.swift
//  BahHatHatSocial
//
//  Created by Kyaw Zay Ya Lin Tun on 11/17/22.
//

import SwiftUI
import Combine
import PhotosUI

class AddPostVM: ObservableObject {
    
    private let postManager = PostManager()
    
    @Published var postText = ""
    @Published var selectedImage: UIImage? = nil
    @Published var selectedPhotoItem: PhotosPickerItem? = nil

    @Published var shouldDisablePublishCTA = true
    @Published var showingErrorAlert = false
    @Published var errorMessage = ""
    @Published var loading = false

    private var subscriptionsSet = Set<AnyCancellable>()
    
    init() {
        extractImageFromPhotoPickerItem()
        validateAndUpdatePublishBtnState()
    }

    private func extractImageFromPhotoPickerItem() {
        $selectedPhotoItem
            .flatMap { selectedItem -> AnyPublisher<UIImage?, Error> in
                Future {
                    try await selectedItem?.loadTransferable(type: Data.self)
                }
                .compactMap { $0 }
                .map(UIImage.init(data:))
                .eraseToAnyPublisher()
            }
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished: break
                case .failure(let error):
                    print("\(#file) \(#function): failed to load image: \(error.localizedDescription)")
                }
            } receiveValue: { [weak self] image in
                self?.selectedImage = image
            }
            .store(in: &subscriptionsSet)
    }
    
    func createNewPost() {
        loading.toggle()
        
        postManager.createPost(text: postText, image: selectedImage?.pngData())
            .sink { [weak self] completion in
                self?.loading.toggle()
                switch completion {
                case .finished:
                    break
                case .failure(let err):
                    self?.showingErrorAlert.toggle()
                    self?.errorMessage = err.localizedDescription
                }
            } receiveValue: { post in
                dump(post)
            }
            .store(in: &subscriptionsSet)
    }
    
    private func validateAndUpdatePublishBtnState() {
        Publishers.CombineLatest($postText, $selectedImage)
            .map { $0.isEmpty && $1 == nil }
            .assign(to: &$shouldDisablePublishCTA)
    }
}
