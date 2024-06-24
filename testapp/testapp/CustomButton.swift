//
//  CustomButton.swift
//  testapp
//
//  Created by LOGIN on 2024-06-23.
//

import SwiftUI

struct CustomButton: View {
    var buttonText: String
    var imageName: String
    var isActive
    
    var body: some View {
        VStack{
            Image(imageName)
            Text(buttonText)
        }

    }
}

#Preview {
    CustomButton()
}
