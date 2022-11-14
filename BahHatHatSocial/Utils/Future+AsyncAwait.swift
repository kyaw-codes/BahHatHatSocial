//
//  Future+AsyncAwait.swift
//  BahHatHatSocial
//
//  Created by Kyaw Zay Ya Lin Tun on 11/14/22.
//

import Combine

extension Future where Failure == Error {
    convenience init(asyncFunc: @escaping () async throws -> Output) {
        self.init { promise in
            Task {
                do {
                    let output = try await asyncFunc()
                    promise(.success(output))
                } catch {
                    promise(.failure(error))
                }
            }
        }
    }
}
