//
//  LoadingImage.swift
//  EasyFit
//
//  Created by Abobakr Al Zain  on 10.03.2024.
//

import SwiftUI

struct LoadingImage: View {
    let urlImage: String
    var body: some View {
        AsyncImage(url: URL(string: urlImage)) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .scaledToFill()
            } else if phase.error != nil {
                Text("error loading image.")
            } else {
                ProgressView()
            }
        }
    }
}

#Preview {
    LoadingImage(urlImage: "https://st.stayksa.com/uploads/travel_experince/1680380460.jpg")
        .padding(.all)
        .previewLayout(.sizeThatFits)
}
