//
//  DefaultTextFieldBehavior.swift
//  BahHatHatSocial
//
//  Created by Kyaw Zay Ya Lin Tun on 11/13/22.
//

import SwiftUI

struct DefaultTextFieldBehavior: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .autocorrectionDisabled(true)
            .textInputAutocapitalization(.never)
    }
}

extension View {
    func defaultTextFieldBehavior() -> some View {
        self.modifier(DefaultTextFieldBehavior())
    }
}
