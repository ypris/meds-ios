//
//  ButtonPrimary.swift
//  meds
//
//  Created by Yohana Priscillia on 07/12/20.
//

import SwiftUI

// ButtonPrimary handles FE for primary button element
struct ButtonPrimary: View {
    let label: String
    var color: Color = .black
    var disabled: Bool = false
    let action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }) {
            Text(label.uppercased())
                .font(Font.system(size: 16))
                .fontWeight(.medium)
                .frame(maxWidth: .infinity)
                .padding()
                .background(disabled ? Color.gray : color)
                .cornerRadius(5)
                .foregroundColor(.white)
                .shadow(color: .gray, radius: 4, x:0, y:4)
                .opacity(disabled ? 0.4 : 1.0)
        }
        .disabled(disabled)
    }
}

struct ButtonPrimary_Previews: PreviewProvider {
    static var previews: some View {
        ButtonPrimary(label: "Test", action: { print("Button tapped.") })
    }
}
