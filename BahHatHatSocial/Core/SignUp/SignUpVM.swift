//
//  SignUpVM.swift
//  BahHatHatSocial
//
//  Created by Kyaw Zay Ya Lin Tun on 11/13/22.
//

import SwiftUI
import Combine
import PhotosUI

class SignUpVM: ObservableObject {
    @Published var displayName: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var biography: String = ""
    @Published var selectedPhotoItem: PhotosPickerItem? = nil
    
    @Published var profileImage: UIImage? = nil
    @Published var confirmPasswordError: String? = nil
    @Published var shouldDisableSignUpCTA = true
    
    private var subscriptionsSet = Set<AnyCancellable>()
    
    init() {
        extractImageFromPhotoPickerItem()
        checkConfirmPassword()
        validateAndUpdateSignUpBtnState()
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
                self?.profileImage = image
            }
            .store(in: &subscriptionsSet)
    }
    
    private func checkConfirmPassword() {
        $password
            .combineLatest(
                $confirmPassword
                    .debounce(for: 0.5, scheduler: DispatchQueue.main)
            )
            .filter { !$1.isEmpty }
            .map { $0 == $1 ? nil : "Please make sure your passwords match." }
            .assign(to: &$confirmPasswordError)
    }
    
    private func validateAndUpdateSignUpBtnState() {
        Publishers.CombineLatest4($displayName, $email, $password, $confirmPassword)
            .map { $0.isEmpty || $1.isEmpty || $2.isEmpty || $3.isEmpty || $2 != $3 }
            .assign(to: &$shouldDisableSignUpCTA)
    }
}
