//
//  NumbersExtension.swift
//  meds
//
//  Created by Yohana Priscillia on 06/12/20.
//

import Foundation

extension Float {
    // toString convert float to string with decimals only if exist
    var toString: String {
       return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(format: "%.1f", self)
    }
}
