//
//  PhotoUploadManager.swift
//  BahHatHatSocial
//
//  Created by Kyaw Zay Ya Lin Tun on 11/16/22.
//

import Foundation
import Combine
import FirebaseStorage
import FirebaseStorageCombineSwift

final class PhotoUploadManager {
    private let storage = Storage.storage()
    private let subscriptionsSet = Set<AnyCancellable>()
    
    func upload(photoData data: Data?, withPath filePath: String) -> AnyPublisher<String, Never> {
        guard let data = data else {
            return Just("").eraseToAnyPublisher()
        }
        
        let ref = storage.reference().child(filePath)
        
        return ref.putData(data)
            .flatMap { _ in ref.downloadURL() }
            .map(\.absoluteString)
            .replaceError(with: "")
            .eraseToAnyPublisher()
    }
}
