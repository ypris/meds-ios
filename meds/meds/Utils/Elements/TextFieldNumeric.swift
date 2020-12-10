//
//  TextFieldNumeric.swift
//  meds
//
//  Created by Yohana Priscillia on 06/12/20.
//

import SwiftUI
import Combine

// TextFieldNumeric ensures the text field input is number only
struct TextFieldNumeric: View {
    let title: String
    @Binding var text: Int
    
    var body: some View {
        TextField(title, text: Binding<String>(
            get: {
                self.text != 0 ? "\(self.text)" : ""
            },
            set: {
                let filtered = $0.filter{ "0123456789".contains($0) }
                self.text = Int(filtered) ?? 0
            }
        ))
        .keyboardType(.numberPad)
    }
}

// TextFieldDecimal ensures the text field input is number only and allows decimal
struct TextFieldDecimal: View {
    let title: String
    @Binding var text: Float
    
    var body: some View {
        TextField(title, text: Binding<String>(
            get: {
                self.text != 0 ? self.text.toString : ""
            },
            set: {
                let filtered = $0.filter{ "0123456789.".contains($0) }
                self.text = Float(filtered) ?? 0
            }
        ))
        .keyboardType(.numbersAndPunctuation)
    }
}

// TextFieldDecimalOptional is same as TextFieldDecimal but for Optional Float
struct TextFieldDecimalOptional: View {
    let title: String
    @Binding var text: Float?
    
    var body: some View {
        TextField(title, text: Binding<String>(
            get: {
                self.text != nil && self.text != 0 ? self.text!.toString : ""
            },
            set: {
                let filtered = $0.filter{ "0123456789.".contains($0) }
                self.text = Float(filtered) ?? nil
            }
        ))
        .keyboardType(.numbersAndPunctuation)
    }
}
