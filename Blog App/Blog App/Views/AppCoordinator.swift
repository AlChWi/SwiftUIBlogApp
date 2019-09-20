//
//  AppCoordinator.swift
//  Blog App
//
//  Created by Алексей Перов on 20.09.2019.
//  Copyright © 2019 Алексей Перов. All rights reserved.
//

import SwiftUI

struct AppCoordinator: View {
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        return Group {
            if userData.settingsStore.signedIn {
                TabView {
                    ContentView().environmentObject(userData)
                        .tabItem {
                            VStack {
                                Image(systemName: "person.crop.circle.fill")
                                Text("My Posts")
                            }
                    }
                    AllPostsTab()
                        .tabItem {
                            VStack {
                                Image(systemName: "book.fill")
                                Text("All Posts")
                            }
                    }
                    AllUsersTab()
                        .tabItem {
                            VStack {
                                Image(systemName: "person.3.fill")
                                Text("All Posts")
                            }
                    }
                }
            }
            else {
                LoginView(signedIn: $userData.settingsStore.signedIn).environmentObject(userData)
            }
        }    }
}

struct AppCoordinator_Previews: PreviewProvider {
    static var previews: some View {
        AppCoordinator()
    }
}
