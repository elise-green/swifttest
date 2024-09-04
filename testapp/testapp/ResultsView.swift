//
//  ResultsView.swift
//  testapp
//
//  Created by Elise Green on 2024-08-29.
//

import SwiftUI

struct ResultsView: View {
    let processedImage: UIImage
    
    var body: some View {
        VStack {
            Image(uiImage: processedImage)
                .resizable()
                .scaledToFit()
                .padding()
            
            Spacer()
        }
        .navigationBarTitle("Detection Results", displayMode: .inline)
    }
}

struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsView(processedImage: UIImage())
    }
}
