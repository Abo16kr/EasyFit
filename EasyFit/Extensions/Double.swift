//
//  Double.swift
//  EasyFit
//
//  Created by Abobakr Al Zain  on 10.03.2024.
//

import Foundation

extension Double {
    func formattedSting() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 0
        
        return numberFormatter.string(from: NSNumber(value: self))!
    }
}
