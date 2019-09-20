//
//  SwiftUIView.swift
//  Blog App
//
//  Created by Алексей Перов on 19.09.2019.
//  Copyright © 2019 Алексей Перов. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var userData: UserData
    @State var userId = ""
    @Binding var signedIn: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Welcome!")
                    .font(.largeTitle)
                    .padding(.bottom, 25)
                Text("Choose userID from JSONPlaceholder and log in")
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .padding(.leading)
                    .padding(.trailing)
                    .padding(.bottom, 50)
                TextField("UserId", text: $userId).padding(.leading)
                    .padding(.trailing)
                    .padding(.top)
                    .padding(.bottom, 25)
                Button(action: {
                    self.signedIn = true
                    self.userData.loadAll(userId: Int(self.userId) ?? 1)
                }) {
                    Text("Log In")
                        .font(.headline)
                }
                Spacer()
            }
        }
    }
}

//struct SwiftUIView_Previews: PreviewProvider {
//    static var previews: some View {
////        LoginView(signedIn: true)
//    }
//}
