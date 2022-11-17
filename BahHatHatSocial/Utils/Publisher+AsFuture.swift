//
//  Publisher+AsFuture.swift
//  BahHatHatSocial
//
//  Created by Kyaw Zay Ya Lin Tun on 11/17/22.
//

import Combine

extension Publisher {
    func asFuture() -> Future<Output, Failure> {
        return Future { promise in
            var cancellable: AnyCancellable? = nil
            cancellable = self.sink(
                receiveCompletion: { completion in
                    cancellable?.cancel()
                    cancellable = nil
                    
                    switch completion {
                    case .failure(let error):
                        promise(.failure(error))
                    case .finished:
                        break
                    }
                },
                receiveValue: {
                    cancellable?.cancel()
                    cancellable = nil
                    promise(.success($0))
                })
        }
    }
}
