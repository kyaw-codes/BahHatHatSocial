//
//  BHHUser.swift
//  BahHatHatSocial
//
//  Created by Kyaw Zay Ya Lin Tun on 11/15/22.
//

import Foundation
import FirebaseFirestoreSwift

struct BHHUser: Codable {
    @DocumentID var docId: String?
    let userId: String
    let email: String
    let displayName: String
    let profileImageUrl: String
    let biography: String
}
