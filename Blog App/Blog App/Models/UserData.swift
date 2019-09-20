//
//  UserData.swift
//  Blog App
//
//  Created by Алексей Перов on 19.09.2019.
//  Copyright © 2019 Алексей Перов. All rights reserved.
//

import Foundation
import Combine

class UserData: ObservableObject {
    @Published var user: User?
    @Published var posts: [Post] = []
    @Published var settingsStore = SettingsStore()
    
    func loadAll(userId: Int) {
        NetworkService().getUser(byId: userId) { (user) in
            guard let aUser = user else { return }
            DispatchQueue.main.async {
                self.user = aUser
            }
            print(self.user)
        }
        NetworkService().getPosts(byId: userId) { (posts) in
            DispatchQueue.main.async {
                self.posts = posts
            }
        }
    }
    func clean() {
        self.user = nil
        self.posts = []
    }
    
    init(userId: Int) {
        self.loadAll(userId: userId)
    }
    init() {
    }
}
