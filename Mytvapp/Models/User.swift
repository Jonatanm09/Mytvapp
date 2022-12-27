//
//  User.swift
//  Mytvapp
//
//  Created by Jonatan Mendez on 20/12/22.
//

struct User: Codable {
    var userName: String
    var password: String
    var token: String
    
    enum CodingKeys: String, CodingKey {
        case userName = "username"
        case password = "password"
        case token = "request_token"
    }
}
