//
//  UserInfoView.swift
//  Blog App
//
//  Created by Алексей Перов on 19.09.2019.
//  Copyright © 2019 Алексей Перов. All rights reserved.
//

import SwiftUI
import Combine

struct UserInfoView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var userData: UserData
    let image = Image("UserPhotoPlaceholder")

    var body: some View {

            VStack {
                Image("UserBackgroundPlaceholder").resizable()
                    .edgesIgnoringSafeArea(.top)
                    .frame(height: 200)
                CircleImage(image: image)
                    .frame(width: 150, height: 150)
                    .offset(x: 0, y: -100)
                    .padding(.bottom, -100)
                    .shadow(radius: 10)
                Text(userData.user?.name ?? "")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                HStack {
                    Text("Username:")
                    Spacer()
                    Text(userData.user?.username ?? "")
                        .fontWeight(.light)
                        .foregroundColor(Color.gray)
                }
                    .padding(.leading)
                    .padding(.top)
                    .padding(.bottom)
                    .padding(.trailing)
                VStack {
                    Text("Company Info:").padding(.leading)
                    .padding(.trailing)
                    .font(.title)
                    .frame(width: UIScreen.main.bounds.width)
                    .padding(.top)
                    .padding(.bottom)
                    HStack {
                        Text("Company name:")
                        Spacer()
                        Text(userData.user?.company.name ?? "")
                            .font(.headline)
                    }.padding(.leading)
                    .padding(.trailing)
                }
                Spacer()
                Button(action: {
                    self.userData.settingsStore.signedIn = false
                    self.userData.clean()
                    self.presentationMode.wrappedValue.dismiss()

                }) {
                    Text("Log Out")
                }
                Spacer()

            }
    }
}

struct UserInfoView_Previews: PreviewProvider {
    static var previews: some View {
        UserInfoView()
    }
}

