//
//  NetworkService.swift
//  Blog App
//
//  Created by Алексей Перов on 19.09.2019.
//  Copyright © 2019 Алексей Перов. All rights reserved.
//

import Foundation

class NetworkService {
    
    enum HTTPMethods: String {
        case POST
        case PUT
        case GET
        case DELETE
    }
    
    enum APIs: String {
        case posts
        case users
        case comments
    }
    
    private let baseURL = "https://jsonplaceholder.typicode.com/"
    
    func getAllPosts(_ completionHandler: @escaping ([Post]) -> Void) {
        if let url = URL(string: baseURL + APIs.posts.rawValue) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if error != nil {
                    
                } else {
                    if let resp = response as? HTTPURLResponse, resp.statusCode == 200, let responseData = data {
                        
                        print(responseData)
                        let posts = try? JSONDecoder().decode([Post].self, from: responseData)
                        
                        completionHandler(posts ?? [])
                    }
                }
            }.resume()
        }
    }
    
    func postCreatePost(_ post: Post, completionHandler: @escaping (Post) -> Void) {
        guard let url = URL(string: baseURL + APIs.posts.rawValue), let data = try? JSONEncoder().encode(post)
            else { return }
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethods.POST.rawValue
        request.httpBody = data
        request.setValue("\(data.count)", forHTTPHeaderField: "Content-Length")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                print(error?.localizedDescription as Any)
            } else if let resp = response as? HTTPURLResponse, resp.statusCode == 201, let responseData = data {
                let json = try? JSONSerialization.jsonObject(with: responseData)
                print(json as Any)
                if let responsePost = try? JSONDecoder().decode(Post.self, from: responseData) {
                    completionHandler(responsePost)
                }
            }
        }.resume()
    }
    
    func putEditPost(_ post: Post, complitionHandler: @escaping (Post) -> Void) {
        guard let url = URL(string: NSString.path(withComponents: [baseURL, APIs.posts.rawValue, String(post.id)])), let data = try? JSONEncoder().encode(post)
            else { return }
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethods.PUT.rawValue
        request.httpBody = data
        request.setValue("\(data.count)", forHTTPHeaderField: "Content-Length")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                print(error?.localizedDescription as Any)
            } else if let resp = response as? HTTPURLResponse, (200..<300).contains(resp.statusCode), let responseData = data {
                if let responsePost = try? JSONDecoder().decode(Post.self, from: responseData) {
                    complitionHandler(responsePost)
                }
            }
        }.resume()
    }
    
    func deletePost(_ post: Post, completionhandler: @escaping () -> Void) {
        guard let url = URL(string: NSString.path(withComponents: [baseURL, APIs.posts.rawValue, String(post.id)])), let data = try? JSONEncoder().encode(post)
            else { return }
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethods.DELETE.rawValue
        request.httpBody = data
        request.setValue("\(data.count)", forHTTPHeaderField: "Content-Length")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                print(error?.localizedDescription as Any)
            } else if let resp = response as? HTTPURLResponse, (200..<300).contains(resp.statusCode), let _ = data {
                completionhandler()
            }
        }.resume()
    }
    
    func postCreateUser(_ user: User, complitionHandler: @escaping (User) -> Void) {
        guard let url = URL(string: baseURL + APIs.users.rawValue), let data = try? JSONEncoder().encode(user)
            else { return }
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethods.POST.rawValue
        request.httpBody = data
        request.setValue("\(data.count)", forHTTPHeaderField: "Content-Length")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                print(error?.localizedDescription as Any)
            } else if let resp = response as? HTTPURLResponse, (200..<300).contains(resp.statusCode), let responseData = data {
                let json = try? JSONSerialization.jsonObject(with: responseData)
                print(json as Any)
                if let responseUser = try? JSONDecoder().decode(User.self, from: responseData) {
                    complitionHandler(responseUser)
                }
            }
        }.resume()
    }
    
    func putEditUser(_ user: User, complitionhandler: @escaping (User) -> Void) {
        guard let url = URL(string: NSString.path(withComponents: [baseURL, APIs.users.rawValue, String(user.id)])), let data = try? JSONEncoder().encode(user)
            else { return }
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethods.PUT.rawValue
        request.httpBody = data
        request.setValue("\(data.count)", forHTTPHeaderField: "Content-Length")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                print(error?.localizedDescription as Any)
            } else if let resp = response as? HTTPURLResponse, (200..<300).contains(resp.statusCode), let responseData = data {
                if let responseUser = try? JSONDecoder().decode(User.self, from: responseData) {
                    complitionhandler(responseUser)
                }
            }
        }.resume()
    }
    
    func deleteUser(_ user: User, complitionHandler: @escaping () -> Void) {
        guard let url = URL(string: NSString.path(withComponents: [baseURL, APIs.users.rawValue, String(user.id)])), let data = try? JSONEncoder().encode(user)
            else { return }
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethods.DELETE.rawValue
        request.httpBody = data
        request.setValue("\(data.count)", forHTTPHeaderField: "Content-Length")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                print(error?.localizedDescription as Any)
            } else if let resp = response as? HTTPURLResponse, (200..<300).contains(resp.statusCode), let _ = data {
                complitionHandler()
            }
        }
    }
    
    func getUser(byId id: Int, completionHandler: @escaping (User?) -> Void) {
        guard let url = URL(string: NSString.path(withComponents: [baseURL, APIs.users.rawValue, String(id)]))
            else {return}
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        components?.queryItems = [URLQueryItem(name: "id", value: "\(id)")]
        guard let queryURL = components?.url else {return}
        URLSession.shared.dataTask(with: queryURL) { (data, response, error) in
            if error != nil {
                print("error get post by")
            } else if let resp = response as? HTTPURLResponse, resp.statusCode == 200,  let recievedData = data {
                let user = try? JSONDecoder().decode(User.self, from: recievedData)
                completionHandler(user ?? nil)
            }
        }.resume()
    }
    
    func getPosts(byId userId: Int, completionHandler: @escaping ([Post]) -> Void) {
        guard let url = URL(string: baseURL + APIs.posts.rawValue)
            else {return}
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        components?.queryItems = [URLQueryItem(name: "userId", value: "\(userId)")]
        guard let queryURL = components?.url else {return}
        URLSession.shared.dataTask(with: queryURL) { (data, response, error) in
            if error != nil {
                print("error get post by")
            } else if let resp = response as? HTTPURLResponse, resp.statusCode == 200,  let recievedData = data {
                let posts = try? JSONDecoder().decode([Post].self, from: recievedData)
                completionHandler(posts ?? [])
            }
        }.resume()
    }
    
    func getComments(byPostId postId: Int, _ completionHandler: @escaping ([Comment]) -> Void) {
        guard let url = URL(string: baseURL + APIs.comments.rawValue)
            else {return}
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        components?.queryItems = [URLQueryItem(name: "postId", value: "\(postId)")]
        guard let queryURL = components?.url
            else {return }
        URLSession.shared.dataTask(with: queryURL) { (data, response, error) in
            if error != nil {
                print("error")
            } else if let resp = response as? HTTPURLResponse, (200..<300).contains(resp.statusCode), let recievedData = data {
                let comments = try? JSONDecoder().decode([Comment].self, from: recievedData)
                completionHandler(comments ?? [])
            }
        }.resume()
    }
    func postCreateComment(_ comment: Comment, completionHandler: @escaping (Comment) -> Void) {
        guard let url = URL(string: baseURL + APIs.comments.rawValue), let data = try? JSONEncoder().encode(comment)
            else { return }
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethods.POST.rawValue
        request.httpBody = data
        request.setValue("\(data.count)", forHTTPHeaderField: "Content-Length")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                print(error?.localizedDescription as Any)
            } else if let resp = response as? HTTPURLResponse, resp.statusCode == 201, let responseData = data {
                let json = try? JSONSerialization.jsonObject(with: responseData)
                print(json as Any)
                if let responseComment = try? JSONDecoder().decode(Comment.self, from: responseData) {
                    completionHandler(responseComment)
                }
            }
            }.resume()
    }
    
    func putEditComment(_ comment: Comment, complitionHandler: @escaping (Comment) -> Void) {
        guard let url = URL(string: NSString.path(withComponents: [baseURL, APIs.comments.rawValue, String(comment.id)])), let data = try? JSONEncoder().encode(comment)
            else { return }
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethods.PUT.rawValue
        request.httpBody = data
        request.setValue("\(data.count)", forHTTPHeaderField: "Content-Length")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                print(error?.localizedDescription as Any)
            } else if let resp = response as? HTTPURLResponse, (200..<300).contains(resp.statusCode), let responseData = data {
                if let responseComment = try? JSONDecoder().decode(Comment.self, from: responseData) {
                    complitionHandler(responseComment)
                }
            }
            }.resume()
    }
    
    func deleteComment(_ comment: Comment, completionhandler: @escaping () -> Void) {
        guard let url = URL(string: NSString.path(withComponents: [baseURL, APIs.comments.rawValue, String(comment.id)])), let data = try? JSONEncoder().encode(comment)
            else { return }
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethods.DELETE.rawValue
        request.httpBody = data
        request.setValue("\(data.count)", forHTTPHeaderField: "Content-Length")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                print(error?.localizedDescription as Any)
            } else if let resp = response as? HTTPURLResponse, (200..<300).contains(resp.statusCode), let _ = data {
                completionhandler()
            }
            }.resume()
    }
    
    func getAllUsers(_ completionHandler: @escaping ([User]) -> Void) {
        if let url = URL(string: "https://jsonplaceholder.typicode.com/users") {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    
                } else {
                    if let resp = response as? HTTPURLResponse, (200..<300).contains(resp.statusCode), let responseData = data {
                        print(responseData)
                        let users = try? JSONDecoder().decode([User].self, from: responseData)
                        completionHandler(users ?? [])
                    }
                }
                
            }.resume()
        }
    }
}
