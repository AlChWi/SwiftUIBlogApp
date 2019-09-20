//
//  DetailView.swift
//  Blog App
//
//  Created by Алексей Перов on 18.09.2019.
//  Copyright © 2019 Алексей Перов. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    @EnvironmentObject var userData: UserData
    @State var comments: [Comment] = []
    
    let image = Image("UserPhotoPlaceholder")

    var post: Post

    var body: some View {
//        NavigationView {
            List {
                VStack(spacing: 15) {
                    HStack {
                        CircleImage(image: image)
                            .frame(width: 50, height: 50)
                        Text(userData.user?.name ?? "")
                            .font(.title)
                        Spacer()
                    }
                    HStack {
                        Text(post.title)
                            .font(.title)
                        Spacer()
                    }
                    HStack {
                        Text(post.body)
                            .font(.headline)
                            .multilineTextAlignment(.leading)
                        Spacer()
                    }
                }
                ForEach(comments) {comment in
                    CommentRow(comment: comment)
                }
            }.navigationBarTitle("Post Info")
            .onAppear() {
                NetworkService().getComments(byPostId: self.post.id) { comments in
                    self.comments = comments
                }
        }
//        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(comments: [], post: Post(userId: 1, title: "title", body: "body"))
    }
}

struct CommentRow: View {
    @State var comment: Comment
    let image = Image("UserPhotoPlaceholder")
    
    var body: some View {
        VStack {
            HStack {
                CircleImage(image: self.image)
                    .frame(width: 40, height: 40)
                Text(comment.name)
                    .font(.headline)
                Spacer()
            }
            .padding(.top)
            HStack {
                Text(comment.body)
                    .font(.body)
                Spacer()
            }
        }
    }
}
