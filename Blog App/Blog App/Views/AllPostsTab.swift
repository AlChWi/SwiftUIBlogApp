//
//  AllPostsTab.swift
//  Blog App
//
//  Created by Алексей Перов on 20.09.2019.
//  Copyright © 2019 Алексей Перов. All rights reserved.
//

import SwiftUI

struct AllPostsTab: View {
    @State var posts: [Post] = []
    var body: some View {
        NavigationView {
            List(posts) { post in
                PostRow(post: post)
            }.onAppear() {
                NetworkService().getAllPosts { (posts) in
                    self.posts = posts
                }
            }
            .navigationBarTitle("All Posts")
        }
    }
}

struct AllPostsTab_Previews: PreviewProvider {
    static var previews: some View {
        AllPostsTab()
    }
}
