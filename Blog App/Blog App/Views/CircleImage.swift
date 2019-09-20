//
//  CircleImage.swift
//  Blog App
//
//  Created by Алексей Перов on 19.09.2019.
//  Copyright © 2019 Алексей Перов. All rights reserved.
//

import SwiftUI

struct CircleImage: View {
    var image: Image

    var body: some View {
        image
            .resizable()
            .renderingMode(.original)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.white, lineWidth: 4))
//            .shadow(radius: 10)
    }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        CircleImage(image: Image("UserPhotoPlaceholder"))
    }
}
