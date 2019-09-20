//
//  ContentView.swift
//  Blog App
//
//  Created by Алексей Перов on 18.09.2019.
//  Copyright © 2019 Алексей Перов. All rights reserved.
//

import SwiftUI
import Combine

struct ContentView: View {
    @EnvironmentObject var userData: UserData
    @State private var showModal = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(userData.posts) { post in
                    NavigationLink(destination: DetailView(post: post)) {
                        PostRow(post: post)
                    }
                }.onDelete(perform: delete)
                .onMove(perform: move)
            }
            .navigationBarTitle("My Posts", displayMode: .large)
            .navigationBarItems(leading: UserInfoButton(showModal: $showModal), trailing: AddPostButton(showModal: $showModal))
            .navigationBarBackButtonHidden(true)
            
        }
    }
    
    func delete(at offsets: IndexSet) {
        for index in offsets {
            NetworkService().deletePost(userData.posts[index]) {
                DispatchQueue.main.async {
                    self.userData.posts.remove(atOffsets: offsets)
                }
            }
        }
    }
    func move(from fromOffests: IndexSet, to toOffest: Int) {
        userData.posts.move(fromOffsets: fromOffests, toOffset: toOffest)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(UserData(userId: 2))
    }
}

struct AddPostButton: View {
    @EnvironmentObject var userData: UserData
    @Binding var showModal: Bool
    
    var body: some View {
        Button(action: {
            self.showModal = true
        }) {
            Image(systemName: "square.and.pencil")
                .font(.headline)
        }.sheet(isPresented: self.$showModal, onDismiss: {
            print("dismiss")
        }) {
            UserInfoView().environmentObject(self.userData)
        }
    }
}

struct UserInfoButton: View {
    @EnvironmentObject var userData: UserData
    @Binding var showModal: Bool
    
    let image = Image("UserPhotoPlaceholder")
    
    var body: some View {
        Button(action: {
            self.showModal = true
        }) {
            CircleImage(image: image)
                .frame(width: 34, height: 34)
        }.sheet(isPresented: self.$showModal, onDismiss: {
            print("dismiss")
        }) {
            AddingPostsForm().environmentObject(self.userData)
        }
    }
}
