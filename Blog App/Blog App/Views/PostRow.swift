//
//  PostRow.swift
//  Blog App
//
//  Created by Алексей Перов on 18.09.2019.
//  Copyright © 2019 Алексей Перов. All rights reserved.
//

import SwiftUI

struct PostRow: View {
    var post: Post
    @State var user: User?
    let image = Image("UserPhotoPlaceholder")

    var body: some View {
        VStack {
            HStack {
                CircleImage(image: image).frame(width: 34, height: 34)
                Text(user?.name ?? "")
                    .font(.title)
                Spacer()
            }
            VStack {
                HStack {
                    Text(post.title)
                        .font(.headline)
                    Spacer()
                }
                HStack {
                    Text(post.body)
                        .font(.body)
                    Spacer()
                }
            }
        }.onAppear() {
            NetworkService().getUser(byId: self.post.userId) { (user) in
                self.user = user
            }
        }
    }
}

struct PostRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PostRow(post: Post(userId: 2, title: "asd", body: "asfa"))
            PostRow(post: Post(userId: 3, title: "saf", body: "fafa"))
        }
        .previewLayout(.fixed(width: 300, height: 200))
    }
}
