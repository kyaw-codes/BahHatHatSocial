//
//  Date+Format.swift
//  BahHatHatSocial
//
//  Created by Kyaw Zay Ya Lin Tun on 11/17/22.
//

import Foundation

extension Date {
    
    var presentableString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a d MMM, yyyy"
        return dateFormatter.string(from: self)
    }
}
