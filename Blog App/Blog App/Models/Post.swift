//
//  Post.swift
//  Blog App
//
//  Created by Алексей Перов on 18.09.2019.
//  Copyright © 2019 Алексей Перов. All rights reserved.
//

import Foundation

struct Post: Identifiable, Hashable, Codable {
    var userId: Int
    var id: Int
    var title: String
    var body: String
    
    init(userId: Int, title: String, body: String) {
        self.title = title
        self.body = body
        self.userId = userId
        self.id = UUID().hashValue
    }
    init(userId: Int, id: Int, title: String, body: String) {
        self.title = title
        self.body = body
        self.userId = userId
        self.id = id
    }
}
