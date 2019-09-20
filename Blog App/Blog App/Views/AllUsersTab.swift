//
//  AllUsersTab.swift
//  Blog App
//
//  Created by Алексей Перов on 20.09.2019.
//  Copyright © 2019 Алексей Перов. All rights reserved.
//

import SwiftUI

struct AllUsersTab: View {
    @State var users: [User] = []
    let image = Image("UserPhotoPlaceholder")
    
    var body: some View {
        NavigationView {
            List(users) { user in
                HStack {
                    CircleImage(image: self.image)
                        .frame(width: 50, height: 50)
                    Text(user.name)
                }
            }.onAppear() {
                NetworkService().getAllUsers { (users) in
                    self.users = users
                }
            }
        .navigationBarTitle("All Users")
        }
    }
}

struct AllUsersTab_Previews: PreviewProvider {
    static var previews: some View {
        AllUsersTab()
    }
}
