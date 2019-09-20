//
//  AddingPostsForm.swift
//  Blog App
//
//  Created by Алексей Перов on 18.09.2019.
//  Copyright © 2019 Алексей Перов. All rights reserved.
//

import SwiftUI
import Combine

struct MultilineTextView: UIViewRepresentable {
    @Binding var text: String

    func makeUIView(context: Context) -> UITextView {
        let view = UITextView()
        view.font = UIFont.preferredFont(forTextStyle: .body)
        view.isScrollEnabled = true
        view.isEditable = true
        view.isUserInteractionEnabled = true
        return view
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
    }
}

struct AddingPostsForm: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var userData: UserData
    @State private var postTitle: String = ""
    @State private var postBody: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text: $postTitle)
                MultilineTextView(text: $postBody).frame(height: 300)
            }.padding(.bottom)
                .navigationBarTitle("Add Post", displayMode: .inline)
                .navigationBarItems(leading: Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Cancel")
                    }, trailing: Button(action: {
                        let id = self.userData.user?.id
                        guard let anID = id else { return }
                        NetworkService().postCreatePost(Post(userId: anID, title: self.postTitle, body: self.postBody)) { (post) in
                            DispatchQueue.main.async {
                                self.userData.posts.append(post)
                            }
                        }
                        print("\(self.postBody) \(self.postTitle)")
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Done")
                })
        }
    }
}

struct AddingPostsForm_Previews: PreviewProvider {
    static var previews: some View {
        AddingPostsForm()
    }
}

